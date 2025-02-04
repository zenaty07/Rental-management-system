

CREATE VIEW LeasingDetails AS
	SELECT L.LeasingInfo_id, L.Start_date, L.End_date, P.Property_ID, C.Category_name, P.Location, P.Building_NO, P.Apartment_NO, P.Size_in_sqft, P.Is_avaliable_for_rent,
	T.Tenant_id, T.FirstName + ' ' + T.LastName AS TenantName, T.Phone, T.BirthDate AS Tenant_birthDate, T.Salary AS TenantSalary,
	M.Manager_id, M.FirstName + ' ' + M.LastName AS ManagerName, M.Contact, M.Salary AS ManagerSalary
	FROM Leasing_Info L INNER JOIN Property P ON L.Property_id = P.Property_id 
	INNER JOIN Tenant T ON L.Tenant_id = T.Tenant_id INNER JOIN Property_manager M ON P.Manager_id = M.Manager_id
	INNER JOIN Category C ON P.Category_id = C.Category_id
	WHERE P.Is_avaliable_for_rent = 0 AND L.Status = 1