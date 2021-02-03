DELETE FROM public.admin(
    WHERE adminid = 1);
DELETE FROM public.category(
    WHERE categoryid= 1);
DELETE FROM public.contains(
    WHERE storeid = 1);
DELETE FROM public.customer(
    WHERE customerid = 1);
DELETE FROM public.employee(
    WHERE employeeid = 1);
DELETE FROM public.product(
    WHERE productid = 1);
DELETE FROM public.region(
    WHERE regionid = 1);
DELETE FROM public.sales_transaction(
    WHERE transactionid = 1);
DELETE FROM public.soldvia(
    WHERE transactionid = 1);
DELETE FROM public.view(
    WHERE customerid = 1);
DELETE FROM public.warehouse(
    WHERE storeid = 1);
