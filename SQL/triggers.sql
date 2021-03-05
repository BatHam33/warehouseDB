/*function and trigger to delete related admin account when when a user account is deleted*/
CREATE OR REPLACE FUNCTION remove_old_admin()
  RETURNS trigger AS
$$
BEGIN
    DELETE FROM admin
    WHERE admin.employeeid = OLD.employeeid;
RETURN NEW;
END;

$$
LANGUAGE 'plpgsql';

CREATE TRIGGER delete_admin
    AFTER DELETE 
    ON employee
    FOR EACH ROW 
    EXECUTE PROCEDURE remove_old_admin();

/*trigger to delete products from a store when the store is deleted*/
CREATE OR REPLACE FUNCTION remove_store_prods()
  RETURNS trigger AS
$$
BEGIN
        DELETE FROM contains
        WHERE contains.storeid=OLD.storeid;
RETURN NEW;
END;

$$
LANGUAGE 'plpgsql';

CREATE TRIGGER delete_products
    AFTER DELETE 
    ON warehouse
    FOR EACH ROW 
    EXECUTE PROCEDURE remove_store_prods();


/*trigger to delete category from products when the category is deleted*/
CREATE OR REPLACE FUNCTION remove_category()
  RETURNS trigger AS
$$
BEGIN
        DELETE FROM category
        WHERE category.categoryid=OLD.categoryid;
RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
CREATE TRIGGER delete_category
    AFTER DELETE
    ON product
    FOR EACH ROW
    EXECUTE PROCEDURE remove_category();