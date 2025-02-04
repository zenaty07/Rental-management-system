CREATE PROCEDURE [dbo].[NEW_PROPERTY]
	
	@PROPERTY_ID INT,
	@LOCATION NVARCHAR(100),
	@BUILDING_NO INT,
	@APARTMENT_NO INT,
	@SIZE INT,
	@MANAGER_ID INT,
	@Rent_per_four_month INT,
	@CATEGORY_ID INT

AS 
BEGIN 

BEGIN TRY
        -- Start a transaction
        BEGIN TRANSACTION;
        
	INSERT INTO Property(Property_id, Location, Building_NO, Apartment_NO, Size_in_sqft, Rent_per_four_month, Is_avaliable_for_rent, Manager_id, Category_id)
	VALUES(@PROPERTY_ID, @LOCATION, @BUILDING_NO, @APARTMENT_NO, @SIZE, @Rent_per_four_month, 1, @MANAGER_ID, @CATEGORY_ID)
		-- Commit the transaction
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback transaction in case of error
        ROLLBACK TRANSACTION;

        -- Declare variables to capture error details
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        -- Print or log the error message (optional)
        PRINT 'An error occurred: ' + @ErrorMessage;

        -- Optionally, rethrow the error
        THROW;
    END CATCH
END