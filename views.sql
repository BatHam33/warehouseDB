/*This view will make it easy to group items by their location. 
From here, we can easily pull information about a different product.
Saved as location_group_order*/
CREATE VIEW location_group_order AS
SELECT productlocation,  productname FROM product
GROUP BY productlocation, productname;

/*list all products to use in the search function*/
SELECT productname, productprice, categoryname FROM product
INNER JOIN category ON category.categoryid=product.categoryid;

/*The following views will all all items from a given category to be agregated.
list_all_food*/
CREATE VIEW list_all_food AS
SELECT productname, productprice, categoryname FROM product
INNER JOIN category ON category.categoryid=product.categoryid
WHERE categoryname='food';

/*list_all_furniture*/
CREATE VIEW list_all_furniture AS
SELECT productname, productprice, categoryname FROM product
INNER JOIN category ON category.categoryid=product.categoryid
WHERE categoryname='furniture';

/*list_all_clothing*/
CREATE VIEW list_all_clothing AS
SELECT productname, productprice, categoryname FROM product
INNER JOIN category ON category.categoryid=product.categoryid
WHERE categoryname='clothing';

/*list_all_auto*/
CREATE VIEW list_all_auto AS
SELECT productname, productprice, categoryname FROM product
INNER JOIN category ON category.categoryid=product.categoryid
WHERE categoryname='auto';

/*list_all_garden*/
CREATE VIEW list_all_garden AS
SELECT productname, productprice, categoryname FROM product
INNER JOIN category ON category.categoryid=product.categoryid
WHERE categoryname='garden';

/*list_all_pharmacy*/
CREATE VIEW list_all_pharmacy AS
SELECT productname, productprice, categoryname FROM product
INNER JOIN category ON category.categoryid=product.categoryid
WHERE categoryname='pharmacy';