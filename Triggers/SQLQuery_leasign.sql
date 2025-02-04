select * from Property

select * from Property_manager

select * from Tenant

select * from Payment where Payment_id between 20016 and 20019

insert into Leasing_Info values (30001, '05-06-2024', '05-06-2025', 20001)
insert into Leasing_Info values (30002, '05-10-2024', '05-10-2025', 20002)
insert into Leasing_Info values (30003, '06-25-2024', '06-25-2025', 20003)
insert into Leasing_Info values (30004, '07-02-2024', '07-02-2025', 20004)
insert into Leasing_Info values (30005, '07-04-2024', '07-04-2025', 20005)

insert into Leasing_Info values (30006, '07-13-2024', '07-13-2025', 20006)
insert into Leasing_Info values (30007, '07-15-2024', '07-15-2025', 20007)
insert into Leasing_Info values (30008, '07-18-2024', '07-18-2025', 20008)
insert into Leasing_Info values (30009, '07-19-2024', '07-19-2025', 20009)
insert into Leasing_Info values (30010, '07-26-2024', '07-26-2025', 20010)

insert into Leasing_Info values (30011, '08-01-2024', '08-01-2025')
insert into Leasing_Info values (30012, '08-05-2024', '08-05-2025')
insert into Leasing_Info values (30013, '08-16-2024', '08-16-2025')
insert into Leasing_Info values (30014, '08-22-2024', '08-22-2025')
insert into Leasing_Info values (30015, '10-20-2024', '10-20-2025')

insert into Leasing_Info values (30016, '10-28-2024', '10-28-2025')
insert into Leasing_Info values (30017, '11-21-2024', '11-21-2025')
insert into Leasing_Info values (30018, '11-28-2024', '11-28-2025')
insert into Leasing_Info values (30019, '12-04-2024', '12-04-2025')


select * from Leasing_Info

select * from Maintenance


Update Payment set LeasingInfo_id = 30001 where Payment_id = 20001
Update Payment set LeasingInfo_id = 30002 where Payment_id = 20002
Update Payment set LeasingInfo_id = 30003 where Payment_id = 20003
Update Payment set LeasingInfo_id = 30004 where Payment_id = 20004
Update Payment set LeasingInfo_id = 30005 where Payment_id = 20005

Update Payment set LeasingInfo_id = 30006 where Payment_id = 20006
Update Payment set LeasingInfo_id = 30007 where Payment_id = 20007
Update Payment set LeasingInfo_id = 30008 where Payment_id = 20008
Update Payment set LeasingInfo_id = 30009 where Payment_id = 20009
Update Payment set LeasingInfo_id = 30010 where Payment_id = 20010

Update Payment set LeasingInfo_id = 30011 where Payment_id = 20011
Update Payment set LeasingInfo_id = 30012 where Payment_id = 20012
Update Payment set LeasingInfo_id = 30013 where Payment_id = 20013
Update Payment set LeasingInfo_id = 30014 where Payment_id = 20014
Update Payment set LeasingInfo_id = 30015 where Payment_id = 20015


Update Payment set LeasingInfo_id = 30016 where Payment_id = 20016
Update Payment set LeasingInfo_id = 30017 where Payment_id = 20017
Update Payment set LeasingInfo_id = 30018 where Payment_id = 20018
Update Payment set LeasingInfo_id = 30019 where Payment_id = 20019


