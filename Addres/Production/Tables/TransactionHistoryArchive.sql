CREATE TABLE [Production].[TransactionHistoryArchive](
    [TransactionID] [int] NOT NULL,
    [ProductID] [int] NOT NULL,
    [ReferenceOrderID] [int] NOT NULL,
    [ReferenceOrderLineID] [int] NOT NULL CONSTRAINT [DF_TransactionHistoryArchive_ReferenceOrderLineID] DEFAULT (0),
    [TransactionDate] [datetime] NOT NULL CONSTRAINT [DF_TransactionHistoryArchive_TransactionDate] DEFAULT (GETDATE()),
    [TransactionType] [nchar](1) NOT NULL, 
    [Quantity] [int] NOT NULL,
    [ActualCost] [money] NOT NULL, 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_TransactionHistoryArchive_ModifiedDate] DEFAULT (GETDATE()),
    CONSTRAINT [CK_TransactionHistoryArchive_TransactionType] CHECK (UPPER([TransactionType]) IN ('W', 'S', 'P'))
) ON [PRIMARY];
GO
ALTER TABLE [Production].[TransactionHistoryArchive] WITH CHECK ADD 
    CONSTRAINT [PK_TransactionHistoryArchive_TransactionID] PRIMARY KEY CLUSTERED 
    (
        [TransactionID]
    )  ON [PRIMARY];
GO
CREATE INDEX [IX_TransactionHistoryArchive_ProductID] ON [Production].[TransactionHistoryArchive]([ProductID]) ON [PRIMARY];
GO
CREATE INDEX [IX_TransactionHistoryArchive_ReferenceOrderID_ReferenceOrderLineID] ON [Production].[TransactionHistoryArchive]([ReferenceOrderID], [ReferenceOrderLineID]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Transactions for previous years.', N'SCHEMA', [Production], N'TABLE', [TransactionHistoryArchive], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key for TransactionHistoryArchive records.', N'SCHEMA', [Production], N'TABLE', [TransactionHistoryArchive], N'COLUMN', [TransactionID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Product identification number. Foreign key to Product.ProductID.', N'SCHEMA', [Production], N'TABLE', [TransactionHistoryArchive], N'COLUMN', [ProductID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Purchase order, sales order, or work order identification number.', N'SCHEMA', [Production], N'TABLE', [TransactionHistoryArchive], N'COLUMN', [ReferenceOrderID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Line number associated with the purchase order, sales order, or work order.', N'SCHEMA', [Production], N'TABLE', [TransactionHistoryArchive], N'COLUMN', [ReferenceOrderLineID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time of the transaction.', N'SCHEMA', [Production], N'TABLE', [TransactionHistoryArchive], N'COLUMN', [TransactionDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'W = Work Order, S = Sales Order, P = Purchase Order', N'SCHEMA', [Production], N'TABLE', [TransactionHistoryArchive], N'COLUMN', [TransactionType];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Product quantity.', N'SCHEMA', [Production], N'TABLE', [TransactionHistoryArchive], N'COLUMN', [Quantity];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Product cost.', N'SCHEMA', [Production], N'TABLE', [TransactionHistoryArchive], N'COLUMN', [ActualCost];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Production], N'TABLE', [TransactionHistoryArchive], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index.', N'SCHEMA', [Production], N'TABLE', [TransactionHistoryArchive], N'INDEX', [IX_TransactionHistoryArchive_ProductID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index.', N'SCHEMA', [Production], N'TABLE', [TransactionHistoryArchive], N'INDEX', [IX_TransactionHistoryArchive_ReferenceOrderID_ReferenceOrderLineID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Production], N'TABLE', [TransactionHistoryArchive], N'CONSTRAINT', [PK_TransactionHistoryArchive_TransactionID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0', N'SCHEMA', [Production], N'TABLE', [TransactionHistoryArchive], N'CONSTRAINT', [DF_TransactionHistoryArchive_ReferenceOrderLineID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Production], N'TABLE', [TransactionHistoryArchive], N'CONSTRAINT', [DF_TransactionHistoryArchive_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Production], N'TABLE', [TransactionHistoryArchive], N'CONSTRAINT', [DF_TransactionHistoryArchive_TransactionDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [TransactionType]=''p'' OR [TransactionType]=''s'' OR [TransactionType]=''w'' OR [TransactionType]=''P'' OR [TransactionType]=''S'' OR [TransactionType]=''W''', N'SCHEMA', [Production], N'TABLE', [TransactionHistoryArchive], N'CONSTRAINT', [CK_TransactionHistoryArchive_TransactionType];