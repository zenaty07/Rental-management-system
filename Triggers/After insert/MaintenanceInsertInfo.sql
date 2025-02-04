-- CREATING TABLE FOR AFTER INSERT TRIGGER TO PAYMENT 
CREATE TABLE MaintenanceInsertInfo
(
	LogId int IDENTITY PRIMARY KEY,
	Maintenance_id int,
	Type nvarchar(50),
	Status nvarchar(50),
	Costs float,
	Date date,
	Property_id int,
	InsertDateTime DATETIME DEFAULT GETDATE()
)

-- AFTER INSERT TRIGGER Leasing_info table
CREATE TRIGGER trg_AfterInsertMaintenance ON Maintenance
AFTER INSERT 
AS
BEGIN
	INSERT INTO MaintenanceInsertInfo (Maintenance_id, Type, Status, Costs, Date, Property_id)
	SELECT Maintenance_id, Type, Status, Costs, Date, Property_id from inserted;
END

select * from Maintenance

select * from MaintenanceInsertInfo