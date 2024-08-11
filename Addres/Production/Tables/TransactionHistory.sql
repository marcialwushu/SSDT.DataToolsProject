CREATE TABLE [Production].[TransactionHistory](
    [TransactionID] [int] IDENTITY (100000, 1) NOT NULL,
    [ProductID] [int] NOT NULL,
    [ReferenceOrderID] [int] NOT NULL,
    [ReferenceOrderLineID] [int] NOT NULL CONSTRAINT [DF_TransactionHistory_ReferenceOrderLineID] DEFAULT (0),
    [TransactionDate] [datetime] NOT NULL CONSTRAINT [DF_TransactionHistory_TransactionDate] DEFAULT (GETDATE()),
    [TransactionType] [nchar](1) NOT NULL, 
    [Quantity] [int] NOT NULL,
    [ActualCost] [money] NOT NULL, 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TransactionHistory_ModifiedDate] DEFAULT (GETDATE()),
    CONSTRAINT [CK_TransactionHistory_TransactionType] CHECK (UPPER([TransactionType]) IN ('W', 'S', 'P'))
) ON [PRIMARY];
GO
ALTER TABLE [Production].[TransactionHistory] ADD 
    CONSTRAINT [FK_TransactionHistory_Product_ProductID] FOREIGN KEY 
    (
        [ProductID]
    ) REFERENCES [Production].[Product](
        [ProductID]
    );
GO
ALTER TABLE [Production].[TransactionHistory] WITH CHECK ADD 
    CONSTRAINT [PK_TransactionHistory_TransactionID] PRIMARY KEY CLUSTERED 
    (
        [TransactionID]
    )  ON [PRIMARY];
GO
CREATE INDEX [IX_TransactionHistory_ProductID] ON [Production].[TransactionHistory]([ProductID]) ON [PRIMARY];
GO
CREATE INDEX [IX_TransactionHistory_ReferenceOrderID_ReferenceOrderLineID] ON [Production].[TransactionHistory]([ReferenceOrderID], [ReferenceOrderLineID]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Record of each purchase order, sales order, or work order transaction year to date.', N'SCHEMA', [Production], N'TABLE', [TransactionHistory], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key for TransactionHistory records.', N'SCHEMA', [Production], N'TABLE', [TransactionHistory], N'COLUMN', [TransactionID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Product identification number. Foreign key to Product.ProductID.', N'SCHEMA', [Production], N'TABLE', [TransactionHistory], N'COLUMN', [ProductID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Purchase order, sales order, or work order identification number.', N'SCHEMA', [Production], N'TABLE', [TransactionHistory], N'COLUMN', [ReferenceOrderID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Line number associated with the purchase order, sales order, or work order.', N'SCHEMA', [Production], N'TABLE', [TransactionHistory], N'COLUMN', [ReferenceOrderLineID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time of the transaction.', N'SCHEMA', [Production], N'TABLE', [TransactionHistory], N'COLUMN', [TransactionDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'W = WorkOrder, S = SalesOrder, P = PurchaseOrder', N'SCHEMA', [Production], N'TABLE', [TransactionHistory], N'COLUMN', [TransactionType];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Product quantity.', N'SCHEMA', [Production], N'TABLE', [TransactionHistory], N'COLUMN', [Quantity];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Product cost.', N'SCHEMA', [Production], N'TABLE', [TransactionHistory], N'COLUMN', [ActualCost];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Production], N'TABLE', [TransactionHistory], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index.', N'SCHEMA', [Production], N'TABLE', [TransactionHistory], N'INDEX', [IX_TransactionHistory_ProductID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index.', N'SCHEMA', [Production], N'TABLE', [TransactionHistory], N'INDEX', [IX_TransactionHistory_ReferenceOrderID_ReferenceOrderLineID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Production], N'TABLE', [TransactionHistory], N'CONSTRAINT', [PK_TransactionHistory_TransactionID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Product.ProductID.', N'SCHEMA', [Production], N'TABLE', [TransactionHistory], N'CONSTRAINT', [FK_TransactionHistory_Product_ProductID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0', N'SCHEMA', [Production], N'TABLE', [TransactionHistory], N'CONSTRAINT', [DF_TransactionHistory_ReferenceOrderLineID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Production], N'TABLE', [TransactionHistory], N'CONSTRAINT', [DF_TransactionHistory_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Production], N'TABLE', [TransactionHistory], N'CONSTRAINT', [DF_TransactionHistory_TransactionDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [TransactionType]=''p'' OR [TransactionType]=''s'' OR [TransactionType]=''w'' OR [TransactionType]=''P'' OR [TransactionType]=''S'' OR [TransactionType]=''W'')', N'SCHEMA', [Production], N'TABLE', [TransactionHistory], N'CONSTRAINT', [CK_TransactionHistory_TransactionType];