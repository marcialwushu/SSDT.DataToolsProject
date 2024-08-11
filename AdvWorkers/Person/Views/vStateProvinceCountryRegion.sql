CREATE VIEW [Person].[vStateProvinceCountryRegion] 
WITH SCHEMABINDING 
AS 
SELECT 
    sp.[StateProvinceID] 
    ,sp.[StateProvinceCode] 
    ,sp.[IsOnlyStateProvinceFlag] 
    ,sp.[Name] AS [StateProvinceName] 
    ,sp.[TerritoryID] 
    ,cr.[CountryRegionCode] 
    ,cr.[Name] AS [CountryRegionName]
FROM [Person].[StateProvince] sp 
    INNER JOIN [Person].[CountryRegion] cr 
    ON sp.[CountryRegionCode] = cr.[CountryRegionCode];
GO
-- Index the vStateProvinceCountryRegion view
CREATE UNIQUE CLUSTERED INDEX [IX_vStateProvinceCountryRegion] ON [Person].[vStateProvinceCountryRegion]([StateProvinceID], [CountryRegionCode]);
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Joins StateProvince table with CountryRegion table.', N'SCHEMA', [Person], N'VIEW', [vStateProvinceCountryRegion], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index on the view vStateProvinceCountryRegion.', N'SCHEMA', [Person], N'VIEW', [vStateProvinceCountryRegion], N'INDEX', [IX_vStateProvinceCountryRegion];