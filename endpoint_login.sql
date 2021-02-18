-- Setup JWT generation
CREATE EXTENSION IF NOT EXISTS pgcrypto;

DROP TYPE IF EXISTS jwt_token CASCADE;
CREATE TYPE jwt_token AS (
  token text
);

CREATE OR REPLACE FUNCTION url_encode(data bytea) RETURNS text LANGUAGE sql AS $$
    SELECT translate(encode(data, 'base64'), E'+/=\n', '-_');
$$;

CREATE OR REPLACE FUNCTION algorithm_sign(signables text, secret text, algorithm text)
RETURNS text LANGUAGE sql AS $$
WITH
  alg AS (
    SELECT CASE
      WHEN algorithm = 'HS256' THEN 'sha256'
      WHEN algorithm = 'HS384' THEN 'sha384'
      WHEN algorithm = 'HS512' THEN 'sha512'
      ELSE '' END AS id)
SELECT url_encode(hmac(signables, secret, alg.id)) FROM alg;
$$;

/*Create login endpoint for admins*/
CREATE OR REPLACE FUNCTION sign(payload json, secret text, algorithm text DEFAULT 'HS256')
RETURNS text LANGUAGE sql AS $$
WITH
  header AS (
    SELECT url_encode(convert_to('{"alg":"' || algorithm || '","typ":"JWT"}', 'utf8')) AS data
    ),
  payload AS (
    SELECT url_encode(convert_to(payload::text, 'utf8')) AS data
    ),
  signables AS (
    SELECT header.data || '.' || payload.data AS data FROM header, payload
    )
SELECT
    signables.data || '.' ||
    algorithm_sign(signables.data, secret, algorithm) FROM signables;
$$;
--

CREATE OR REPLACE FUNCTION
signup(employeeid int, username text, password text) RETURNS VOID
AS $$
  INSERT INTO admin (employeeid, username, password) VALUES
    (signup.employeeid, signup.username, signup.password);
$$ LANGUAGE sql SECURITY DEFINER;


CREATE OR REPLACE FUNCTION
login(username TEXT, password TEXT) RETURNS jwt_token
  LANGUAGE plpgsql SECURITY DEFINER
  AS $$
DECLARE
  _role NAME;
  result jwt_token;
BEGIN
  SELECT admin.adminid FROM admin WHERE admin.username=login.username AND password=login.password INTO _role;
  IF _role IS NULL THEN
    RAISE invalid_password USING message = 'invalid user or password';
  END IF;

  SELECT sign(
      row_to_json(r), current_setting('app.settings.jwt_secret')
    ) AS token
    from (
      SELECT 'admins' AS role, login.username AS username, _role AS adminid,
         extract(epoch from now())::integer + 3600*60*60 as exp
    ) r
    INTO result;

  RETURN result;
END;
$$

/*Anyone can login*/
GRANT EXECUTE ON FUNCTION
  login(text,text),
  signup(int, text, text)
  TO anonymous;

/*login endpoint for customers*/

CREATE OR REPLACE FUNCTION
signup_customer(email text, password text) RETURNS VOID
AS $$
  INSERT INTO customer (email, password) VALUES
    (signup.email, signup.password);
$$ LANGUAGE sql SECURITY DEFINER;


CREATE OR REPLACE FUNCTION
login_customer(email TEXT, password TEXT) RETURNS jwt_token
  LANGUAGE plpgsql SECURITY DEFINER
  AS $$
DECLARE
  _role NAME;
  result jwt_token;
BEGIN
  SELECT customer.customerid FROM customer WHERE customer.username=login.username AND password=login.password INTO _role;
  IF _role IS NULL THEN
    RAISE invalid_password USING message = 'invalid user or password';
  END IF;

  SELECT sign(
      row_to_json(r), current_setting('app.settings.jwt_secret')
    ) AS token
    from (
      SELECT 'anonymous' AS role, login.username AS username, _role AS customerid,
         extract(epoch from now())::integer + 3600*60*60 as exp
    ) r
    INTO result;

  RETURN result;
END;
$$

GRANT EXECUTE ON FUNCTION
  login_customer(text,text),
  signup_customer(int, text, text)
  TO anonymous;