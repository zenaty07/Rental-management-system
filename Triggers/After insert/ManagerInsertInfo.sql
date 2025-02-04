-- CREATING TABLE FOR AFTER INSERT TRIGGER TO PAYMENT 
CREATE TABLE ManagerInsertInfo
(
	LogId int IDENTITY PRIMARY KEY,
	Manager_Id int,
	First_name nvarchar(100),
	Last_name nvarchar(100),
	Contact nchar(15),
	Salary int,
	InsertDateTime DATETIME DEFAULT GETDATE()
)

-- AFTER INSERT TRIGGER Leasing_info table
CREATE TRIGGER trg_AfterInsertMAnager ON Property_manager
AFTER INSERT 
AS
BEGIN
	INSERT INTO ManagerInsertInfo (Manager_Id, First_name, Last_name, Contact, Salary)
	SELECT Manager_Id, FirstName, LastName, Contact, Salary from inserted;
END

select * from ManagerInsertInfo

select * from Property_manager