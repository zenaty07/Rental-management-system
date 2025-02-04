
--CREATE PorpertyDeleteLog TABLE
CREATE TABLE PorpertyDeleteLog
(
	LogID INT IDENTITY PRIMARY KEY,
	Property_id int, 
	Location nvarchar(100),
	Building_NO int,
	Apartment_NO int,
	Size_in_sqft int,
	Rent_per_four_month float,
	Manager_id int,
	Category_id int
)

--CREATE AFTER DELETE PROPERTY
CREATE TRIGGER trg_AfterDeleteProperty on Property
AFTER DELETE 
AS
BEGIN
	INSERT INTO PorpertyDeleteLog (Property_id, Location, Building_NO, Apartment_NO, Size_in_sqft, Rent_per_four_month, Manager_id, Category_id)
	SELECT Property_id, Location, Building_NO, Apartment_NO, Size_in_sqft, Rent_per_four_month, Manager_id, Category_id FROM deleted
END

SELECT * FROM Property
SELECT * FROM PorpertyDeleteLog

DELETE Property
WHERE Property_id = 8002