CREATE TABLE [Sales].[SalesPerson](
    [BusinessEntityID] [int] NOT NULL,
    [TerritoryID] [int] NULL,
    [SalesQuota] [money] NULL,
    [Bonus] [money] NOT NULL CONSTRAINT [DF_SalesPerson_Bonus] DEFAULT (0.00),
    [CommissionPct] [smallmoney] NOT NULL CONSTRAINT [DF_SalesPerson_CommissionPct] DEFAULT (0.00),
    [SalesYTD] [money] NOT NULL CONSTRAINT [DF_SalesPerson_SalesYTD] DEFAULT (0.00),
    [SalesLastYear] [money] NOT NULL CONSTRAINT [DF_SalesPerson_SalesLastYear] DEFAULT (0.00),
    [rowguid] uniqueidentifier ROWGUIDCOL NOT NULL CONSTRAINT [DF_SalesPerson_rowguid] DEFAULT (NEWID()), 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesPerson_ModifiedDate] DEFAULT (GETDATE()), 
    CONSTRAINT [CK_SalesPerson_SalesQuota] CHECK ([SalesQuota] > 0.00), 
    CONSTRAINT [CK_SalesPerson_Bonus] CHECK ([Bonus] >= 0.00), 
    CONSTRAINT [CK_SalesPerson_CommissionPct] CHECK ([CommissionPct] >= 0.00), 
    CONSTRAINT [CK_SalesPerson_SalesYTD] CHECK ([SalesYTD] >= 0.00), 
    CONSTRAINT [CK_SalesPerson_SalesLastYear] CHECK ([SalesLastYear] >= 0.00) 
) ON [PRIMARY];
GO
ALTER TABLE [Sales].[SalesPerson] ADD 
    CONSTRAINT [FK_SalesPerson_Employee_BusinessEntityID] FOREIGN KEY 
    (
        [BusinessEntityID]
    ) REFERENCES [HumanResources].[Employee](
        [BusinessEntityID]
    ),
    CONSTRAINT [FK_SalesPerson_SalesTerritory_TerritoryID] FOREIGN KEY 
    (
        [TerritoryID]
    ) REFERENCES [Sales].[SalesTerritory](
        [TerritoryID]
    );
GO
ALTER TABLE [Sales].[SalesPerson] WITH CHECK ADD 
    CONSTRAINT [PK_SalesPerson_BusinessEntityID] PRIMARY KEY CLUSTERED 
    (
        [BusinessEntityID]
    )  ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_SalesPerson_rowguid] ON [Sales].[SalesPerson]([rowguid]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Sales representative current information.', N'SCHEMA', [Sales], N'TABLE', [SalesPerson], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key for SalesPerson records. Foreign key to Employee.BusinessEntityID', N'SCHEMA', [Sales], N'TABLE', [SalesPerson], N'COLUMN', [BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Territory currently assigned to. Foreign key to SalesTerritory.SalesTerritoryID.', N'SCHEMA', [Sales], N'TABLE', [SalesPerson], N'COLUMN', [TerritoryID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Projected yearly sales.', N'SCHEMA', [Sales], N'TABLE', [SalesPerson], N'COLUMN', [SalesQuota];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Bonus due if quota is met.', N'SCHEMA', [Sales], N'TABLE', [SalesPerson], N'COLUMN', [Bonus];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Commision percent received per sale.', N'SCHEMA', [Sales], N'TABLE', [SalesPerson], N'COLUMN', [CommissionPct];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Sales total year to date.', N'SCHEMA', [Sales], N'TABLE', [SalesPerson], N'COLUMN', [SalesYTD];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Sales total of previous year.', N'SCHEMA', [Sales], N'TABLE', [SalesPerson], N'COLUMN', [SalesLastYear];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', N'SCHEMA', [Sales], N'TABLE', [SalesPerson], N'COLUMN', [rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Sales], N'TABLE', [SalesPerson], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', N'SCHEMA', [Sales], N'TABLE', [SalesPerson], N'INDEX', [AK_SalesPerson_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Sales], N'TABLE', [SalesPerson], N'CONSTRAINT', [PK_SalesPerson_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Employee.EmployeeID.', N'SCHEMA', [Sales], N'TABLE', [SalesPerson], N'CONSTRAINT', [FK_SalesPerson_Employee_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0.0', N'SCHEMA', [Sales], N'TABLE', [SalesPerson], N'CONSTRAINT', [DF_SalesPerson_Bonus];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0.0', N'SCHEMA', [Sales], N'TABLE', [SalesPerson], N'CONSTRAINT', [DF_SalesPerson_CommissionPct];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0.0', N'SCHEMA', [Sales], N'TABLE', [SalesPerson], N'CONSTRAINT', [DF_SalesPerson_SalesLastYear];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0.0', N'SCHEMA', [Sales], N'TABLE', [SalesPerson], N'CONSTRAINT', [DF_SalesPerson_SalesYTD];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Sales], N'TABLE', [SalesPerson], N'CONSTRAINT', [DF_SalesPerson_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of NEWID()', N'SCHEMA', [Sales], N'TABLE', [SalesPerson], N'CONSTRAINT', [DF_SalesPerson_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [Bonus] >= (0.00)', N'SCHEMA', [Sales], N'TABLE', [SalesPerson], N'CONSTRAINT', [CK_SalesPerson_Bonus];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [CommissionPct] >= (0.00)', N'SCHEMA', [Sales], N'TABLE', [SalesPerson], N'CONSTRAINT', [CK_SalesPerson_CommissionPct];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [SalesLastYear] >= (0.00)', N'SCHEMA', [Sales], N'TABLE', [SalesPerson], N'CONSTRAINT', [CK_SalesPerson_SalesLastYear];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [SalesQuota] > (0.00)', N'SCHEMA', [Sales], N'TABLE', [SalesPerson], N'CONSTRAINT', [CK_SalesPerson_SalesQuota];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [SalesYTD] >= (0.00)', N'SCHEMA', [Sales], N'TABLE', [SalesPerson], N'CONSTRAINT', [CK_SalesPerson_SalesYTD];