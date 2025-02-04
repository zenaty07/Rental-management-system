
-- Creating PropertyUpdateLog table
CREATE TABLE PropertyUpdateLog 
(
	LogID INT IDENTITY PRIMARY KEY,
	Property_id int, 
	Old_Location nvarchar(100),
	New_Location nvarchar(100),
	Old_Building_NO int,
	New_Building_NO int,
	Old_apartment_NO int,
	New_apartment_NO int,
	Old_size int,
	New_size int, 
	Old_rent float,
	New_rent float,
	Old_availability bit,
	New_availability bit,
	Old_manager int,
	New_Manager int,
	Old_category int,
	New_category int,
	UpdatedDateTime DATETIME DEFAULT GETDATE()
)

-- After updating Tenant table
CREATE TRIGGER trg_AfterUpdateProperty on Property
AFTER UPDATE
AS
BEGIN
	IF UPDATE(Location)
		BEGIN
		INSERT INTO PropertyUpdateLog (Property_id, Old_location, New_Location)
		SELECT i.Property_id, d.Location as Old_location, i.Location as New_location
		from inserted i inner join deleted d on i.Property_id = d.Property_id
		END
	ELSE IF UPDATE(Building_NO)
		BEGIN
		INSERT INTO PropertyUpdateLog (Property_id, Old_Building_NO, New_Building_NO)
		SELECT i.Property_id, d.Building_NO as Old_Building_NO, i.Building_NO as New_Building_NO
		from inserted i inner join deleted d on i.Property_id = d.Property_id
		END
	ELSE IF UPDATE(Apartment_NO)
		BEGIN
		INSERT INTO PropertyUpdateLog (Property_id, Old_apartment_NO, New_apartment_NO)
		SELECT i.Property_id, d.Apartment_NO as Old_apartment_NO, i.Apartment_NO as New_apartment_NO
		from inserted i inner join deleted d on i.Property_id = d.Property_id
		END
	ELSE IF UPDATE(Size_in_sqft)
		BEGIN
		INSERT INTO PropertyUpdateLog (Property_id, Old_size, New_size)
		SELECT i.Property_id, d.Size_in_sqft as Old_size, i.Size_in_sqft as New_size
		from inserted i inner join deleted d on i.Property_id = d.Property_id
		END
	ELSE IF UPDATE(Rent_per_four_month)
		BEGIN
		INSERT INTO PropertyUpdateLog (Property_id, Old_rent, New_rent)
		SELECT i.Property_id, d.Rent_per_four_month as Old_rent, i.Rent_per_four_month as New_rent
		from inserted i inner join deleted d on i.Property_id = d.Property_id
		END
	ELSE IF UPDATE(Is_avaliable_for_rent)
		BEGIN
		INSERT INTO PropertyUpdateLog (Property_id, Old_availability, New_availability)
		SELECT i.Property_id, d.Is_avaliable_for_rent as Old_availability, i.Is_avaliable_for_rent as New_availability
		from inserted i inner join deleted d on i.Property_id = d.Property_id
		END
	ELSE IF UPDATE(Manager_id)
		BEGIN
		INSERT INTO PropertyUpdateLog (Property_id, Old_manager, New_Manager)
		SELECT i.Property_id, d.Manager_id as Old_manager, i.Manager_id as New_manager
		from inserted i inner join deleted d on i.Property_id = d.Property_id
		END
	ELSE IF UPDATE(Category_id)
		BEGIN
		INSERT INTO PropertyUpdateLog (Property_id, Old_category, New_category)
		SELECT i.Property_id, d.Category_id as Old_category, i.Category_id as New_category
		from inserted i inner join deleted d on i.Property_id = d.Property_id
		END
END

SELECT * FROM Property

SELECT * FROM PropertyUpdateLog
-- UPDATING TESTING 

UPDATE Property
SET Building_NO = 500333 WHERE Property_id IN (5001, 5002, 5003, 5004, 5005, 5006)

UPDATE Property
SET Location = 'ARENA' WHERE Property_id IN (8001, 8002)

UPDATE Property
SET Apartment_NO = 22 WHERE Property_id = 8002

UPDATE Property
SET Manager_id = 1006 WHERE Property_id IN (8001, 8002)