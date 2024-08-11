CREATE TABLE [Sales].[CreditCard](
    [CreditCardID] [int] IDENTITY (1, 1) NOT NULL,
    [CardType] [nvarchar](50) NOT NULL,
    [CardNumber] [nvarchar](25) NOT NULL,
    [ExpMonth] [tinyint] NOT NULL,
    [ExpYear] [smallint] NOT NULL, 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_CreditCard_ModifiedDate] DEFAULT (GETDATE()) 
) ON [PRIMARY];
GO
ALTER TABLE [Sales].[CreditCard] WITH CHECK ADD 
    CONSTRAINT [PK_CreditCard_CreditCardID] PRIMARY KEY CLUSTERED 
    (
        [CreditCardID]
    )  ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_CreditCard_CardNumber] ON [Sales].[CreditCard]([CardNumber]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Customer credit card information.', N'SCHEMA', [Sales], N'TABLE', [CreditCard], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key for CreditCard records.', N'SCHEMA', [Sales], N'TABLE', [CreditCard], N'COLUMN', [CreditCardID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Credit card name.', N'SCHEMA', [Sales], N'TABLE', [CreditCard], N'COLUMN', [CardType];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Credit card number.', N'SCHEMA', [Sales], N'TABLE', [CreditCard], N'COLUMN', [CardNumber];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Credit card expiration month.', N'SCHEMA', [Sales], N'TABLE', [CreditCard], N'COLUMN', [ExpMonth];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Credit card expiration year.', N'SCHEMA', [Sales], N'TABLE', [CreditCard], N'COLUMN', [ExpYear];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Sales], N'TABLE', [CreditCard], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index.', N'SCHEMA', [Sales], N'TABLE', [CreditCard], N'INDEX', [AK_CreditCard_CardNumber];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Sales], N'TABLE', [CreditCard], N'CONSTRAINT', [PK_CreditCard_CreditCardID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Sales], N'TABLE', [CreditCard], N'CONSTRAINT', [DF_CreditCard_ModifiedDate];