CREATE TABLE [Sales].[Customer](
	[CustomerID] [int] IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
	-- A customer may either be a person, a store, or a person who works for a store
	[PersonID] [int] NULL, -- If this customer represents a person, this is non-null
    [StoreID] [int] NULL,  -- If the customer is a store, or is associated with a store then this is non-null.
    [TerritoryID] [int] NULL,
    [AccountNumber] AS ISNULL('AW' + [dbo].[ufnLeadingZeros](CustomerID), ''),
    [rowguid] uniqueidentifier ROWGUIDCOL NOT NULL CONSTRAINT [DF_Customer_rowguid] DEFAULT (NEWID()), 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Customer_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO
ALTER TABLE [Sales].[Customer] ADD 
    CONSTRAINT [FK_Customer_Person_PersonID] FOREIGN KEY 
    (
        [PersonID]
    ) REFERENCES [Person].[Person](
        [BusinessEntityID]
    ),
    CONSTRAINT [FK_Customer_Store_StoreID] FOREIGN KEY 
    (
        [StoreID]
    ) REFERENCES [Sales].[Store](
        [BusinessEntityID]
    ),
    CONSTRAINT [FK_Customer_SalesTerritory_TerritoryID] FOREIGN KEY 
    (
        [TerritoryID]
    ) REFERENCES [Sales].[SalesTerritory](
        [TerritoryID]
    );
GO
ALTER TABLE [Sales].[Customer] WITH CHECK ADD 
    CONSTRAINT [PK_Customer_CustomerID] PRIMARY KEY CLUSTERED 
    (
        [CustomerID]
    )  ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_Customer_rowguid] ON [Sales].[Customer]([rowguid]) ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_Customer_AccountNumber] ON [Sales].[Customer]([AccountNumber]) ON [PRIMARY];
GO
CREATE INDEX [IX_Customer_TerritoryID] ON [Sales].[Customer]([TerritoryID]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Current customer information. Also see the Person and Store tables.', N'SCHEMA', [Sales], N'TABLE', [Customer], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key.', N'SCHEMA', [Sales], N'TABLE', [Customer], N'COLUMN', [CustomerID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key to Person.BusinessEntityID', N'SCHEMA', [Sales], N'TABLE', [Customer], N'COLUMN', [PersonID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key to Store.BusinessEntityID', N'SCHEMA', [Sales], N'TABLE', [Customer], N'COLUMN', [StoreID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ID of the territory in which the customer is located. Foreign key to SalesTerritory.SalesTerritoryID.', N'SCHEMA', [Sales], N'TABLE', [Customer], N'COLUMN', [TerritoryID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique number identifying the customer assigned by the accounting system.', N'SCHEMA', [Sales], N'TABLE', [Customer], N'COLUMN', [AccountNumber];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', N'SCHEMA', [Sales], N'TABLE', [Customer], N'COLUMN', [rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Sales], N'TABLE', [Customer], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index.', N'SCHEMA', [Sales], N'TABLE', [Customer], N'INDEX', [AK_Customer_AccountNumber];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', N'SCHEMA', [Sales], N'TABLE', [Customer], N'INDEX', [AK_Customer_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index.', N'SCHEMA', [Sales], N'TABLE', [Customer], N'INDEX', [IX_Customer_TerritoryID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Sales], N'TABLE', [Customer], N'CONSTRAINT', [PK_Customer_CustomerID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Person.BusinessEntityID.', N'SCHEMA', [Sales], N'TABLE', [Customer], N'CONSTRAINT', [FK_Customer_Person_PersonID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Sales], N'TABLE', [Customer], N'CONSTRAINT', [DF_Customer_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of NEWID()', N'SCHEMA', [Sales], N'TABLE', [Customer], N'CONSTRAINT', [DF_Customer_rowguid];