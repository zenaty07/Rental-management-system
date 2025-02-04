

-- Creating LeasingUpdateLog table
CREATE TABLE LeasingUpdateLog 
(
	LogID INT IDENTITY PRIMARY KEY,
	LeasingInfo_id int,
	Old_start_date date, 
	New_start_date date,
	Old_end_date date, 
	New_end_date date,
	Old_property_id int,
	New_property_id int,
	Old_tenant_id int,
	New_tenant_id int,
	Old_status bit,
	New_status bit,
	UpdatedDateTime DATETIME DEFAULT GETDATE()
)

-- After updating Leasing_info table
CREATE TRIGGER trg_AfterUpdateLeasing on Leasing_info
AFTER UPDATE
AS
BEGIN
	IF UPDATE(Start_date)
		BEGIN
		INSERT INTO LeasingUpdateLog (LeasingInfo_id, Old_start_date, New_start_date)
		SELECT i.LeasingInfo_id, d.Start_date as Old_start_date, i.Start_date as New_start_date
		from inserted i inner join deleted d on i.LeasingInfo_id = d.LeasingInfo_id
		END
	ELSE IF UPDATE(End_date)
		BEGIN
		INSERT INTO LeasingUpdateLog (LeasingInfo_id, Old_end_date, New_end_date)
		SELECT i.LeasingInfo_id, d.End_date as Old_end_date, i.End_date as New_end_date
		from inserted i inner join deleted d on i.LeasingInfo_id = d.LeasingInfo_id
		END
	ELSE IF UPDATE(Property_id)
		BEGIN
		INSERT INTO LeasingUpdateLog (LeasingInfo_id, Old_property_id, New_property_id)
		SELECT i.LeasingInfo_id, d.Property_id as Old_property_id, i.Property_id as New_property_id
		from inserted i inner join deleted d on i.LeasingInfo_id = d.LeasingInfo_id
		END
	ELSE IF UPDATE(Tenant_id)
		BEGIN
		INSERT INTO LeasingUpdateLog (LeasingInfo_id, Old_tenant_id, New_tenant_id)
		SELECT i.LeasingInfo_id, d.Tenant_id as Old_tenant_id, i.Tenant_id as New_tenant_id
		from inserted i inner join deleted d on i.LeasingInfo_id = d.LeasingInfo_id
		END
	ELSE IF UPDATE(Status)
		BEGIN
		INSERT INTO LeasingUpdateLog (LeasingInfo_id, Old_status, New_status)
		SELECT i.LeasingInfo_id, d.Status as Old_status, i.Status as New_status
		from inserted i inner join deleted d on i.LeasingInfo_id = d.LeasingInfo_id
		END
END

update Leasing_Info 
set Tenant_id = 1003 where LeasingInfo_id = 30001

update Leasing_Info 
set Tenant_id = 1001 where LeasingInfo_id = 30001

SELECT * FROM Leasing_Info
SELECT * FROM LeasingUpdateLog