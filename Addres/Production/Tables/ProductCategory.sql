CREATE TABLE [Production].[ProductCategory](
    [ProductCategoryID] [int] IDENTITY (1, 1) NOT NULL,
    [Name] [Name] NOT NULL,
    [rowguid] uniqueidentifier ROWGUIDCOL NOT NULL CONSTRAINT [DF_ProductCategory_rowguid] DEFAULT (NEWID()), 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_ProductCategory_ModifiedDate] DEFAULT (GETDATE()) 
) ON [PRIMARY];
GO
ALTER TABLE [Production].[ProductCategory] WITH CHECK ADD 
    CONSTRAINT [PK_ProductCategory_ProductCategoryID] PRIMARY KEY CLUSTERED 
    (
        [ProductCategoryID]
    )  ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_ProductCategory_Name] ON [Production].[ProductCategory]([Name]) ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_ProductCategory_rowguid] ON [Production].[ProductCategory]([rowguid]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'High-level product categorization.', N'SCHEMA', [Production], N'TABLE', [ProductCategory], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key for ProductCategory records.', N'SCHEMA', [Production], N'TABLE', [ProductCategory], N'COLUMN', [ProductCategoryID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Category description.', N'SCHEMA', [Production], N'TABLE', [ProductCategory], N'COLUMN', [Name];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', N'SCHEMA', [Production], N'TABLE', [ProductCategory], N'COLUMN', [rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Production], N'TABLE', [ProductCategory], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index.', N'SCHEMA', [Production], N'TABLE', [ProductCategory], N'INDEX', [AK_ProductCategory_Name];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', N'SCHEMA', [Production], N'TABLE', [ProductCategory], N'INDEX', [AK_ProductCategory_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Production], N'TABLE', [ProductCategory], N'CONSTRAINT', [PK_ProductCategory_ProductCategoryID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Production], N'TABLE', [ProductCategory], N'CONSTRAINT', [DF_ProductCategory_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of NEWID()()', N'SCHEMA', [Production], N'TABLE', [ProductCategory], N'CONSTRAINT', [DF_ProductCategory_rowguid];