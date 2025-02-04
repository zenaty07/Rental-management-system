
--CREATE TenantDeleteLog TABLE
CREATE TABLE TenantDeleteLog
(
	LogID INT IDENTITY PRIMARY KEY,
	Tenant_id int,
	FirstName nvarchar(100),
	LastName nvarchar(100),
	Phone nchar(15),
	BirthDate date,
	Salary float
)

--CREATE AFTER DELETE TENANT
CREATE TRIGGER trg_AfterDeleteTenant on Tenant
AFTER DELETE
AS 
BEGIN
	INSERT INTO TenantDeleteLog (Tenant_id, FirstName, LastName, Phone, BirthDate, Salary)
	SELECT Tenant_id, FirstName, LastName, Phone, BirthDate, Salary FROM deleted
END

SELECT * FROM Tenant

SELECT * FROM TenantDeleteLog

DELETE Tenant
WHERE Tenant_id = 1049