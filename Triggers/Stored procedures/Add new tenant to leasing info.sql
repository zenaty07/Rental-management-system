CREATE PROCEDURE [dbo].[SP_ADD_NEW_TENANT_TO_LEASING_INFO]
	-- TENANT PARAMETERS 
    @FIRST_NAME NVARCHAR(100),
    @LAST_NAME NVARCHAR(100),
    @PHONE NCHAR(15),
    @BIRTHDATE DATE,
    @SALARY FLOAT,
    -- PAYMENT PARAMETERS 
    @DATE DATE,
    @Actual_total_due_amount FLOAT,
    @Amount_paid FLOAT,
    @PROPERTY_ID INT,
    -- OUTPUT PARAMETERS  
    @Total_remaining FLOAT OUTPUT,
    @NEW_TENANT_ID INT OUTPUT,
    @NEW_LEASINGINFO_ID INT OUTPUT,
    @AVALIBALITY BIT OUTPUT
AS
BEGIN
    BEGIN TRY
        -- Start a transaction
        BEGIN TRANSACTION;

        -- Check property availability
        SELECT @AVALIBALITY = Is_avaliable_for_rent 
        FROM Property 
        WHERE Property_id = @PROPERTY_ID;

        -- If the property is unavailable, throw an error
        IF @AVALIBALITY = 0
        BEGIN
            THROW 50001, 'The property is not available for rent.', 1;
        END

        -- Insert into Tenant table
        INSERT INTO Tenant (FirstName, LastName, Phone, BirthDate, Salary) 
        VALUES (@FIRST_NAME, @LAST_NAME, @PHONE, @BIRTHDATE, @SALARY);
        SELECT @NEW_TENANT_ID = SCOPE_IDENTITY();

        -- Insert into Leasing_Info table
        INSERT INTO Leasing_Info (Start_date, End_date, property_id, TENANT_ID, Status) 
        VALUES (@DATE, DATEADD(YEAR, 1, @DATE), @PROPERTY_ID, @NEW_TENANT_ID, 1);
        SELECT @NEW_LEASINGINFO_ID = SCOPE_IDENTITY();

        -- Calculate the total remaining amount
        SELECT @Total_remaining = @Actual_total_due_amount - @Amount_paid;

        -- Insert into Payment table
        INSERT INTO Payment (Date, Actual_total_due_amount, Amount_paid, Total_remaining, LeasingInfo_id) 
        VALUES (@DATE, @Actual_total_due_amount, @Amount_paid, @Total_remaining, @NEW_LEASINGINFO_ID);

        -- Update property availability
        UPDATE Property
        SET Is_avaliable_for_rent = 0 
        WHERE Property_id = @PROPERTY_ID;

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