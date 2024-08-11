CREATE TABLE [Purchasing].[ProductVendor](
    [ProductID] [int] NOT NULL,
    [BusinessEntityID] [int] NOT NULL,
    [AverageLeadTime] [int] NOT NULL,
    [StandardPrice] [money] NOT NULL,
    [LastReceiptCost] [money] NULL,
    [LastReceiptDate] [datetime] NULL,
    [MinOrderQty] [int] NOT NULL,
    [MaxOrderQty] [int] NOT NULL,
    [OnOrderQty] [int] NULL,
    [UnitMeasureCode] [nchar](3) NOT NULL, 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_ProductVendor_ModifiedDate] DEFAULT (GETDATE()), 
    CONSTRAINT [CK_ProductVendor_AverageLeadTime] CHECK ([AverageLeadTime] >= 1),
    CONSTRAINT [CK_ProductVendor_StandardPrice] CHECK ([StandardPrice] > 0.00),
    CONSTRAINT [CK_ProductVendor_LastReceiptCost] CHECK ([LastReceiptCost] > 0.00),
    CONSTRAINT [CK_ProductVendor_MinOrderQty] CHECK ([MinOrderQty] >= 1),
    CONSTRAINT [CK_ProductVendor_MaxOrderQty] CHECK ([MaxOrderQty] >= 1),
    CONSTRAINT [CK_ProductVendor_OnOrderQty] CHECK ([OnOrderQty] >= 0)
) ON [PRIMARY];
GO
ALTER TABLE [Purchasing].[ProductVendor] ADD 
    CONSTRAINT [FK_ProductVendor_Product_ProductID] FOREIGN KEY 
    (
        [ProductID]
    ) REFERENCES [Production].[Product](
        [ProductID]
    ),
    CONSTRAINT [FK_ProductVendor_UnitMeasure_UnitMeasureCode] FOREIGN KEY 
    (
        [UnitMeasureCode]
    ) REFERENCES [Production].[UnitMeasure](
        [UnitMeasureCode]
    ),
    CONSTRAINT [FK_ProductVendor_Vendor_BusinessEntityID] FOREIGN KEY 
    (
        [BusinessEntityID]
    ) REFERENCES [Purchasing].[Vendor](
        [BusinessEntityID]
    );
GO
ALTER TABLE [Purchasing].[ProductVendor] WITH CHECK ADD 
    CONSTRAINT [PK_ProductVendor_ProductID_BusinessEntityID] PRIMARY KEY CLUSTERED 
    (
        [ProductID],
        [BusinessEntityID]
    )  ON [PRIMARY];
GO
CREATE INDEX [IX_ProductVendor_UnitMeasureCode] ON [Purchasing].[ProductVendor]([UnitMeasureCode]) ON [PRIMARY];
GO
CREATE INDEX [IX_ProductVendor_BusinessEntityID] ON [Purchasing].[ProductVendor]([BusinessEntityID]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Cross-reference table mapping vendors with the products they supply.', N'SCHEMA', [Purchasing], N'TABLE', [ProductVendor], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key. Foreign key to Product.ProductID.', N'SCHEMA', [Purchasing], N'TABLE', [ProductVendor], N'COLUMN', [ProductID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key. Foreign key to Vendor.BusinessEntityID.', N'SCHEMA', [Purchasing], N'TABLE', [ProductVendor], N'COLUMN', [BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'The average span of time (in days) between placing an order with the vendor and receiving the purchased product.', N'SCHEMA', [Purchasing], N'TABLE', [ProductVendor], N'COLUMN', [AverageLeadTime];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'The vendor''s usual selling price.', N'SCHEMA', [Purchasing], N'TABLE', [ProductVendor], N'COLUMN', [StandardPrice];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'The selling price when last purchased.', N'SCHEMA', [Purchasing], N'TABLE', [ProductVendor], N'COLUMN', [LastReceiptCost];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date the product was last received by the vendor.', N'SCHEMA', [Purchasing], N'TABLE', [ProductVendor], N'COLUMN', [LastReceiptDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'The maximum quantity that should be ordered.', N'SCHEMA', [Purchasing], N'TABLE', [ProductVendor], N'COLUMN', [MinOrderQty];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'The minimum quantity that should be ordered.', N'SCHEMA', [Purchasing], N'TABLE', [ProductVendor], N'COLUMN', [MaxOrderQty];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'The quantity currently on order.', N'SCHEMA', [Purchasing], N'TABLE', [ProductVendor], N'COLUMN', [OnOrderQty];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'The product''s unit of measure.', N'SCHEMA', [Purchasing], N'TABLE', [ProductVendor], N'COLUMN', [UnitMeasureCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Purchasing], N'TABLE', [ProductVendor], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index.', N'SCHEMA', [Purchasing], N'TABLE', [ProductVendor], N'INDEX', [IX_ProductVendor_UnitMeasureCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index.', N'SCHEMA', [Purchasing], N'TABLE', [ProductVendor], N'INDEX', [IX_ProductVendor_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Purchasing], N'TABLE', [ProductVendor], N'CONSTRAINT', [PK_ProductVendor_ProductID_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Product.ProductID.', N'SCHEMA', [Purchasing], N'TABLE', [ProductVendor], N'CONSTRAINT', [FK_ProductVendor_Product_ProductID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Purchasing], N'TABLE', [ProductVendor], N'CONSTRAINT', [DF_ProductVendor_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [AverageLeadTime] >= (1)', N'SCHEMA', [Purchasing], N'TABLE', [ProductVendor], N'CONSTRAINT', [CK_ProductVendor_AverageLeadTime];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [LastReceiptCost] > (0.00)', N'SCHEMA', [Purchasing], N'TABLE', [ProductVendor], N'CONSTRAINT', [CK_ProductVendor_LastReceiptCost];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [MaxOrderQty] >= (1)', N'SCHEMA', [Purchasing], N'TABLE', [ProductVendor], N'CONSTRAINT', [CK_ProductVendor_MaxOrderQty];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [MinOrderQty] >= (1)', N'SCHEMA', [Purchasing], N'TABLE', [ProductVendor], N'CONSTRAINT', [CK_ProductVendor_MinOrderQty];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [OnOrderQty] >= (0)', N'SCHEMA', [Purchasing], N'TABLE', [ProductVendor], N'CONSTRAINT', [CK_ProductVendor_OnOrderQty];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [StandardPrice] > (0.00)', N'SCHEMA', [Purchasing], N'TABLE', [ProductVendor], N'CONSTRAINT', [CK_ProductVendor_StandardPrice];