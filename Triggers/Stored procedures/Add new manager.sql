CREATE PROCEDURE [dbo].[ADD_NEW_MANAGER]

	@FIRST_NAME NVARCHAR(100),
	@LAST_NAME NVARCHAR(100),
	@CONTACT NCHAR(15),
	@SALARY INT

	AS
BEGIN
    BEGIN TRY
        -- Start a transaction
        BEGIN TRANSACTION;
        
	INSERT INTO Property_manager(FirstName, LastName, Contact, Salary) VALUES(@FIRST_NAME, @LAST_NAME, @CONTACT, @SALARY)
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