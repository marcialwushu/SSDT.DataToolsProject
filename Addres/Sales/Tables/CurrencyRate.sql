CREATE TABLE [Sales].[CurrencyRate](
    [CurrencyRateID] [int] IDENTITY (1, 1) NOT NULL,
    [CurrencyRateDate] [datetime] NOT NULL,    
    [FromCurrencyCode] [nchar](3) NOT NULL, 
    [ToCurrencyCode] [nchar](3) NOT NULL, 
    [AverageRate] [money] NOT NULL,
    [EndOfDayRate] [money] NOT NULL, 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_CurrencyRate_ModifiedDate] DEFAULT (GETDATE()) 
) ON [PRIMARY];
GO
ALTER TABLE [Sales].[CurrencyRate] ADD 
    CONSTRAINT [FK_CurrencyRate_Currency_FromCurrencyCode] FOREIGN KEY 
    (
        [FromCurrencyCode]
    ) REFERENCES [Sales].[Currency](
        [CurrencyCode]
    ),
    CONSTRAINT [FK_CurrencyRate_Currency_ToCurrencyCode] FOREIGN KEY 
    (
        [ToCurrencyCode]
    ) REFERENCES [Sales].[Currency](
        [CurrencyCode]
    );
GO
ALTER TABLE [Sales].[CurrencyRate] WITH CHECK ADD 
    CONSTRAINT [PK_CurrencyRate_CurrencyRateID] PRIMARY KEY CLUSTERED 
    (
        [CurrencyRateID]
    )  ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_CurrencyRate_CurrencyRateDate_FromCurrencyCode_ToCurrencyCode] ON [Sales].[CurrencyRate]([CurrencyRateDate], [FromCurrencyCode], [ToCurrencyCode]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Currency exchange rates.', N'SCHEMA', [Sales], N'TABLE', [CurrencyRate], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key for CurrencyRate records.', N'SCHEMA', [Sales], N'TABLE', [CurrencyRate], N'COLUMN', [CurrencyRateID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the exchange rate was obtained.', N'SCHEMA', [Sales], N'TABLE', [CurrencyRate], N'COLUMN', [CurrencyRateDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Exchange rate was converted from this currency code.', N'SCHEMA', [Sales], N'TABLE', [CurrencyRate], N'COLUMN', [FromCurrencyCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Exchange rate was converted to this currency code.', N'SCHEMA', [Sales], N'TABLE', [CurrencyRate], N'COLUMN', [ToCurrencyCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Average exchange rate for the day.', N'SCHEMA', [Sales], N'TABLE', [CurrencyRate], N'COLUMN', [AverageRate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Final exchange rate for the day.', N'SCHEMA', [Sales], N'TABLE', [CurrencyRate], N'COLUMN', [EndOfDayRate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Sales], N'TABLE', [CurrencyRate], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index.', N'SCHEMA', [Sales], N'TABLE', [CurrencyRate], N'INDEX', [AK_CurrencyRate_CurrencyRateDate_FromCurrencyCode_ToCurrencyCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Sales], N'TABLE', [CurrencyRate], N'CONSTRAINT', [PK_CurrencyRate_CurrencyRateID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Currency.FromCurrencyCode.', N'SCHEMA', [Sales], N'TABLE', [CurrencyRate], N'CONSTRAINT', [FK_CurrencyRate_Currency_FromCurrencyCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Sales], N'TABLE', [CurrencyRate], N'CONSTRAINT', [DF_CurrencyRate_ModifiedDate];