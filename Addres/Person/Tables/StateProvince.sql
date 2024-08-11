CREATE TABLE [Person].[StateProvince](
    [StateProvinceID] [int] IDENTITY (1, 1) NOT NULL,
    [StateProvinceCode] [nchar](3) NOT NULL, 
    [CountryRegionCode] [nvarchar](3) NOT NULL, 
    [IsOnlyStateProvinceFlag] [Flag] NOT NULL CONSTRAINT [DF_StateProvince_IsOnlyStateProvinceFlag] DEFAULT (1),
    [Name] [Name] NOT NULL,
    [TerritoryID] [int] NOT NULL,
    [rowguid] uniqueidentifier ROWGUIDCOL NOT NULL CONSTRAINT [DF_StateProvince_rowguid] DEFAULT (NEWID()), 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_StateProvince_ModifiedDate] DEFAULT (GETDATE()) 
) ON [PRIMARY];
GO
ALTER TABLE [Person].[StateProvince] ADD 
    CONSTRAINT [FK_StateProvince_CountryRegion_CountryRegionCode] FOREIGN KEY 
    (
        [CountryRegionCode]
    ) REFERENCES [Person].[CountryRegion](
        [CountryRegionCode]
    ), 
    CONSTRAINT [FK_StateProvince_SalesTerritory_TerritoryID] FOREIGN KEY 
    (
        [TerritoryID]
    ) REFERENCES [Sales].[SalesTerritory](
        [TerritoryID]
    );
GO
ALTER TABLE [Person].[StateProvince] WITH CHECK ADD 
    CONSTRAINT [PK_StateProvince_StateProvinceID] PRIMARY KEY CLUSTERED 
    (
        [StateProvinceID]
    )  ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_StateProvince_Name] ON [Person].[StateProvince]([Name]) ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_StateProvince_StateProvinceCode_CountryRegionCode] ON [Person].[StateProvince]([StateProvinceCode], [CountryRegionCode]) ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_StateProvince_rowguid] ON [Person].[StateProvince]([rowguid]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'State and province lookup table.', N'SCHEMA', [Person], N'TABLE', [StateProvince], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key for StateProvince records.', N'SCHEMA', [Person], N'TABLE', [StateProvince], N'COLUMN', [StateProvinceID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ISO standard state or province code.', N'SCHEMA', [Person], N'TABLE', [StateProvince], N'COLUMN', [StateProvinceCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ISO standard country or region code. Foreign key to CountryRegion.CountryRegionCode. ', N'SCHEMA', [Person], N'TABLE', [StateProvince], N'COLUMN', [CountryRegionCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'0 = StateProvinceCode exists. 1 = StateProvinceCode unavailable, using CountryRegionCode.', N'SCHEMA', [Person], N'TABLE', [StateProvince], N'COLUMN', [IsOnlyStateProvinceFlag];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'State or province description.', N'SCHEMA', [Person], N'TABLE', [StateProvince], N'COLUMN', [Name];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ID of the territory in which the state or province is located. Foreign key to SalesTerritory.SalesTerritoryID.', N'SCHEMA', [Person], N'TABLE', [StateProvince], N'COLUMN', [TerritoryID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', N'SCHEMA', [Person], N'TABLE', [StateProvince], N'COLUMN', [rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Person], N'TABLE', [StateProvince], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index.', N'SCHEMA', [Person], N'TABLE', [StateProvince], N'INDEX', [AK_StateProvince_Name];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', N'SCHEMA', [Person], N'TABLE', [StateProvince], N'INDEX', [AK_StateProvince_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index.', N'SCHEMA', [Person], N'TABLE', [StateProvince], N'INDEX', [AK_StateProvince_StateProvinceCode_CountryRegionCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Person], N'TABLE', [StateProvince], N'CONSTRAINT', [PK_StateProvince_StateProvinceID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing CountryRegion.CountryRegionCode.', N'SCHEMA', [Person], N'TABLE', [StateProvince], N'CONSTRAINT', [FK_StateProvince_CountryRegion_CountryRegionCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 1 (TRUE)', N'SCHEMA', [Person], N'TABLE', [StateProvince], N'CONSTRAINT', [DF_StateProvince_IsOnlyStateProvinceFlag];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Person], N'TABLE', [StateProvince], N'CONSTRAINT', [DF_StateProvince_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of NEWID()', N'SCHEMA', [Person], N'TABLE', [StateProvince], N'CONSTRAINT', [DF_StateProvince_rowguid];