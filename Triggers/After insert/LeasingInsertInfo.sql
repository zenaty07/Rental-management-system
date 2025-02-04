-- CREATING TABLE FOR AFTER INSERT TRIGGER TO PAYMENT 
CREATE TABLE LeasingInsertInfo
(
	LogId int IDENTITY PRIMARY KEY,
	Start_date DATE,
	End_date DATE,
	Property_id int,
	Tenant_id int,
	Status bit,
	InsertDateTime DATETIME DEFAULT GETDATE()
)

-- AFTER INSERT TRIGGER Leasing_info table
CREATE TRIGGER trg_AfterInsertLeasing ON Leasing_info
AFTER INSERT 
AS
BEGIN
	INSERT INTO LeasingInsertInfo (Start_date, End_date, Property_id, Tenant_id, Status)
	SELECT Start_date, End_date, Property_id, Tenant_id, Status from inserted;
END

select * from LeasingInsertInfo

