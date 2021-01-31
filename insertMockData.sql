INSERT INTO public.admin(
    adminid, username, password, employeeid)
    VALUES (1, johndoe, johnpass, 1);
INSERT INTO public.category(
    categoryid, categoryname)
    VALUES (1, tools);
INSERT INTO public.contains(
    storeid, productid)
    VALUES (1, 1);
INSERT INTO public.customer(
    customerid, email, password)
    VALUES (1, jane@gmail.com, janepass);
INSERT INTO public.employee(
    employeeid, firstname, lastname, ssn, title, storeid)
    VALUES (1, John, Doe, 444-55-6666, Administrator, 1);
INSERT INTO public.product(
    productid, productprice, productname, productlocation, categoryid)
    VALUES (1, 2.77, Drill, A27, 1);
INSERT INTO public.region(
    regionid, regionname, storeid)
    VALUES (1, US-West, 1);
INSERT INTO public.sales_transaction(
    purchasedate, transactionid, customerid)
    VALUES (1/30/2021, 1, 1);
INSERT INTO public.soldvia(
    noofitems, transactionid, productid)
    VALUES (2, 1, 1);
INSERT INTO public.view(
    productid, customerid)
    VALUES (1, 1);
INSERT INTO public.warehouse(
    storeid, storezip
)    VALUES (1, 84604)
