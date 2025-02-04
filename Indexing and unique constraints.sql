select * from Maintenance

insert into Maintenance values ( 'Water', 'Completed', 225, 6002)
insert into Maintenance values ( 'Elecricity', 'In progress', 700, 5001)
insert into Maintenance values ( 'Plumbing', 'Completed', 650, 6007)
insert into Maintenance values ( 'Water', 'In progress', 170, 7006)
insert into Maintenance values ('Internet', 'Completed', 500, 7002)


-- Tenant contact unique constraint 
ALTER TABLE Tenant
ADD CONSTRAINT UQ_Tenant_Contact UNIQUE (Contact);

-- Manager contact unique constraint 
ALTER TABLE property_manager
ADD CONSTRAINT UQ_Manager_Contact UNIQUE (Contact);

-- Category name unique constraint 
ALTER TABLE Category
ADD CONSTRAINT UQ_Category_Name UNIQUE (Category_name);

-- First and last name indexing 
CREATE INDEX idx_tenant_first_name ON Tenant(FirstName);
CREATE INDEX idx_tenant_last_name ON Tenant(LastName);





