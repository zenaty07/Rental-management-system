-- CREATING TABLE FOR AFTER INSERT TRIGGER TO PAYMENT 
CREATE TABLE PropertyInsertInfo
(
	LogId int IDENTITY PRIMARY KEY,
	Property_id int,
	Location nvarchar(50),
	Building_NO int,
	Apartment_NO int,
	Size_in_sqft int,
	Rent_per_four_month float,
	Is_avaliable_for_rent bit,
	Manager_id int, 
	Category_id int,
	InsertDateTime DATETIME DEFAULT GETDATE()
)

-- AFTER INSERT TRIGGER Leasing_info table
CREATE TRIGGER trg_AfterInsertProperty ON Property
AFTER INSERT 
AS
BEGIN
	INSERT INTO PropertyInsertInfo (Property_id, Location, Building_NO, Apartment_NO, Size_in_sqft, Rent_per_four_month, Is_avaliable_for_rent,
	Manager_id, Category_id)
	SELECT Property_id, Location, Building_NO, Apartment_NO, Size_in_sqft, Rent_per_four_month, Is_avaliable_for_rent,
	Manager_id, Category_id from inserted;
END

SELECT * FROM Property

SELECT * FROM PropertyInsertInfo