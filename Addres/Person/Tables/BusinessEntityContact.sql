CREATE TABLE [Person].[BusinessEntityContact](
	[BusinessEntityID] [int] NOT NULL,
    [PersonID] [int] NOT NULL,
    [ContactTypeID] [int] NOT NULL,
    [rowguid] uniqueidentifier ROWGUIDCOL NOT NULL CONSTRAINT [DF_BusinessEntityContact_rowguid] DEFAULT (NEWID()), 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_BusinessEntityContact_ModifiedDate] DEFAULT (GETDATE()) 
) ON [PRIMARY];
GO
ALTER TABLE [Person].[BusinessEntityContact] ADD
    CONSTRAINT [FK_BusinessEntityContact_Person_PersonID] FOREIGN KEY 
    (
        [PersonID]
    ) REFERENCES [Person].[Person](
        [BusinessEntityID]
    ),
    CONSTRAINT [FK_BusinessEntityContact_ContactType_ContactTypeID] FOREIGN KEY 
    (
        [ContactTypeID]
    ) REFERENCES [Person].[ContactType](
        [ContactTypeID]
    ),
    CONSTRAINT [FK_BusinessEntityContact_BusinessEntity_BusinessEntityID] FOREIGN KEY 
    (
        [BusinessEntityID]
    ) REFERENCES [Person].[BusinessEntity](
        [BusinessEntityID]
    );
GO
ALTER TABLE [Person].[BusinessEntityContact] WITH CHECK ADD 
    CONSTRAINT [PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeID] PRIMARY KEY CLUSTERED 
    (
        [BusinessEntityID],
		[PersonID],
		[ContactTypeID]
    )  ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_BusinessEntityContact_rowguid] ON [Person].[BusinessEntityContact]([rowguid]) ON [PRIMARY];
GO
CREATE INDEX [IX_BusinessEntityContact_PersonID] ON [Person].[BusinessEntityContact]([PersonID]) ON [PRIMARY];
GO
CREATE INDEX [IX_BusinessEntityContact_ContactTypeID] ON [Person].[BusinessEntityContact]([ContactTypeID]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Cross-reference table mapping stores, vendors, and employees to people', N'SCHEMA', [Person], N'TABLE', [BusinessEntityContact], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key. Foreign key to BusinessEntity.BusinessEntityID.', N'SCHEMA', [Person], N'TABLE', [BusinessEntityContact], N'COLUMN', [BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key. Foreign key to Person.BusinessEntityID.', N'SCHEMA', [Person], N'TABLE', [BusinessEntityContact], N'COLUMN', [PersonID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key.  Foreign key to ContactType.ContactTypeID.', N'SCHEMA', [Person], N'TABLE', [BusinessEntityContact], N'COLUMN', [ContactTypeID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', N'SCHEMA', [Person], N'TABLE', [BusinessEntityContact], N'COLUMN', [rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Person], N'TABLE', [BusinessEntityContact], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', N'SCHEMA', [Person], N'TABLE', [BusinessEntityContact], N'INDEX', [AK_BusinessEntityContact_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index.', N'SCHEMA', [Person], N'TABLE', [BusinessEntityContact], N'INDEX', [IX_BusinessEntityContact_PersonID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index.', N'SCHEMA', [Person], N'TABLE', [BusinessEntityContact], N'INDEX', [IX_BusinessEntityContact_ContactTypeID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Person], N'TABLE', [BusinessEntityContact], N'CONSTRAINT', [PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Person.BusinessEntityID.', N'SCHEMA', [Person], N'TABLE', [BusinessEntityContact], N'CONSTRAINT', [FK_BusinessEntityContact_Person_PersonID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of NEWID()', N'SCHEMA', [Person], N'TABLE', [BusinessEntityContact], N'CONSTRAINT', [DF_BusinessEntityContact_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Person], N'TABLE', [BusinessEntityContact], N'CONSTRAINT', [DF_BusinessEntityContact_ModifiedDate];