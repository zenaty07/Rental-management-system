-- Inner join between property and payment tables to display how much total remains for each location 
select distinct p.property_id, p.Location, pay.total_remaining
from Property p inner join payment pay on p.Property_id = pay.Property_id where p.Location = 'green belt'


-- Inner join between property, payment, leasingInfo and maintenance tables 
select distinct (p.property_id), p.Location, l.start_date, l.end_date, pay.total_remaining, m.type from Property p inner join payment pay on pay.Property_id = p.Property_id 
inner join Leasing_Info l on l.LeasingInfo_id = pay.LeasingInfo_id inner join Maintenance m on m.Property_id = p.Property_id where p.Location = 'City center'

-- Inner join between Tenant and payment tables to show how much each tenant has paid for the property 
select ten.firstName, ten.lastName, sum(pay.Amount_paid)as paidAmount from payment pay
inner join Tenant ten on ten.Tenant_id = pay.Tenant_id group by ten.FirstName, ten.LastName

-- Inner join between property and property_manager tables to display who manages each location 
select distinct  p.location, m.manager_id, m.firstName, m.lastName from property p
inner join Property_manager m on m.Manager_id = p.Manager_id