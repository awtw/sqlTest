SELECT SUM(P.ListPrice * I.Quantity)
FROM Production.Product P
INNER JOIN Production.ProductInventory I
ON P.ProductID = I.ProductID
WHERE P.ListPrice > 0
---
SELECT MAX(ListPrice)
FROM Production.Product
---
SELECT AVG(Freight)
FROM Sales.SalesOrderHeader
WHERE TerritoryID = 4
---
SELECT COUNT(MiddleName)
FROM Person.Person
---
SELECT ST.Name AS TerritoryName, COUNT(*) AS SalesCount
FROM Sales.SalesOrderHeader SOH
LEFT OUTER JOIN Sales.SalesTerritory ST
ON SOH.TerritoryID = ST.TerritoryID
WHERE OrderDate BETWEEN '7/1/2005' AND '12/21/2006'
GROUP BY ST.Name
---
SELECT Color, COUNT(*) AS ProductCount
FROM Production.Product
WHERE Color IN ('Red','Black')
GROUP BY Color
----
SELECT 
	P.Name,
	P.ListPrice,
	SC.Name AS ProdcutSubcategoryName,
	C.Name AS ProductCategoryName
FROM Production.Product P
LEFT OUTER JOIN Production.ProductSubcategory SC
ON SC.ProductSubcategoryID = P.ProductSubcategoryID
LEFT OUTER JOIN Production.ProductCategory C
ON C.ProductCategoryID = SC.ProductCategoryID
ORDER BY ProductCategoryName DESC, ProdcutSubcategoryName ASC
---
SELECT 
	P.FirstName,
	P.LastName,
	PP.PasswordHash
FROM Person.Person P
INNER JOIN Person.[Password] PP
ON PP.BusinessEntityID = P.BusinessEntityID
---
SELECT 
	E.BusinessEntityID,
	E.NationalIDNumber,
	E.JobTitle,
	EDH.DepartmentID,
	EDH.StartDate,
	EDH.EndDate
FROM HumanResources.Employee E
INNER JOIN HumanResources.EmployeeDepartmentHistory EDH
ON E.BusinessEntityID = EDH.BusinessEntityID
WHERE EndDate > ''
---
SELECT
	P.FirstName,
	P.LastName,
	PP.PasswordHash,
	E.EmailAddress
FROM Person.Person P
INNER JOIN Person.[Password] PP
ON PP.BusinessEntityID = P.BusinessEntityID
INNER JOIN Person.EmailAddress E
ON E.BusinessEntityID = P.BusinessEntityID
---
SELECT *
FROM Person.Person P
FULL OUTER JOIN Person.EmailAddress E
ON P.BusinessEntityID = E.BusinessEntityID
---
SELECT *
FROM (
	SELECT BusinessEntityID, NationalIDNumber, BirthYear, YEAR(HireDate) AS HireDate
	FROM (
		SELECT BusinessEntityID, NationalIDNumber, YEAR(BirthDate) AS BirthYear, HireDate
		FROM HumanResources.Employee
	) AS InnerNested
	WHERE BirthYear < 1960
) AS OuterNested
WHERE HireDate > 2004
---
 SELECT
	SalesCurrentYear.SalesYear,
	SalesCurrentYear.TotalSales AS AnnualSales,
	SalesPriorYear.TotalSales AS PriorYearSales
 FROM (
	SELECT YEAR(OrderDate) AS SalesYear, SUM(TotalDue) AS TotalSales
	FROM Sales.SalesOrderHeader
	GROUP BY YEAR(OrderDate)
	) AS SalesCurrentYear
LEFT OUTER JOIN(
	SELECT YEAR(OrderDate) AS SalesYear, SUM(TotalDue) AS TotalSales
	FROM Sales.SalesOrderHeader
	GROUP BY YEAR(OrderDate)
	) AS SalesPriorYear
ON SalesCurrentYear.SalesYear -1 = SalesPriorYear.SalesYear
ORDER BY SalesYear
---
WITH SalesByYear
AS (
	SELECT YEAR(OrderDate) AS SalesYear, SUM(TotalDue) AS TotalSales
	FROM Sales.SalesOrderHeader
	GROUP BY YEAR(OrderDate)
) 
SELECT 
	CurrentYear.SalesYear,
	CurrentYear.TotalSales AS AnnualSales,
	PriorYear.TotalSales AS PriorSales
FROM SalesByYear AS CurrentYear
LEFT OUTER JOIN SalesByYear AS PriorYear
ON PriorYear.SalesYear = CurrentYear.SalesYear -1
ORDER BY SalesYear
---
SELECT 
	COALESCE(FirstName+ ' '+' '+MiddleName+ ' '+LastName,
	FirstName+ ' '+LastName) AS FullName
FROM Person.Person
---
SELECT 
	COALESCE(MiddleName, 'No Middle Name Listed') AS MiddleName
FROM Person.Person
---
SELECT
	CAST(FirstName AS VARCHAR)
FROM Person.Person
---
SELECT
	CAST(FirstName AS VARCHAR(10))
FROM Person.Person
---
SELECT Name
FROM Production.Product
WHERE Name LIKE '[acbd]%'