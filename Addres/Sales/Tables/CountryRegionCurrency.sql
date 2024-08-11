CREATE TABLE [Sales].[CountryRegionCurrency](
    [CountryRegionCode] [nvarchar](3) NOT NULL, 
    [CurrencyCode] [nchar](3) NOT NULL, 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_CountryRegionCurrency_ModifiedDate] DEFAULT (GETDATE()) 
) ON [PRIMARY];
GO
ALTER TABLE [Sales].[CountryRegionCurrency] ADD 
    CONSTRAINT [FK_CountryRegionCurrency_CountryRegion_CountryRegionCode] FOREIGN KEY 
    (
        [CountryRegionCode]
    ) REFERENCES [Person].[CountryRegion](
        [CountryRegionCode]
    ),
    CONSTRAINT [FK_CountryRegionCurrency_Currency_CurrencyCode] FOREIGN KEY 
    (
        [CurrencyCode]
    ) REFERENCES [Sales].[Currency](
        [CurrencyCode]
    );
GO
ALTER TABLE [Sales].[CountryRegionCurrency] WITH CHECK ADD 
    CONSTRAINT [PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode] PRIMARY KEY CLUSTERED 
    (
        [CountryRegionCode],
        [CurrencyCode]
    )  ON [PRIMARY];
GO
CREATE INDEX [IX_CountryRegionCurrency_CurrencyCode] ON [Sales].[CountryRegionCurrency]([CurrencyCode]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Cross-reference table mapping ISO currency codes to a country or region.', N'SCHEMA', [Sales], N'TABLE', [CountryRegionCurrency], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ISO code for countries and regions. Foreign key to CountryRegion.CountryRegionCode.', N'SCHEMA', [Sales], N'TABLE', [CountryRegionCurrency], N'COLUMN', [CountryRegionCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ISO standard currency code. Foreign key to Currency.CurrencyCode.', N'SCHEMA', [Sales], N'TABLE', [CountryRegionCurrency], N'COLUMN', [CurrencyCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Sales], N'TABLE', [CountryRegionCurrency], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index.', N'SCHEMA', [Sales], N'TABLE', [CountryRegionCurrency], N'INDEX', [IX_CountryRegionCurrency_CurrencyCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Sales], N'TABLE', [CountryRegionCurrency], N'CONSTRAINT', [PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing CountryRegion.CountryRegionCode.', N'SCHEMA', [Sales], N'TABLE', [CountryRegionCurrency], N'CONSTRAINT', [FK_CountryRegionCurrency_CountryRegion_CountryRegionCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Sales], N'TABLE', [CountryRegionCurrency], N'CONSTRAINT', [DF_CountryRegionCurrency_ModifiedDate];