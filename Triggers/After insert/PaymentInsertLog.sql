
SELECT * FROM PaymentInsertLog
-- CREATING TABLE FOR AFTER INSERT TRIGGER TO PAYMENT 
CREATE TABLE PaymentInsertLog
(
	LogId int IDENTITY PRIMARY KEY,
	Payment_date DATE,
	Actual_total_due_amount int,
	Amount_paid int, 
	Total_remaining float,
	LeasingInfo_id int,
	InsertedDateTime DATETIME DEFAULT GETDATE()
)

-- AFTER INSERT TRIGGER 
CREATE TRIGGER trg_AfterInsertPayment ON PAYMENT
AFTER INSERT 
AS
BEGIN
	INSERT INTO PaymentInsertLog (Payment_date, Actual_total_due_amount, Amount_paid, Total_remaining, LeasingInfo_ID)
	SELECT Date, Actual_total_due_amount, Amount_paid, Total_remaining, LeasingInfo_id from inserted;
END

