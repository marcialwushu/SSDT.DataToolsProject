CREATE VIEW [Production].[vProductAndDescription] 
WITH SCHEMABINDING 
AS 
-- View (indexed or standard) to display products and product descriptions by language.
SELECT 
    p.[ProductID] 
    ,p.[Name] 
    ,pm.[Name] AS [ProductModel] 
    ,pmx.[CultureID] 
    ,pd.[Description] 
FROM [Production].[Product] p 
    INNER JOIN [Production].[ProductModel] pm 
    ON p.[ProductModelID] = pm.[ProductModelID] 
    INNER JOIN [Production].[ProductModelProductDescriptionCulture] pmx 
    ON pm.[ProductModelID] = pmx.[ProductModelID] 
    INNER JOIN [Production].[ProductDescription] pd 
    ON pmx.[ProductDescriptionID] = pd.[ProductDescriptionID];
GO
-- Index the vProductAndDescription view
CREATE UNIQUE CLUSTERED INDEX [IX_vProductAndDescription] ON [Production].[vProductAndDescription]([CultureID], [ProductID]);
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Product names and descriptions. Product descriptions are provided in multiple languages.', N'SCHEMA', [Production], N'VIEW', [vProductAndDescription], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index on the view vProductAndDescription.', N'SCHEMA', [Production], N'VIEW', [vProductAndDescription], N'INDEX', [IX_vProductAndDescription];