
--CREATE ManagerDeleteLog TABLE
CREATE TABLE ManagerDeleteLog
(
	LogID INT IDENTITY PRIMARY KEY,
	Manager_id int,
	FirstName nvarchar(100),
	LastName nvarchar(100),
	Contact nchar(15),
	Salary float
)


--CREATE AFTER DELETE MANAGER
CREATE TRIGGER trg_AfterDeleteManager on Property_manager
AFTER DELETE
AS 
BEGIN
	INSERT INTO ManagerDeleteLog (Manager_id, FirstName, LastName, Contact, Salary)
	SELECT Manager_id, FirstName, LastName, Contact, Salary FROM deleted
END

SELECT * FROM Property_manager

SELECT * FROM ManagerDeleteLog

