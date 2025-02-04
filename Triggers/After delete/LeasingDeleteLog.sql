
--CREATE LeasingDeleteLog TABLE
CREATE TABLE LeasingDeleteLog
(
	LogID INT IDENTITY PRIMARY KEY,
	LeasingInfo_id INT,
	Start_date DATE,
	End_date DATE,
	Property_id INT,
	Tenant_id INT
)

--CREATE AFTER DELETE LEASING_INFO
CREATE TRIGGER trg_AfterDeleteLeasing on Leasing_Info
AFTER DELETE 
AS
BEGIN
	INSERT INTO LeasingDeleteLog (LeasingInfo_id, Start_date, End_date, Property_id, Tenant_id)
	SELECT LeasingInfo_id, Start_date, End_date, Property_id, Tenant_id FROM deleted
END

SELECT * FROM Leasing_Info

SELECT * FROM LeasingDeleteLog

DELETE FROM Leasing_Info
WHERE LeasingInfo_id = 30033

