-- Creating PaymentUpdateLog table
CREATE TABLE PaymentUpdateLog 
(
	LogID INT IDENTITY PRIMARY KEY,
	Payment_id int, 
	Old_date date,
	New_date date,
	Old_actual_total float,
	New_actual_total float,
	Old_amount_paid float,
	New_amount_paid float,
	Old_total_remaining float,
	New_total_remaining float,
	Old_leasingInfo_id int,
	New_leasingInfo_id int,
	UpdatedDateTime DATETIME DEFAULT GETDATE()
)

-- After updating Payment table
CREATE TRIGGER trg_AfterUpdatePayment on Payment
AFTER UPDATE
AS
BEGIN
	IF UPDATE(Date)
		BEGIN
		INSERT INTO PaymentUpdateLog (Payment_id, Old_date, New_date)
		SELECT i.Payment_id, d.Date as Old_date, i.Date as New_date
		from inserted i inner join deleted d on i.Payment_id = d.Payment_id
		END
	ELSE IF UPDATE(Actual_total_due_amount)
		BEGIN
		INSERT INTO PaymentUpdateLog (Payment_id, Old_actual_total, New_actual_total)
		SELECT i.Payment_id, d.Actual_total_due_amount as Old_actual_total, i.Actual_total_due_amount as New_actual_total
		from inserted i inner join deleted d on i.Payment_id = d.Payment_id
		END
	ELSE IF UPDATE(Amount_paid)
		BEGIN
		INSERT INTO PaymentUpdateLog (Payment_id, Old_amount_paid, New_amount_paid)
		SELECT i.Payment_id, d.Amount_paid as Old_amount_paid, i.Payment_id as New_amount_paid
		from inserted i inner join deleted d on i.Payment_id = d.Payment_id
		END
	ELSE IF UPDATE(Total_remaining)
		BEGIN
		INSERT INTO PaymentUpdateLog (Payment_id, Old_total_remaining, New_total_remaining)
		SELECT i.Payment_id, d.Total_remaining as Old_total_remaining, i.Total_remaining as New_total_remaining
		from inserted i inner join deleted d on i.Payment_id = d.Payment_id
		END
	ELSE IF UPDATE(LeasingInfo_id)
		BEGIN
		INSERT INTO PaymentUpdateLog (Payment_id, Old_leasingInfo_id, New_leasingInfo_id)
		SELECT i.Payment_id, d.LeasingInfo_id as Old_leasingInfo_id, i.LeasingInfo_id as New_leasingInfo_id
		from inserted i inner join deleted d on i.Payment_id = d.Payment_id
		END
END

SELECT * FROM Payment
SELECT * FROM PaymentUpdateLog


--UPDATING TESTING 
UPDATE Payment SET DATE = '05-07-2024' where Payment_id = 20001

UPDATE Payment SET Amount_paid = 8000 WHERE Payment_id = 20048

UPDATE Payment SET Total_remaining = 0 WHERE Payment_id = 20048





