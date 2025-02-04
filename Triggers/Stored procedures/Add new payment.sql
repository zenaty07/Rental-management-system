
CREATE PROCEDURE [dbo].[ADD_NEW_PAYMENT]

	-- PAYMENT PARAMETERS 
    @DATE DATE,
    @Actual_total_due_amount FLOAT,
    @Amount_paid FLOAT,
    @LEASINGINFO_ID INT,
	-- OUTPUT PARAMETERS  
	@Status bit output,
    @Total_remaining FLOAT OUTPUT,
	-- Error message variable 
	@LEASING_ERROR_MESSAGE NVARCHAR(255) OUTPUT

AS
BEGIN

BEGIN TRY

		-- Build the error message
		SELECT @LEASING_ERROR_MESSAGE = 'The leasing contract: ' + CAST(@LEASINGINFO_ID AS NVARCHAR(50)) + ' expired';

        -- Start a transaction
        BEGIN TRANSACTION;
		select @Status = Status from Leasing_Info where LeasingInfo_id = @LEASINGINFO_ID
		
		if @Status = 0
		BEGIN
            THROW 50001, @LEASING_ERROR_MESSAGE, 1;
        END

		-- Calculate the total remaining amount
        SELECT @Total_remaining = @Actual_total_due_amount - @Amount_paid;
	-- Insert into Payment table
        INSERT INTO Payment (Date, Actual_total_due_amount, Amount_paid, Total_remaining, LeasingInfo_id) 
        VALUES (@DATE, @Actual_total_due_amount, @Amount_paid, @Total_remaining, @LEASINGINFO_ID);

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
