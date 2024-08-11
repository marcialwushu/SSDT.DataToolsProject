CREATE TABLE [Production].[ProductModel](
    [ProductModelID] [int] IDENTITY (1, 1) NOT NULL,
    [Name] [Name] NOT NULL,
    [CatalogDescription] [XML]([Production].[ProductDescriptionSchemaCollection]) NULL,
    [Instructions] [XML]([Production].[ManuInstructionsSchemaCollection]) NULL,
    [rowguid] uniqueidentifier ROWGUIDCOL NOT NULL CONSTRAINT [DF_ProductModel_rowguid] DEFAULT (NEWID()), 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_ProductModel_ModifiedDate] DEFAULT (GETDATE()) 
) ON [PRIMARY];
GO
ALTER TABLE [Production].[ProductModel] WITH CHECK ADD 
    CONSTRAINT [PK_ProductModel_ProductModelID] PRIMARY KEY CLUSTERED 
    (
        [ProductModelID]
    )  ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_ProductModel_Name] ON [Production].[ProductModel]([Name]) ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_ProductModel_rowguid] ON [Production].[ProductModel]([rowguid]) ON [PRIMARY];
GO
CREATE PRIMARY XML INDEX [PXML_ProductModel_CatalogDescription] ON [Production].[ProductModel]([CatalogDescription]);
GO
CREATE PRIMARY XML INDEX [PXML_ProductModel_Instructions] ON [Production].[ProductModel]([Instructions]);
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Product model classification.', N'SCHEMA', [Production], N'TABLE', [ProductModel], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key for ProductModel records.', N'SCHEMA', [Production], N'TABLE', [ProductModel], N'COLUMN', [ProductModelID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Product model description.', N'SCHEMA', [Production], N'TABLE', [ProductModel], N'COLUMN', [Name];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Detailed product catalog information in xml format.', N'SCHEMA', [Production], N'TABLE', [ProductModel], N'COLUMN', [CatalogDescription];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Manufacturing instructions in xml format.', N'SCHEMA', [Production], N'TABLE', [ProductModel], N'COLUMN', [Instructions];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', N'SCHEMA', [Production], N'TABLE', [ProductModel], N'COLUMN', [rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Production], N'TABLE', [ProductModel], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index.', N'SCHEMA', [Production], N'TABLE', [ProductModel], N'INDEX', [AK_ProductModel_Name];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', N'SCHEMA', [Production], N'TABLE', [ProductModel], N'INDEX', [AK_ProductModel_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary XML index.', N'SCHEMA', [Production], N'TABLE', [ProductModel], N'INDEX', [PXML_ProductModel_CatalogDescription];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary XML index.', N'SCHEMA', [Production], N'TABLE', [ProductModel], N'INDEX', [PXML_ProductModel_Instructions];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Production], N'TABLE', [ProductModel], N'CONSTRAINT', [PK_ProductModel_ProductModelID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Production], N'TABLE', [ProductModel], N'CONSTRAINT', [DF_ProductModel_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of NEWID()', N'SCHEMA', [Production], N'TABLE', [ProductModel], N'CONSTRAINT', [DF_ProductModel_rowguid];