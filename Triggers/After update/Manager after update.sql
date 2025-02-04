

-- Creating ManagerUpdateLog table
CREATE TABLE ManagerUpdateLog 
(
	LogID INT IDENTITY PRIMARY KEY,
	Manager_id int,
	Old_First_name nvarchar(100),
	New_First_name nvarchar(100),
	Old_Last_name nvarchar(100),
	New_Last_name nvarchar(100),
	Old_contact nchar(15),
	New_contact nchar(15),
	Old_salary float, 
	New_salary float,
	UpdatedDateTime DATETIME DEFAULT GETDATE()
)

-- After updating Manager table
CREATE TRIGGER trg_AfterUpdateManager on Property_manager
AFTER UPDATE
AS
BEGIN
	IF UPDATE(Contact)
		BEGIN
		INSERT INTO ManagerUpdateLog (Manager_id, Old_contact, New_contact)
		SELECT i.Manager_id, d.Contact as Old_number, i.Contact as New_number
		from inserted i inner join deleted d on i.Manager_id = d.Manager_id
		END
	else IF UPDATE(FirstName)
		BEGIN
		INSERT INTO ManagerUpdateLog (Manager_id, Old_First_name, New_First_name)
		SELECT i.Manager_id, d.FirstName as Old_First_name, i.FirstName as New_First_name
		from inserted i inner join deleted d on i.Manager_id = d.Manager_id
		END
	else IF UPDATE(LastName)
		BEGIN
		INSERT INTO ManagerUpdateLog (Manager_id, Old_Last_name, New_Last_name)
		SELECT i.Manager_id, d.LastName as Old_Last_name, i.LastName as New_Last_name
		from inserted i inner join deleted d on i.Manager_id = d.Manager_id
		END
	else IF UPDATE(Salary)
		BEGIN
		INSERT INTO ManagerUpdateLog (Manager_id, Old_salary, New_salary)
		SELECT i.Manager_id, d.Salary as Old_salary, i.Salary as New_salary
		from inserted i inner join deleted d on i.Manager_id = d.Manager_id
		END

END


SELECT * FROM Property_manager
SELECT * FROM ManagerUpdateLog

UPDATE Property_manager 
SET Contact = 154962 WHERE Manager_id = 1

UPDATE Property_manager
SET LastName = 'Osama' WHERE Manager_id = 7