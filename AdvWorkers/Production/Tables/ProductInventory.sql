CREATE TABLE [Production].[ProductInventory](
    [ProductID] [int] NOT NULL,
    [LocationID] [smallint] NOT NULL,
    [Shelf] [nvarchar](10) NOT NULL, 
    [Bin] [tinyint] NOT NULL,
    [Quantity] [smallint] NOT NULL CONSTRAINT [DF_ProductInventory_Quantity] DEFAULT (0),
    [rowguid] uniqueidentifier ROWGUIDCOL NOT NULL CONSTRAINT [DF_ProductInventory_rowguid] DEFAULT (NEWID()), 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_ProductInventory_ModifiedDate] DEFAULT (GETDATE()),
    CONSTRAINT [CK_ProductInventory_Shelf] CHECK (([Shelf] LIKE '[A-Za-z]') OR ([Shelf] = 'N/A')),
    CONSTRAINT [CK_ProductInventory_Bin] CHECK ([Bin] BETWEEN 0 AND 100)
) ON [PRIMARY];
GO
ALTER TABLE [Production].[ProductInventory] ADD 
    CONSTRAINT [FK_ProductInventory_Location_LocationID] FOREIGN KEY 
    (
        [LocationID]
    ) REFERENCES [Production].[Location](
        [LocationID]
    ),
    CONSTRAINT [FK_ProductInventory_Product_ProductID] FOREIGN KEY 
    (
        [ProductID]
    ) REFERENCES [Production].[Product](
        [ProductID]
    );
GO
ALTER TABLE [Production].[ProductInventory] WITH CHECK ADD 
    CONSTRAINT [PK_ProductInventory_ProductID_LocationID] PRIMARY KEY CLUSTERED 
    (
    [ProductID],
    [LocationID]
    )  ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Product inventory information.', N'SCHEMA', [Production], N'TABLE', [ProductInventory], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Product identification number. Foreign key to Product.ProductID.', N'SCHEMA', [Production], N'TABLE', [ProductInventory], N'COLUMN', [ProductID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Inventory location identification number. Foreign key to Location.LocationID. ', N'SCHEMA', [Production], N'TABLE', [ProductInventory], N'COLUMN', [LocationID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Storage compartment within an inventory location.', N'SCHEMA', [Production], N'TABLE', [ProductInventory], N'COLUMN', [Shelf];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Storage container on a shelf in an inventory location.', N'SCHEMA', [Production], N'TABLE', [ProductInventory], N'COLUMN', [Bin];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Quantity of products in the inventory location.', N'SCHEMA', [Production], N'TABLE', [ProductInventory], N'COLUMN', [Quantity];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', N'SCHEMA', [Production], N'TABLE', [ProductInventory], N'COLUMN', [rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Production], N'TABLE', [ProductInventory], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Production], N'TABLE', [ProductInventory], N'CONSTRAINT', [PK_ProductInventory_ProductID_LocationID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Location.LocationID.', N'SCHEMA', [Production], N'TABLE', [ProductInventory], N'CONSTRAINT', [FK_ProductInventory_Location_LocationID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0', N'SCHEMA', [Production], N'TABLE', [ProductInventory], N'CONSTRAINT', [DF_ProductInventory_Quantity];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Production], N'TABLE', [ProductInventory], N'CONSTRAINT', [DF_ProductInventory_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of NEWID()', N'SCHEMA', [Production], N'TABLE', [ProductInventory], N'CONSTRAINT', [DF_ProductInventory_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [Bin] BETWEEN (0) AND (100)', N'SCHEMA', [Production], N'TABLE', [ProductInventory], N'CONSTRAINT', [CK_ProductInventory_Bin];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [Shelf] like ''[A-Za-z]'' OR [Shelf]=''N/A''', N'SCHEMA', [Production], N'TABLE', [ProductInventory], N'CONSTRAINT', [CK_ProductInventory_Shelf];