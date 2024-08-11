CREATE TABLE [Production].[Document](
    [DocumentNode] [hierarchyid] NOT NULL,
	[DocumentLevel] AS DocumentNode.GetLevel(),
    [Title] [nvarchar](50) NOT NULL, 
	[Owner] [int] NOT NULL,
	[FolderFlag] [bit] NOT NULL CONSTRAINT [DF_Document_FolderFlag] DEFAULT (0),
    [FileName] [nvarchar](400) NOT NULL, 
    [FileExtension] nvarchar(8) NOT NULL,
    [Revision] [nchar](5) NOT NULL, 
    [ChangeNumber] [int] NOT NULL CONSTRAINT [DF_Document_ChangeNumber] DEFAULT (0),
    [Status] [tinyint] NOT NULL,
    [DocumentSummary] [nvarchar](max) NULL,
    [Document] [varbinary](max)  NULL,  
    [rowguid] uniqueidentifier ROWGUIDCOL NOT NULL UNIQUE CONSTRAINT [DF_Document_rowguid] DEFAULT (NEWID()), 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Document_ModifiedDate] DEFAULT (GETDATE()),
    CONSTRAINT [CK_Document_Status] CHECK ([Status] BETWEEN 1 AND 3)
) ON [PRIMARY];
GO
ALTER TABLE [Production].[Document] ADD
	CONSTRAINT [FK_Document_Employee_Owner] FOREIGN KEY
	(
		[Owner]
	) REFERENCES [HumanResources].[Employee](
		[BusinessEntityID]
	);
GO
ALTER TABLE [Production].[Document] WITH CHECK ADD 
    CONSTRAINT [PK_Document_DocumentNode] PRIMARY KEY CLUSTERED 
    (
        [DocumentNode]
    )  ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_Document_DocumentLevel_DocumentNode] ON [Production].[Document] ([DocumentLevel], [DocumentNode]);
GO
CREATE UNIQUE INDEX [AK_Document_rowguid] ON [Production].[Document]([rowguid]) ON [PRIMARY];
GO
CREATE INDEX [IX_Document_FileName_Revision] ON [Production].[Document]([FileName], [Revision]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Product maintenance documents.', N'SCHEMA', [Production], N'TABLE', [Document], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key for Document records.', N'SCHEMA', [Production], N'TABLE', [Document], N'COLUMN', [DocumentNode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Depth in the document hierarchy.', N'SCHEMA', [Production], N'TABLE', [Document], N'COLUMN', [DocumentLevel];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Title of the document.', N'SCHEMA', [Production], N'TABLE', [Document], N'COLUMN', [Title];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Employee who controls the document.  Foreign key to Employee.BusinessEntityID', N'SCHEMA', [Production], N'TABLE', [Document], N'COLUMN', [Owner];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'0 = This is a folder, 1 = This is a document.', N'SCHEMA', [Production], N'TABLE', [Document], N'COLUMN', [FolderFlag];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'File name of the document', N'SCHEMA', [Production], N'TABLE', [Document], N'COLUMN', [FileName];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'File extension indicating the document type. For example, .doc or .txt.', N'SCHEMA', [Production], N'TABLE', [Document], N'COLUMN', [FileExtension];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Revision number of the document. ', N'SCHEMA', [Production], N'TABLE', [Document], N'COLUMN', [Revision];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Engineering change approval number.', N'SCHEMA', [Production], N'TABLE', [Document], N'COLUMN', [ChangeNumber];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'1 = Pending approval, 2 = Approved, 3 = Obsolete', N'SCHEMA', [Production], N'TABLE', [Document], N'COLUMN', [Status];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Document abstract.', N'SCHEMA', [Production], N'TABLE', [Document], N'COLUMN', [DocumentSummary];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Complete document.', N'SCHEMA', [Production], N'TABLE', [Document], N'COLUMN', [Document];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Required for FileStream.', N'SCHEMA', [Production], N'TABLE', [Document], N'COLUMN', [rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Production], N'TABLE', [Document], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index.', N'SCHEMA', [Production], N'TABLE', [Document], N'INDEX', [AK_Document_DocumentLevel_DocumentNode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index.', N'SCHEMA', [Production], N'TABLE', [Document], N'INDEX', [IX_Document_FileName_Revision];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index. Used to support FileStream.', N'SCHEMA', [Production], N'TABLE', [Document], N'INDEX', [AK_Document_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Production], N'TABLE', [Document], N'CONSTRAINT', [PK_Document_DocumentNode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Employee.BusinessEntityID.', N'SCHEMA', [Production], N'TABLE', [Document], N'CONSTRAINT', [FK_Document_Employee_Owner];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0', N'SCHEMA', [Production], N'TABLE', [Document], N'CONSTRAINT', [DF_Document_ChangeNumber];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Production], N'TABLE', [Document], N'CONSTRAINT', [DF_Document_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [Status] BETWEEN (1) AND (3)', N'SCHEMA', [Production], N'TABLE', [Document], N'CONSTRAINT', [CK_Document_Status];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of NEWID()', N'SCHEMA', [Production], N'TABLE', [Document], N'CONSTRAINT', [DF_Document_rowguid];