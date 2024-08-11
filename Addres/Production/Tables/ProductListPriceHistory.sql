CREATE TABLE [Production].[ProductListPriceHistory](
    [ProductID] [int] NOT NULL,
    [StartDate] [datetime] NOT NULL,
    [EndDate] [datetime] NULL,
    [ListPrice] [money] NOT NULL, 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_ProductListPriceHistory_ModifiedDate] DEFAULT (GETDATE()), 
    CONSTRAINT [CK_ProductListPriceHistory_EndDate] CHECK (([EndDate] >= [StartDate]) OR ([EndDate] IS NULL)),
    CONSTRAINT [CK_ProductListPriceHistory_ListPrice] CHECK ([ListPrice] > 0.00)
) ON [PRIMARY];
GO
ALTER TABLE [Production].[ProductListPriceHistory] ADD 
    CONSTRAINT [FK_ProductListPriceHistory_Product_ProductID] FOREIGN KEY 
    (
        [ProductID]
    ) REFERENCES [Production].[Product](
        [ProductID]
    );
GO
ALTER TABLE [Production].[ProductListPriceHistory] WITH CHECK ADD 
    CONSTRAINT [PK_ProductListPriceHistory_ProductID_StartDate] PRIMARY KEY CLUSTERED 
    (
        [ProductID],
        [StartDate]
    )  ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Changes in the list price of a product over time.', N'SCHEMA', [Production], N'TABLE', [ProductListPriceHistory], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Product identification number. Foreign key to Product.ProductID', N'SCHEMA', [Production], N'TABLE', [ProductListPriceHistory], N'COLUMN', [ProductID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'List price start date.', N'SCHEMA', [Production], N'TABLE', [ProductListPriceHistory], N'COLUMN', [StartDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'List price end date', N'SCHEMA', [Production], N'TABLE', [ProductListPriceHistory], N'COLUMN', [EndDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Product list price.', N'SCHEMA', [Production], N'TABLE', [ProductListPriceHistory], N'COLUMN', [ListPrice];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Production], N'TABLE', [ProductListPriceHistory], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Production], N'TABLE', [ProductListPriceHistory], N'CONSTRAINT', [PK_ProductListPriceHistory_ProductID_StartDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Product.ProductID.', N'SCHEMA', [Production], N'TABLE', [ProductListPriceHistory], N'CONSTRAINT', [FK_ProductListPriceHistory_Product_ProductID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Production], N'TABLE', [ProductListPriceHistory], N'CONSTRAINT', [DF_ProductListPriceHistory_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [ListPrice] > (0.00)', N'SCHEMA', [Production], N'TABLE', [ProductListPriceHistory], N'CONSTRAINT', [CK_ProductListPriceHistory_ListPrice];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [EndDate] >= [StartDate] OR [EndDate] IS NULL', N'SCHEMA', [Production], N'TABLE', [ProductListPriceHistory], N'CONSTRAINT', [CK_ProductListPriceHistory_EndDate];