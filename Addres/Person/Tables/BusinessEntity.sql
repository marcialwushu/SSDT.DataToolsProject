CREATE TABLE [Person].[BusinessEntity](
	[BusinessEntityID] [int] IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [rowguid] uniqueidentifier ROWGUIDCOL NOT NULL CONSTRAINT [DF_BusinessEntity_rowguid] DEFAULT (NEWID()), 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_BusinessEntity_ModifiedDate] DEFAULT (GETDATE())	
) ON [PRIMARY];
GO
ALTER TABLE [Person].[BusinessEntity] WITH CHECK ADD 
    CONSTRAINT [PK_BusinessEntity_BusinessEntityID] PRIMARY KEY CLUSTERED 
    (
        [BusinessEntityID]
    )  ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_BusinessEntity_rowguid] ON [Person].[BusinessEntity]([rowguid]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Source of the ID that connects vendors, customers, and employees with address and contact information.', N'SCHEMA', [Person], N'TABLE', [BusinessEntity], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key for all customers, vendors, and employees.', N'SCHEMA', [Person], N'TABLE', [BusinessEntity], N'COLUMN', [BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', N'SCHEMA', [Person], N'TABLE', [BusinessEntity], N'COLUMN', [rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Person], N'TABLE', [BusinessEntity], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', N'SCHEMA', [Person], N'TABLE', [BusinessEntity], N'INDEX', [AK_BusinessEntity_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Person], N'TABLE', [BusinessEntity], N'CONSTRAINT', [PK_BusinessEntity_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of NEWID()', N'SCHEMA', [Person], N'TABLE', [BusinessEntity], N'CONSTRAINT', [DF_BusinessEntity_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Person], N'TABLE', [BusinessEntity], N'CONSTRAINT', [DF_BusinessEntity_ModifiedDate];