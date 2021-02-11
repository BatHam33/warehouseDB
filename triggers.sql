CREATE TRIGGER delete_Admin
    AFTER DELETE 
    ON employee
    FOR EACH ROW 
    BEGIN
    DELETE FROM admin
        WHERE admin.employeeid = old.employeeid
    end

