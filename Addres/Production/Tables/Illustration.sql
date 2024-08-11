CREATE TABLE [Production].[Illustration](
    [IllustrationID] [int] IDENTITY (1, 1) NOT NULL,
    [Diagram] [XML] NULL, 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Illustration_ModifiedDate] DEFAULT (GETDATE()) 
) ON [PRIMARY];
GO
ALTER TABLE [Production].[Illustration] WITH CHECK ADD 
    CONSTRAINT [PK_Illustration_IllustrationID] PRIMARY KEY CLUSTERED 
    (
        [IllustrationID]
    )  ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Bicycle assembly diagrams.', N'SCHEMA', [Production], N'TABLE', [Illustration], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key for Illustration records.', N'SCHEMA', [Production], N'TABLE', [Illustration], N'COLUMN', [IllustrationID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Illustrations used in manufacturing instructions. Stored as XML.', N'SCHEMA', [Production], N'TABLE', [Illustration], N'COLUMN', [Diagram];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Production], N'TABLE', [Illustration], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Production], N'TABLE', [Illustration], N'CONSTRAINT', [PK_Illustration_IllustrationID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Production], N'TABLE', [Illustration], N'CONSTRAINT', [DF_Illustration_ModifiedDate];