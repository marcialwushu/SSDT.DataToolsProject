CREATE TABLE [dbo].[AWBuildVersion](
    [SystemInformationID] [tinyint] IDENTITY (1, 1) NOT NULL,
    [Database Version] [nvarchar](25) NOT NULL, 
    [VersionDate] [datetime] NOT NULL, 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_AWBuildVersion_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO
ALTER TABLE [dbo].[AWBuildVersion] WITH CHECK ADD 
    CONSTRAINT [PK_AWBuildVersion_SystemInformationID] PRIMARY KEY CLUSTERED 
    (
        [SystemInformationID]
    )  ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Current version number of the AdventureWorks 2016 sample database. ', N'SCHEMA', [dbo], N'TABLE', [AWBuildVersion], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key for AWBuildVersion records.', N'SCHEMA', [dbo], N'TABLE', [AWBuildVersion], N'COLUMN', [SystemInformationID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Version number of the database in 9.yy.mm.dd.00 format.', N'SCHEMA', [dbo], N'TABLE', [AWBuildVersion], N'COLUMN', [Database Version];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [dbo], N'TABLE', [AWBuildVersion], N'COLUMN', [VersionDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [dbo], N'TABLE', [AWBuildVersion], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [dbo], N'TABLE', [AWBuildVersion], N'CONSTRAINT', [PK_AWBuildVersion_SystemInformationID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [dbo], N'TABLE', [AWBuildVersion], N'CONSTRAINT', [DF_AWBuildVersion_ModifiedDate];