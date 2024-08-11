CREATE TABLE [Sales].[SalesTaxRate](
    [SalesTaxRateID] [int] IDENTITY (1, 1) NOT NULL,
    [StateProvinceID] [int] NOT NULL,
    [TaxType] [tinyint] NOT NULL,
    [TaxRate] [smallmoney] NOT NULL CONSTRAINT [DF_SalesTaxRate_TaxRate] DEFAULT (0.00),
    [Name] [Name] NOT NULL,
    [rowguid] uniqueidentifier ROWGUIDCOL NOT NULL CONSTRAINT [DF_SalesTaxRate_rowguid] DEFAULT (NEWID()), 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesTaxRate_ModifiedDate] DEFAULT (GETDATE()),
    CONSTRAINT [CK_SalesTaxRate_TaxType] CHECK ([TaxType] BETWEEN 1 AND 3)
) ON [PRIMARY];
GO
ALTER TABLE [Sales].[SalesTaxRate] ADD 
    CONSTRAINT [FK_SalesTaxRate_StateProvince_StateProvinceID] FOREIGN KEY 
    (
        [StateProvinceID]
    ) REFERENCES [Person].[StateProvince](
        [StateProvinceID]
    );
GO
ALTER TABLE [Sales].[SalesTaxRate] WITH CHECK ADD 
    CONSTRAINT [PK_SalesTaxRate_SalesTaxRateID] PRIMARY KEY CLUSTERED 
    (
        [SalesTaxRateID]
    )  ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_SalesTaxRate_StateProvinceID_TaxType] ON [Sales].[SalesTaxRate]([StateProvinceID], [TaxType]) ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_SalesTaxRate_rowguid] ON [Sales].[SalesTaxRate]([rowguid]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Tax rate lookup table.', N'SCHEMA', [Sales], N'TABLE', [SalesTaxRate], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key for SalesTaxRate records.', N'SCHEMA', [Sales], N'TABLE', [SalesTaxRate], N'COLUMN', [SalesTaxRateID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'State, province, or country/region the sales tax applies to.', N'SCHEMA', [Sales], N'TABLE', [SalesTaxRate], N'COLUMN', [StateProvinceID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'1 = Tax applied to retail transactions, 2 = Tax applied to wholesale transactions, 3 = Tax applied to all sales (retail and wholesale) transactions.', N'SCHEMA', [Sales], N'TABLE', [SalesTaxRate], N'COLUMN', [TaxType];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Tax rate amount.', N'SCHEMA', [Sales], N'TABLE', [SalesTaxRate], N'COLUMN', [TaxRate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Tax rate description.', N'SCHEMA', [Sales], N'TABLE', [SalesTaxRate], N'COLUMN', [Name];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', N'SCHEMA', [Sales], N'TABLE', [SalesTaxRate], N'COLUMN', [rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Sales], N'TABLE', [SalesTaxRate], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', N'SCHEMA', [Sales], N'TABLE', [SalesTaxRate], N'INDEX', [AK_SalesTaxRate_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index.', N'SCHEMA', [Sales], N'TABLE', [SalesTaxRate], N'INDEX', [AK_SalesTaxRate_StateProvinceID_TaxType];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Sales], N'TABLE', [SalesTaxRate], N'CONSTRAINT', [PK_SalesTaxRate_SalesTaxRateID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing StateProvince.StateProvinceID.', N'SCHEMA', [Sales], N'TABLE', [SalesTaxRate], N'CONSTRAINT', [FK_SalesTaxRate_StateProvince_StateProvinceID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0.0', N'SCHEMA', [Sales], N'TABLE', [SalesTaxRate], N'CONSTRAINT', [DF_SalesTaxRate_TaxRate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Sales], N'TABLE', [SalesTaxRate], N'CONSTRAINT', [DF_SalesTaxRate_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of NEWID()', N'SCHEMA', [Sales], N'TABLE', [SalesTaxRate], N'CONSTRAINT', [DF_SalesTaxRate_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [TaxType] BETWEEN (1) AND (3)', N'SCHEMA', [Sales], N'TABLE', [SalesTaxRate], N'CONSTRAINT', [CK_SalesTaxRate_TaxType];