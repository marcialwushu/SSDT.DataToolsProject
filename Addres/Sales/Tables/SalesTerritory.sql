CREATE TABLE [Sales].[SalesTerritory](
    [TerritoryID] [int] IDENTITY (1, 1) NOT NULL,
    [Name] [Name] NOT NULL,
    [CountryRegionCode] [nvarchar](3) NOT NULL, 
    [Group] [nvarchar](50) NOT NULL,
    [SalesYTD] [money] NOT NULL CONSTRAINT [DF_SalesTerritory_SalesYTD] DEFAULT (0.00),
    [SalesLastYear] [money] NOT NULL CONSTRAINT [DF_SalesTerritory_SalesLastYear] DEFAULT (0.00),
    [CostYTD] [money] NOT NULL CONSTRAINT [DF_SalesTerritory_CostYTD] DEFAULT (0.00),
    [CostLastYear] [money] NOT NULL CONSTRAINT [DF_SalesTerritory_CostLastYear] DEFAULT (0.00),
    [rowguid] uniqueidentifier ROWGUIDCOL NOT NULL CONSTRAINT [DF_SalesTerritory_rowguid] DEFAULT (NEWID()), 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesTerritory_ModifiedDate] DEFAULT (GETDATE()), 
    CONSTRAINT [CK_SalesTerritory_SalesYTD] CHECK ([SalesYTD] >= 0.00), 
    CONSTRAINT [CK_SalesTerritory_SalesLastYear] CHECK ([SalesLastYear] >= 0.00), 
    CONSTRAINT [CK_SalesTerritory_CostYTD] CHECK ([CostYTD] >= 0.00), 
    CONSTRAINT [CK_SalesTerritory_CostLastYear] CHECK ([CostLastYear] >= 0.00) 
) ON [PRIMARY];
GO
ALTER TABLE [Sales].[SalesTerritory] ADD
	CONSTRAINT [FK_SalesTerritory_CountryRegion_CountryRegionCode] FOREIGN KEY
	(
		[CountryRegionCode]
	) REFERENCES [Person].[CountryRegion] (
		[CountryRegionCode]
    );
GO
ALTER TABLE [Sales].[SalesTerritory] WITH CHECK ADD 
    CONSTRAINT [PK_SalesTerritory_TerritoryID] PRIMARY KEY CLUSTERED 
    (
        [TerritoryID]
    )  ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_SalesTerritory_Name] ON [Sales].[SalesTerritory]([Name]) ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_SalesTerritory_rowguid] ON [Sales].[SalesTerritory]([rowguid]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Sales territory lookup table.', N'SCHEMA', [Sales], N'TABLE', [SalesTerritory], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key for SalesTerritory records.', N'SCHEMA', [Sales], N'TABLE', [SalesTerritory], N'COLUMN', [TerritoryID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Sales territory description', N'SCHEMA', [Sales], N'TABLE', [SalesTerritory], N'COLUMN', [Name];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ISO standard country or region code. Foreign key to CountryRegion.CountryRegionCode. ', N'SCHEMA', [Sales], N'TABLE', [SalesTerritory], N'COLUMN', [CountryRegionCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Geographic area to which the sales territory belong.', N'SCHEMA', [Sales], N'TABLE', [SalesTerritory], N'COLUMN', [Group];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Sales in the territory year to date.', N'SCHEMA', [Sales], N'TABLE', [SalesTerritory], N'COLUMN', [SalesYTD];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Sales in the territory the previous year.', N'SCHEMA', [Sales], N'TABLE', [SalesTerritory], N'COLUMN', [SalesLastYear];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Business costs in the territory year to date.', N'SCHEMA', [Sales], N'TABLE', [SalesTerritory], N'COLUMN', [CostYTD];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Business costs in the territory the previous year.', N'SCHEMA', [Sales], N'TABLE', [SalesTerritory], N'COLUMN', [CostLastYear];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', N'SCHEMA', [Sales], N'TABLE', [SalesTerritory], N'COLUMN', [rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Sales], N'TABLE', [SalesTerritory], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index.', N'SCHEMA', [Sales], N'TABLE', [SalesTerritory], N'INDEX', [AK_SalesTerritory_Name];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', N'SCHEMA', [Sales], N'TABLE', [SalesTerritory], N'INDEX', [AK_SalesTerritory_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Sales], N'TABLE', [SalesTerritory], N'CONSTRAINT', [PK_SalesTerritory_TerritoryID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0.0', N'SCHEMA', [Sales], N'TABLE', [SalesTerritory], N'CONSTRAINT', [DF_SalesTerritory_CostLastYear];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0.0', N'SCHEMA', [Sales], N'TABLE', [SalesTerritory], N'CONSTRAINT', [DF_SalesTerritory_CostYTD];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0.0', N'SCHEMA', [Sales], N'TABLE', [SalesTerritory], N'CONSTRAINT', [DF_SalesTerritory_SalesLastYear];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0.0', N'SCHEMA', [Sales], N'TABLE', [SalesTerritory], N'CONSTRAINT', [DF_SalesTerritory_SalesYTD];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Sales], N'TABLE', [SalesTerritory], N'CONSTRAINT', [DF_SalesTerritory_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of NEWID()', N'SCHEMA', [Sales], N'TABLE', [SalesTerritory], N'CONSTRAINT', [DF_SalesTerritory_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [CostLastYear] >= (0.00)', N'SCHEMA', [Sales], N'TABLE', [SalesTerritory], N'CONSTRAINT', [CK_SalesTerritory_CostLastYear];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [CostYTD] >= (0.00)', N'SCHEMA', [Sales], N'TABLE', [SalesTerritory], N'CONSTRAINT', [CK_SalesTerritory_CostYTD];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [SalesLastYear] >= (0.00)', N'SCHEMA', [Sales], N'TABLE', [SalesTerritory], N'CONSTRAINT', [CK_SalesTerritory_SalesLastYear];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [SalesYTD] >= (0.00)', N'SCHEMA', [Sales], N'TABLE', [SalesTerritory], N'CONSTRAINT', [CK_SalesTerritory_SalesYTD];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing CountryRegion.CountryRegionCode.', N'SCHEMA', [Sales], N'TABLE', [SalesTerritory], N'CONSTRAINT', [FK_SalesTerritory_CountryRegion_CountryRegionCode];