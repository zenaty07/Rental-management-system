
--SCALAR FUNCTION FOR RETURN AVERAGE PAYMENT FOR SPECIFIC LOCATION 
CREATE FUNCTION DBO.GET_LocationAVG2(@Location NVARCHAR(100))
RETURNS FLOAT
AS
BEGIN

	DECLARE @LocationAVG FLOAT

	SELECT @LocationAVG = AVG(Amount_paid)
	FROM Payment P INNER JOIN Leasing_Info L ON P.LeasingInfo_id = L.LeasingInfo_id 
	INNER JOIN Property PRO ON L.Property_id = PRO.Property_id
	GROUP BY PRO.Location
	HAVING PRO.Location = @Location
	

	RETURN @LocationAVG
END


SELECT DISTINCT PRO.Location, DBO.GET_LocationAVG2(PRO.Location) AS LocationAVG FROM 
Property PRO 


