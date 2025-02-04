

-- Creating TenantUpdateLog table
CREATE TABLE TenantUpdateLog 
(
	LogID INT IDENTITY PRIMARY KEY,
	Tenant_id int, 
	Old_First_name nvarchar(100),
	New_First_name nvarchar(100),
	Old_Last_name nvarchar(100),
	New_Last_name nvarchar(100),
	Old_phone nchar(15),
	New_phone nchar(15),
	Old_birthdate date,
	New_birthdate date,
	Old_salary float, 
	New_salary float,
	UpdatedDateTime DATETIME DEFAULT GETDATE()
)

-- After updating Tenant table
CREATE TRIGGER trg_AfterUpdateTenant on Tenant
AFTER UPDATE
AS
BEGIN
	IF UPDATE(Phone)
		BEGIN
		INSERT INTO TenantUpdateLog (Tenant_id, Old_phone, New_phone)
		SELECT i.Tenant_id, d.Phone as Old_number, i.Phone as New_number
		from inserted i inner join deleted d on i.Tenant_id = d.Tenant_id
		END
	else IF UPDATE(BirthDate)
		BEGIN
		INSERT INTO TenantUpdateLog (Tenant_id, Old_birthdate, New_birthdate)
		SELECT i.Tenant_id, d.BirthDate as Old_birthdate, i.BirthDate as New_birthdate
		from inserted i inner join deleted d on i.Tenant_id = d.Tenant_id
		END
	else IF UPDATE(FirstName)
		BEGIN
		INSERT INTO TenantUpdateLog (Tenant_id, Old_First_name, New_First_name)
		SELECT i.Tenant_id, d.FirstName as Old_First_name, i.FirstName as New_First_name
		from inserted i inner join deleted d on i.Tenant_id = d.Tenant_id
		END
	else IF UPDATE(LastName)
		BEGIN
		INSERT INTO TenantUpdateLog (Tenant_id, Old_Last_name, New_Last_name)
		SELECT i.Tenant_id, d.LastName as Old_Last_name, i.LastName as New_Last_name
		from inserted i inner join deleted d on i.Tenant_id = d.Tenant_id
		END
	else IF UPDATE(Salary)
		BEGIN
		INSERT INTO TenantUpdateLog (Tenant_id, Old_salary, New_salary)
		SELECT i.Tenant_id, d.Salary as Old_salary, i.Salary as New_salary
		from inserted i inner join deleted d on i.Tenant_id = d.Tenant_id
		END

END

-- UPDATING TESTING
UPDATE Tenant 
SET Phone = 522569 WHERE Tenant_id = 1004

UPDATE Tenant 
SET BirthDate = '1995-06-06' WHERE Tenant_id = 1004

UPDATE Tenant
SET Salary = 12500  WHERE Tenant_id = 1016

UPDATE Tenant
SET FirstName = 'Faisel' WHERE Tenant_id = 1016

SELECT * FROM Tenant

SELECT * FROM TenantUpdateLog


