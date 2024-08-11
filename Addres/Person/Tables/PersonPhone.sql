CREATE TABLE [Person].[PersonPhone](
    [BusinessEntityID] [int] NOT NULL,
	[PhoneNumber] [Phone] NOT NULL,
	[PhoneNumberTypeID] [int] NOT NULL,
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_PersonPhone_ModifiedDate] DEFAULT (GETDATE()) 
) ON [PRIMARY];
GO
ALTER TABLE [Person].[PersonPhone] ADD 
    CONSTRAINT [FK_PersonPhone_Person_BusinessEntityID] FOREIGN KEY 
    (
        [BusinessEntityID]
    ) REFERENCES [Person].[Person](
        [BusinessEntityID]
    ),
 CONSTRAINT [FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID] FOREIGN KEY 
    (
        [PhoneNumberTypeID]
    ) REFERENCES [Person].[PhoneNumberType](
        [PhoneNumberTypeID]
    );
GO
ALTER TABLE [Person].[PersonPhone] WITH CHECK ADD 
    CONSTRAINT [PK_PersonPhone_BusinessEntityID_PhoneNumber_PhoneNumberTypeID] PRIMARY KEY CLUSTERED 
    (
        [BusinessEntityID],
        [PhoneNumber],
        [PhoneNumberTypeID]
    )  ON [PRIMARY];
GO
CREATE INDEX [IX_PersonPhone_PhoneNumber] on [Person].[PersonPhone] ([PhoneNumber]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Telephone number and type of a person.', N'SCHEMA', [Person], N'TABLE', [PersonPhone], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Business entity identification number. Foreign key to Person.BusinessEntityID.', N'SCHEMA', [Person], N'TABLE', [PersonPhone], N'COLUMN', [BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Telephone number identification number.', N'SCHEMA', [Person], N'TABLE', [PersonPhone], N'COLUMN', [PhoneNumber];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Kind of phone number. Foreign key to PhoneNumberType.PhoneNumberTypeID.', N'SCHEMA', [Person], N'TABLE', [PersonPhone], N'COLUMN', [PhoneNumberTypeID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Person], N'TABLE', [PersonPhone], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index.', N'SCHEMA', [Person], N'TABLE', [PersonPhone], N'INDEX', [IX_PersonPhone_PhoneNumber];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Person], N'TABLE', [PersonPhone], N'CONSTRAINT', [PK_PersonPhone_BusinessEntityID_PhoneNumber_PhoneNumberTypeID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Person.BusinessEntityID.', N'SCHEMA', [Person], N'TABLE', [PersonPhone], N'CONSTRAINT', [FK_PersonPhone_Person_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Person], N'TABLE', [PersonPhone], N'CONSTRAINT', [DF_PersonPhone_ModifiedDate];