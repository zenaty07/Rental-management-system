CREATE PROCEDURE [dbo].[ADD_MAINTENANCE_REQUEST]

	-- MAINTENANCE PARAMETERS
	@MAINTENANCE_TYPE NVARCHAR(50),
	@STATUS NVARCHAR(50),
	@COSTS INT,
	@DATE DATE,
	@PROPERTY_ID INT
AS
BEGIN
    BEGIN TRY
        -- Start a transaction
        BEGIN TRANSACTION;
        
	INSERT INTO Maintenance(Type, Status, Costs, Date, Property_id) VALUES(@MAINTENANCE_TYPE, @STATUS, @COSTS, @DATE, @PROPERTY_ID)
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