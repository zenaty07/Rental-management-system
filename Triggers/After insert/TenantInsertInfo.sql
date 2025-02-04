-- CREATING TABLE FOR AFTER INSERT TRIGGER TO PAYMENT 
CREATE TABLE TenantInsertInfo
(
	LogId int IDENTITY PRIMARY KEY,
	Tenant_id int,
	First_name nvarchar(100),
	Last_name nvarchar(100),
	Phone nchar(15),
	BirthDate date,
	Salary float,
	InsertDateTime DATETIME DEFAULT GETDATE()
)

-- AFTER INSERT TRIGGER Leasing_info table
CREATE TRIGGER trg_AfterInsertTenant ON Tenant
AFTER INSERT 
AS
BEGIN
	INSERT INTO TenantInsertInfo (Tenant_id, First_name, Last_name, Phone, BirthDate, Salary)
	SELECT Tenant_id, FirstName, LastName, Phone, BirthDate, Salary from inserted;
END

SELECT * FROM TenantInsertInfo


