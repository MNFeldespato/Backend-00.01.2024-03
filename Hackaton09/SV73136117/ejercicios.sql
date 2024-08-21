-- 2 Seleccionar los proveedores que viven en la ciudad de "BERLIN"
select * from Suppliers
where City = 'BERLIN'

-- 3.  Seleccionar los empleados con código 3,5 y 8

select * from Employees
where EmployeeID in (3, 5, 8);

-- 4.  Seleccionar los productos que tienen stock mayor que cero y son del proveedor 1,3 y 5

select * from Products
where UnitsInStock > 0 and SupplierID in (1, 3, 5);

-- 5.  Seleccionar los productos con precio mayor o igual a 20 y menor o igual a 90

select * from Products
where UnitPrice >= 20 and UnitPrice <= 90;

-- 6.  Mostrar las órdenes de compra entre las fechas 01/01/1997 al 15/07/1997

select * from Orders
where OrderDate between '1997/01/01' and '1997/07/15';

-- 7.  Mostrar las órdenes de compra hechas en el año 1997, que pertenecen a los empleados con códigos 1 ,3 ,4 ,8

select * from Orders
where year(OrderDate) = 1997 and EmployeeID in (1, 3, 4, 8);

-- 8.  Mostrar las ordenes hechas en el año 1996

select * from Orders
where year(OrderDate) = 1996;

-- 9.  Mostrar las ordenes hechas en el año 1997 ,del mes de abril

select * from Orders
where year(OrderDate) = 1997 and month(OrderDate) = 04;

-- 10. Mostrar las ordenes hechas el primero de todos los meses, del año 1998

select * from Orders
where year(OrderDate) = 1998 and day(OrderDate) = 01;

-- 11. Mostrar todos los clientes que no tienen fax

select * from Customers
where Fax is null;

-- 12. Mostrar todos los clientes que tienen fax

select * from Customers
where Fax is not null;

-- 13. Mostrar el nombre del producto, el precio, el stock y el nombre de la categoría a la que pertenece.

select p.ProductName, p.UnitPrice, p.UnitsInStock, c.CategoryName
from Products p
join Categories c on p.CategoryID = c.CategoryID;

-- 14. Mostrar el nombre del producto, el precio producto, el código del proveedor y el nombre de la compañía proveedora.

select p.ProductName, p.UnitPrice, s.SupplierID, s.CompanyName
from Products p
join Suppliers s on p.SupplierID = s.SupplierID;

-- 15. Mostrar el número de orden, el código del producto, el precio, la cantidad y el total pagado por producto.

select od.OrderID, od.ProductID, od.UnitPrice, od.Quantity, (od.UnitPrice * od.Quantity) as TotalPagado
from [Order Details] od;

-- 16. Mostrar el número de la orden, fecha, código del producto, precio, código del empleado y su nombre completo.

select od.OrderID, o.OrderDate, od.ProductID, od.UnitPrice, o.EmployeeID, (e.FirstName + ' ' + e.LastName) as NombreCompleto
from [Order Details] od
join Orders o on od.OrderID = o.OrderID
join Employees e on o.EmployeeID = e.EmployeeID

-- 17. Mostrar los 10 productos con menor stock.

select top 10 ProductName, UnitsInStock
from Products 
order by UnitsInStock asc;

-- 18. Mostrar los 10 productos con mayor stock.

select top 10 ProductName, UnitsInStock
from Products 
order by UnitsInStock desc;

-- 19. Mostrar los 10 productos con menor precio.

select top 10 ProductName, UnitPrice
from Products 
order by UnitPrice asc;

-- 20. Mostrar los 10 productos con mayor precio.

select top 10 ProductName, UnitPrice
from Products 
order by UnitPrice desc;

-- 21. Mostrar los 10 productos más baratos

select top 10 ProductName, UnitPrice
from Products 
order by UnitPrice asc;

-- 22. Mostrar los 10 productos más caros

select top 10 ProductName, UnitPrice
from Products 
order by UnitPrice desc;

-- 23. Seleccionar todos los campos de la tabla clientes,ordenar por compania

select * from Customers
order by CompanyName

-- 24. Seleccionar todos los campos de clientes,cuya compania empiece con la letra B y pertenezcan a UK ,ordenar por nombre de la compania

select * from Customers
where CompanyName like 'B%' and Country = 'UK'
order by CompanyName

-- 25 Seleccionar todos los campos de productos de las categorias 1,3 y 5, ordenar por categoria

select * from Products
where CategoryID in (1, 3, 5)
order by CategoryID

-- 26. Seleccionar los productos cuyos precios unitarios estan entre 50 y 200

select * from Products
where UnitPrice between 50 and 200;

-- 27. Visualizar el nombre y el id de la compania del cliente,fecha,precio unitario y producto de la orden

select c.CompanyName, c.CustomerID, o.OrderDate, od.UnitPrice, p.ProductName
from Orders o
join Customers c on o.CustomerID = c.CustomerID
join [Order Details] od on o.OrderID = od.OrderID
join Products p on od.ProductID = p.ProductID;

-- 28. Visualizar el nombre de la categoria y el numero de productos que hay por cada categoria.

select c.CategoryName, count(p.ProductID) as NumeroDeProductos
from Categories c
join Products p on c.CategoryID = p.CategoryID
group by c.CategoryName
order by NumeroDeProductos;
 
-- 29. Seleccionar los 5 productos mas vendidos

select top 5 sum(od.Quantity) as TotalVendido, p.ProductName
from [Order Details] od
join Products p on od.ProductID = p.ProductID
group by p.ProductName
order by TotalVendido

-- 30. Seleccionar los jefes de los empleados

select (e.FirstName + ' ' + e.LastName) as Empleado, (m.FirstName + ' ' + m.LastName) as Encargado
from Employees e
left join Employees m on e.ReportsTo = m.EmployeeID

-- 31. Obtener todos los productos cuyo nombre comienzan con M y tienen un precio comprendido entre 28 y 129

select p.ProductName, p.UnitPrice
from Products p
where ProductName like 'M%' and UnitPrice between '28' and '129'
order by p.UnitPrice

-- 32. Obtener todos los clientes del Pais de USA,Francia y UK

select c.ContactName, c.Country
from Customers c
where c.Country in ('USA', 'France', 'UK')
order by c.Country

-- 33. Obtener todos los productos descontinuados o con stock cero.

select p.ProductName, p.UnitsInStock, p.Discontinued
from Products p
where p.UnitsInStock = 0 or p.Discontinued = 1

-- 34. Obtener todas las ordenes hechas por el empleado King Robert

select o.OrderID, e.FirstName, e.LastName, e.EmployeeID
from Orders o
join Employees e on o.EmployeeID = e.EmployeeID
where e.FirstName = 'Robert' and e.LastName = 'King'

-- 35. Obtener todas las ordenes por el cliente cuya compania es "Que delicia"

select * from Orders o
join Customers c on o.CustomerID = c.CustomerID
where c.CompanyName = 'Que Delícia'

-- 36. Obtener todas las ordenes hechas por el empleado King Robert,Davolio Nancy y Fuller Andrew

select e.FirstName, e.LastName, COUNT(o.OrderID) as OrdenesTotales from Orders o
join Employees e on o.EmployeeID = e.EmployeeID
where e.FirstName in ('Robert', 'Nancy', 'Andrew') and e.LastName in ('King', 'Davolio', 'Fuller') 
group by e.FirstName, e.LastName
order by OrdenesTotales

-- 37. Obtener todos los productos(codigo,nombre,precio,stock) de la orden 10257

select od.ProductID, p.ProductName, od.UnitPrice, p.UnitsInStock
from [Order Details] od
join Products p on od.ProductID = p.ProductID
where OrderID = 10257

-- 38. Obtener todos los productos(codigo,nombre,precio,stock) de las ordenes hechas desde 1997 hasta la fecha de hoy.

select od.ProductID, p.ProductName, od.UnitPrice, p.UnitsInStock, o.OrderDate
from [Order Details] od
join Products p on od.ProductID = p.ProductID
join Orders o on od.OrderID = o.OrderID
where o.OrderDate between '1997' and '2022'

-- 39. Calcular los 15 productos mas caros

select top 15 ProductID, ProductName, UnitPrice from Products
order by UnitPrice desc 

-- 40 Calcular los 5 productos mas baratos

select top 5 ProductID, ProductName, UnitPrice from Products
order by UnitPrice asc 

-- 41. Obtener el nombre de todas las categorias y los nombres de sus productos,precio y stock.

select c.CategoryName,
		STRING_AGG(p.ProductName, ' ') as Productos,
		STRING_AGG(CAST(p.UnitPrice as varchar), ' ') as Precios,
		STRING_AGG(CAST(p.UnitsInStock as varchar), ' ') as Unidades
from Products p
join Categories c on p.CategoryID = c.CategoryID
group by c.CategoryName

-- 42. Obtener el nombre de todas las categorias y los nombres de sus productos,solo los productos que su nombre no comience con la letra P

select c.CategoryName,
		STRING_AGG(p.ProductName, ' ') as Productos
from Products p
join Categories c on p.CategoryID = c.CategoryID
where p.ProductName not like 'P%'
group by c.CategoryName

-- 43. Calcular el stock de productos por cada categoria.Mostrar el nombre de la categoria y el stock por categoria.

select c.CategoryName, SUM(p.UnitsInStock) as Stock
from Categories c
join Products p on c.CategoryID = p.CategoryID
group by c.CategoryName
order by Stock

-- 44. Obtener el Nombre del cliente,Nombre del Proveedor,Nombre del empleado y el nombre de los productos que estan en la orden 10794

select c.CompanyName as NombreCliente, s.CompanyName as NombreProveedor, (e.FirstName +' '+ e.LastName) as Employee, p.ProductName 
from Orders o
join Customers c on o.CustomerID = c.CustomerID
join Employees e on o.EmployeeID = e.EmployeeID
join [Order Details] od on o.OrderID = od.OrderID
join Products p on od.ProductID = p.ProductID
join Suppliers s on p.SupplierID = s.SupplierID
where o.OrderID = 10794

-- 45. Mostrar el numero de ordenes de cada uno de los clientes por año,luego ordenar codigo del cliente y el año.

select o.CustomerID, YEAR(o.OrderDate) as Año, COUNT(o.OrderID) as ordenes
from Orders o
group by o.CustomerID, YEAR(o.OrderDate)
order by o.CustomerID, Año;

-- 46. Contar el numero de ordenes que se han realizado por años y meses ,luego debe ser ordenado por año y por mes.

select year(o.OrderDate) as Año, MONTH(o.OrderDate) as Mes, COUNT(o.OrderID) as ordenes
from Orders o
group by year(o.OrderDate), MONTH(o.OrderDate)
order by Año, Mes

-- 47. Seleccionar el nombre de la compañía del cliente,él código de la orden de compra,la fecha de la orden de compra, código del producto, cantidad pedida del producto,nombre del producto, el nombre de la compañía proveedora y la ciudad del proveedor ,usar Join

select c.CompanyName, c.ContactName, o.OrderId, o.OrderDate, od.ProductID, od.Quantity, p.ProductName, s.CompanyName, s.City
from Orders o
join Customers c on o.CustomerID = c.CustomerID 
join [Order Details] od on o.OrderID = od.OrderID
join Products p on od.ProductID = p.ProductID
join Suppliers s on p.SupplierID = s.SupplierID

-- 48. Seleccionar el nombre de la compañía del cliente, nombre del contacto, el código de la orden de compra, la fecha de la orden de compra, el código del producto,cantidad pedida del producto, nombre del producto y el nombre de la compañía proveedora, usas JOIN.Solamente las compañías proveedoras que comienzan con la letra de la A hasta la letra G,además la cantidad pedida del producto debe estar entre 23 y 187.

select c.CompanyName, c.ContactName, o.OrderId, o.OrderDate, od.ProductID, od.Quantity, p.ProductName, s.CompanyName
from Orders o
join Customers c on o.CustomerID = c.CustomerID 
join [Order Details] od on o.OrderID = od.OrderID
join Products p on od.ProductID = p.ProductID
join Suppliers s on p.SupplierID = s.SupplierID
where c.CompanyName like '[A-G]%' and od.Quantity between 23 and 187
order by c.CompanyName