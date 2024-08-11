CREATE TABLE [Person].[AddressType](
    [AddressTypeID] [int] IDENTITY (1, 1) NOT NULL,
    [Name] [Name] NOT NULL,
    [rowguid] uniqueidentifier ROWGUIDCOL NOT NULL CONSTRAINT [DF_AddressType_rowguid] DEFAULT (NEWID()),
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_AddressType_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO
ALTER TABLE [Person].[AddressType] WITH CHECK ADD 
    CONSTRAINT [PK_AddressType_AddressTypeID] PRIMARY KEY CLUSTERED 
    (
        [AddressTypeID]
    )  ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_AddressType_rowguid] ON [Person].[AddressType]([rowguid]) ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_AddressType_Name] ON [Person].[AddressType]([Name]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Types of addresses stored in the Address table. ', N'SCHEMA', [Person], N'TABLE', [AddressType], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key for AddressType records.', N'SCHEMA', [Person], N'TABLE', [AddressType], N'COLUMN', [AddressTypeID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Address type description. For example, Billing, Home, or Shipping.', N'SCHEMA', [Person], N'TABLE', [AddressType], N'COLUMN', [Name];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', N'SCHEMA', [Person], N'TABLE', [AddressType], N'COLUMN', [rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Person], N'TABLE', [AddressType], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index.', N'SCHEMA', [Person], N'TABLE', [AddressType], N'INDEX', [AK_AddressType_Name];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', N'SCHEMA', [Person], N'TABLE', [AddressType], N'INDEX', [AK_AddressType_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Person], N'TABLE', [AddressType], N'CONSTRAINT', [PK_AddressType_AddressTypeID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Person], N'TABLE', [AddressType], N'CONSTRAINT', [DF_AddressType_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of NEWID()', N'SCHEMA', [Person], N'TABLE', [AddressType], N'CONSTRAINT', [DF_AddressType_rowguid];