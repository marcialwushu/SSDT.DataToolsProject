CREATE TABLE [HumanResources].[Department](
    [DepartmentID] [smallint] IDENTITY (1, 1) NOT NULL,
    [Name] [Name] NOT NULL,
    [GroupName] [Name] NOT NULL, 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Department_ModifiedDate] DEFAULT (GETDATE()) 
) ON [PRIMARY];
GO
ALTER TABLE [HumanResources].[Department] WITH CHECK ADD 
    CONSTRAINT [PK_Department_DepartmentID] PRIMARY KEY CLUSTERED 
    (
        [DepartmentID]
    )  ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_Department_Name] ON [HumanResources].[Department]([Name]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Lookup table containing the departments within the Adventure Works Cycles company.', N'SCHEMA', [HumanResources], N'TABLE', [Department], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key for Department records.', N'SCHEMA', [HumanResources], N'TABLE', [Department], N'COLUMN', [DepartmentID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Name of the department.', N'SCHEMA', [HumanResources], N'TABLE', [Department], N'COLUMN', [Name];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Name of the group to which the department belongs.', N'SCHEMA', [HumanResources], N'TABLE', [Department], N'COLUMN', [GroupName];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [HumanResources], N'TABLE', [Department], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index.', N'SCHEMA', [HumanResources], N'TABLE', [Department], N'INDEX', [AK_Department_Name];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [HumanResources], N'TABLE', [Department], N'CONSTRAINT', [PK_Department_DepartmentID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [HumanResources], N'TABLE', [Department], N'CONSTRAINT', [DF_Department_ModifiedDate];