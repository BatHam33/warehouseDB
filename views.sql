/*This view will make it easy to group items by their location. 
From here, we can easily pull information about a different product.
Saved as location_group_order*/
SELECT productlocation,  productname FROM product
GROUP BY productlocation, productname;
