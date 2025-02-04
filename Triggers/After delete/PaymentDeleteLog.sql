
--CREATE PaymentDeleteLog TABLE
CREATE TABLE PaymentDeleteLog
(
	LogID INT IDENTITY PRIMARY KEY,
	Payment_id int,
	Date date,
	Actual_total_due_amount float,
	Amount_paid float,
	Total_remaining float,
	LeasingInfo_id int
)

--CREATE AFTER DELETE PAYMENT
CREATE TRIGGER trg_AfterDeletePayment on Payment
AFTER DELETE
AS 
BEGIN
	INSERT INTO PaymentDeleteLog (Payment_id, Date, Actual_total_due_amount, Amount_paid, Total_remaining, LeasingInfo_id)
	SELECT Payment_id, Date, Actual_total_due_amount, Amount_paid, Total_remaining, LeasingInfo_id FROM deleted
END

SELECT * FROM Payment

SELECT * FROM PaymentDeleteLog

DELETE FROM Payment
WHERE Payment_id = 21072