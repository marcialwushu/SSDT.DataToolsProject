CREATE TABLE [Sales].[PersonCreditCard](
    [BusinessEntityID] [int] NOT NULL,
    [CreditCardID] [int] NOT NULL, 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_PersonCreditCard_ModifiedDate] DEFAULT (GETDATE()) 
) ON [PRIMARY];
GO
ALTER TABLE [Sales].[PersonCreditCard] ADD 
    CONSTRAINT [FK_PersonCreditCard_Person_BusinessEntityID] FOREIGN KEY 
    (
        [BusinessEntityID]
    ) REFERENCES [Person].[Person](
        [BusinessEntityID]
    ),
    CONSTRAINT [FK_PersonCreditCard_CreditCard_CreditCardID] FOREIGN KEY 
    (
        [CreditCardID]
    ) REFERENCES [Sales].[CreditCard](
        [CreditCardID]
    );
GO
ALTER TABLE [Sales].[PersonCreditCard] WITH CHECK ADD 
    CONSTRAINT [PK_PersonCreditCard_BusinessEntityID_CreditCardID] PRIMARY KEY CLUSTERED 
    (
        [BusinessEntityID],
        [CreditCardID]
    )  ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Cross-reference table mapping people to their credit card information in the CreditCard table. ', N'SCHEMA', [Sales], N'TABLE', [PersonCreditCard], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Business entity identification number. Foreign key to Person.BusinessEntityID.', N'SCHEMA', [Sales], N'TABLE', [PersonCreditCard], N'COLUMN', [BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Credit card identification number. Foreign key to CreditCard.CreditCardID.', N'SCHEMA', [Sales], N'TABLE', [PersonCreditCard], N'COLUMN', [CreditCardID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Sales], N'TABLE', [PersonCreditCard], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Sales], N'TABLE', [PersonCreditCard], N'CONSTRAINT', [PK_PersonCreditCard_BusinessEntityID_CreditCardID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Person.BusinessEntityID.', N'SCHEMA', [Sales], N'TABLE', [PersonCreditCard], N'CONSTRAINT', [FK_PersonCreditCard_Person_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Sales], N'TABLE', [PersonCreditCard], N'CONSTRAINT', [DF_PersonCreditCard_ModifiedDate];