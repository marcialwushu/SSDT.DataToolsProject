CREATE TABLE [Person].[BusinessEntityAddress](
	[BusinessEntityID] [int] NOT NULL,
    [AddressID] [int] NOT NULL,
    [AddressTypeID] [int] NOT NULL,
    [rowguid] uniqueidentifier ROWGUIDCOL NOT NULL CONSTRAINT [DF_BusinessEntityAddress_rowguid] DEFAULT (NEWID()),
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_BusinessEntityAddress_ModifiedDate] DEFAULT (GETDATE()) 
) ON [PRIMARY];
GO
ALTER TABLE [Person].[BusinessEntityAddress] ADD 
    CONSTRAINT [FK_BusinessEntityAddress_Address_AddressID] FOREIGN KEY 
    (
        [AddressID]
    ) REFERENCES [Person].[Address](
        [AddressID]
    ),
    CONSTRAINT [FK_BusinessEntityAddress_AddressType_AddressTypeID] FOREIGN KEY 
    (
        [AddressTypeID]
    ) REFERENCES [Person].[AddressType](
        [AddressTypeID]
    ),
    CONSTRAINT [FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID] FOREIGN KEY 
    (
        [BusinessEntityID]
    ) REFERENCES [Person].[BusinessEntity](
        [BusinessEntityID]
    );
GO
ALTER TABLE [Person].[BusinessEntityAddress] WITH CHECK ADD 
    CONSTRAINT [PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressTypeID] PRIMARY KEY CLUSTERED 
    (
        [BusinessEntityID],
		[AddressID],
		[AddressTypeID]
    )  ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_BusinessEntityAddress_rowguid] ON [Person].[BusinessEntityAddress]([rowguid]) ON [PRIMARY];
GO
CREATE INDEX [IX_BusinessEntityAddress_AddressID] ON [Person].[BusinessEntityAddress]([AddressID]) ON [PRIMARY];
GO
CREATE INDEX [IX_BusinessEntityAddress_AddressTypeID] ON [Person].[BusinessEntityAddress]([AddressTypeID]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Cross-reference table mapping customers, vendors, and employees to their addresses.', N'SCHEMA', [Person], N'TABLE', [BusinessEntityAddress], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key. Foreign key to BusinessEntity.BusinessEntityID.', N'SCHEMA', [Person], N'TABLE', [BusinessEntityAddress], N'COLUMN', [BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key. Foreign key to Address.AddressID.', N'SCHEMA', [Person], N'TABLE', [BusinessEntityAddress], N'COLUMN', [AddressID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key. Foreign key to AddressType.AddressTypeID.', N'SCHEMA', [Person], N'TABLE', [BusinessEntityAddress], N'COLUMN', [AddressTypeID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', N'SCHEMA', [Person], N'TABLE', [BusinessEntityAddress], N'COLUMN', [rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Person], N'TABLE', [BusinessEntityAddress], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', N'SCHEMA', [Person], N'TABLE', [BusinessEntityAddress], N'INDEX', [AK_BusinessEntityAddress_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index.', N'SCHEMA', [Person], N'TABLE', [BusinessEntityAddress], N'INDEX', [IX_BusinessEntityAddress_AddressID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index.', N'SCHEMA', [Person], N'TABLE', [BusinessEntityAddress], N'INDEX', [IX_BusinessEntityAddress_AddressTypeID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Person], N'TABLE', [BusinessEntityAddress], N'CONSTRAINT', [PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressTypeID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Address.AddressID.', N'SCHEMA', [Person], N'TABLE', [BusinessEntityAddress], N'CONSTRAINT', [FK_BusinessEntityAddress_Address_AddressID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of NEWID()', N'SCHEMA', [Person], N'TABLE', [BusinessEntityAddress], N'CONSTRAINT', [DF_BusinessEntityAddress_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Person], N'TABLE', [BusinessEntityAddress], N'CONSTRAINT', [DF_BusinessEntityAddress_ModifiedDate];