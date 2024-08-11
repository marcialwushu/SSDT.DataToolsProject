CREATE TABLE [Sales].[Currency](
    [CurrencyCode] [nchar](3) NOT NULL, 
    [Name] [Name] NOT NULL, 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Currency_ModifiedDate] DEFAULT (GETDATE()) 
) ON [PRIMARY];
GO
ALTER TABLE [Sales].[Currency] WITH CHECK ADD 
    CONSTRAINT [PK_Currency_CurrencyCode] PRIMARY KEY CLUSTERED 
    (
        [CurrencyCode]
    )  ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_Currency_Name] ON [Sales].[Currency]([Name]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Lookup table containing standard ISO currencies.', N'SCHEMA', [Sales], N'TABLE', [Currency], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'The ISO code for the Currency.', N'SCHEMA', [Sales], N'TABLE', [Currency], N'COLUMN', [CurrencyCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Currency name.', N'SCHEMA', [Sales], N'TABLE', [Currency], N'COLUMN', [Name];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Sales], N'TABLE', [Currency], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index.', N'SCHEMA', [Sales], N'TABLE', [Currency], N'INDEX', [AK_Currency_Name];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Sales], N'TABLE', [Currency], N'CONSTRAINT', [PK_Currency_CurrencyCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Sales], N'TABLE', [Currency], N'CONSTRAINT', [DF_Currency_ModifiedDate];