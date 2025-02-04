

-- Creating MaintenanceUpdateLog table
CREATE TABLE MaintenanceUpdateLog 
(
	LogID INT IDENTITY PRIMARY KEY,
	Maintenance_id int,
	Old_Type nvarchar(50),
	New_Type nvarchar(50),
	Old_Status nvarchar(50),
	New_Status nvarchar(50),
	Old_Costs float,
	New_Costs float,
	Old_date date,
	New_date date,
	Old_property_id int,
	New_property_id int,
	UpdatedDateTime DATETIME DEFAULT GETDATE()
)

-- After updating Maintenance table
CREATE TRIGGER trg_AfterUpdateMaintenance on Maintenance
AFTER UPDATE
AS
BEGIN
	IF UPDATE(Type)
		BEGIN
		INSERT INTO MaintenanceUpdateLog (Maintenance_id, Old_Type, New_Type)
		SELECT i.Maintenance_id, d.type as Old_Type, i.type as New_Type
		from inserted i inner join deleted d on i.Maintenance_id = d.Maintenance_id
		END
	ELSE IF UPDATE(Status)
		BEGIN
		INSERT INTO MaintenanceUpdateLog (Maintenance_id, Old_Status, New_Status)
		SELECT i.Maintenance_id, d.Status as Old_Status, i.Status as New_Status
		from inserted i inner join deleted d on i.Maintenance_id = d.Maintenance_id
		END
	ELSE IF UPDATE(Costs)
		BEGIN
		INSERT INTO MaintenanceUpdateLog (Maintenance_id, Old_Costs, New_Costs)
		SELECT i.Maintenance_id, d.Costs as Old_Costs, i.Costs as New_Costs
		from inserted i inner join deleted d on i.Maintenance_id = d.Maintenance_id
		END
	ELSE IF UPDATE(Date)
		BEGIN
		INSERT INTO MaintenanceUpdateLog (Maintenance_id, Old_date, New_date)
		SELECT i.Maintenance_id, d.Date as Old_date, i.Date as New_date
		from inserted i inner join deleted d on i.Maintenance_id = d.Maintenance_id
		END
	ELSE IF UPDATE(Property_id)
		BEGIN
		INSERT INTO MaintenanceUpdateLog (Maintenance_id, Old_property_id, New_property_id)
		SELECT i.Maintenance_id, d.Property_id as Old_property_id, i.Property_id as New_property_id
		from inserted i inner join deleted d on i.Maintenance_id = d.Maintenance_id
		END
END

SELECT * FROM Maintenance
SELECT * FROM MaintenanceUpdateLog

UPDATE Maintenance
SET Status = 'Completed' where Maintenance_id = 8002