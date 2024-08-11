CREATE TABLE [Person].[Password](
	[BusinessEntityID] [int] NOT NULL,
    [PasswordHash] [varchar](128) NOT NULL, 
    [PasswordSalt] [varchar](10) NOT NULL,
    [rowguid] uniqueidentifier ROWGUIDCOL NOT NULL CONSTRAINT [DF_Password_rowguid] DEFAULT (NEWID()), 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Password_ModifiedDate] DEFAULT (GETDATE())

) ON [PRIMARY];
GO
ALTER TABLE [Person].[Password] ADD 
    CONSTRAINT [FK_Password_Person_BusinessEntityID] FOREIGN KEY 
    (
        [BusinessEntityID]
    ) REFERENCES [Person].[Person](
        [BusinessEntityID]
    );
GO
ALTER TABLE [Person].[Password] WITH CHECK ADD 
    CONSTRAINT [PK_Password_BusinessEntityID] PRIMARY KEY CLUSTERED 
    (
        [BusinessEntityID]
    )  ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'One way hashed authentication information', N'SCHEMA', [Person], N'TABLE', [Password], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Password for the e-mail account.', N'SCHEMA', [Person], N'TABLE', [Password], N'COLUMN', [PasswordHash];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Random value concatenated with the password string before the password is hashed.', N'SCHEMA', [Person], N'TABLE', [Password], N'COLUMN', [PasswordSalt];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', N'SCHEMA', [Person], N'TABLE', [Password], N'COLUMN', [rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Person], N'TABLE', [Password], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Person], N'TABLE', [Password], N'CONSTRAINT', [PK_Password_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Person.BusinessEntityID.', N'SCHEMA', [Person], N'TABLE', [Password], N'CONSTRAINT', [FK_Password_Person_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Person], N'TABLE', [Password], N'CONSTRAINT', [DF_Password_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of NEWID()', N'SCHEMA', [Person], N'TABLE', [Password], N'CONSTRAINT', [DF_Password_rowguid];