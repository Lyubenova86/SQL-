#https://www.w3schools.com/sql/trysql.asp?filename=trysql_desc

#1. Show all rows for Customers
       SELECT * FROM Customers 
       
    #2. Show only Contact name information for Customers
       SELECT ContactName FROM Customers
       
   # 3. Show all unique combinations between Cities and Countries for the customers
       SELECT DISTINCT Country, City FROM Customers
       
    # 4. Insert 3 new Customers
        INSERT INTO Customers (CustomerName, Address, City, PostalCode, Country) 
       VALUES  ('Martin Mihov', 'ul.Samara', 'Sofia', '1000', 'Bulgaria'),
	('Ivan Stoqnov', 'ul.Hristo Botev', 'Plovdiv', '1514', 'Bulgaria'),
    	('Viktor Petrov', 'ul.Hadji Dimitur', 'Varna', '2000', 'Bulgaria');

    #5. Move all orders made by Andrew Fuller to Nancy Davolio
#Move all orders made by Andrew Fuller to Nancy Davolio

UPDATE Orders
SET EmployeeID=2
WHERE EmployeeID=1
#OR
 UPDATE Orders
 SET EmployeeID= (select EmployeeID from Employees where  FirstName='Andrew')
where EmployeeID = (select EmployeeID from Employees where FirstName='Nancy')
#OR
update Orders
set EmployeeID= (select EmployeeID=2 from Employees)
where EmployeeID = (select EmployeeID=1 from Employees)

    #6. Group all products by category and show category name
--Group all products by category and show category name
select Products.ProductName, Categories.CategoryName, 

Products.CategoryID	 
FROM Categories 
INNER join Products 
on Products.CategoryID = Categories.CategoryID
GROUP BY Products.ProductName
ORDER BY Categories.CategoryName

    #7. Sort all employees by Last Name and delete the last one. Do not forget to move all his/her orders to another colleague
       
UPDATE Orders
SET EmployeeID= (select EmployeeID from Employees where LastName='Dodsworth')
WHERE EmployeeID = (select EmployeeID from Employees where LastName='West')

   # 8. Show all customers without orders
SELECT Customers.CustomerName, Customers.CustomerID, Orders.OrderID
FROM Customers 
LEFT JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID
ORDER BY Customers.CustomerName

  #  9. Show all products including 'ch' in its name with price between 10 and 20
       
     SELECT * FROM Products
     WHERE ProductName LIKE '%ch%' AND Price BETWEEN 10 AND 20

SELECT products.ProductName, products.Price from Products
WHERE ProductName like '%ch%' AND Price between 10 and 20
       
  #  10.  Group all products from 9 by category and sort by count in descending order
       
       SELECT * FROM Products
       WHERE ProductName LIKE '%ch%' AND Price BETWEEN 10 AND 20
       ORDER BY CategoryID DESC