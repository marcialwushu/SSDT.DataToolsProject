CREATE TABLE [HumanResources].[EmployeeDepartmentHistory](
    [BusinessEntityID] [int] NOT NULL,
    [DepartmentID] [smallint] NOT NULL,
    [ShiftID] [tinyint] NOT NULL,
    [StartDate] [date] NOT NULL,
    [EndDate] [date] NULL, 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_EmployeeDepartmentHistory_ModifiedDate] DEFAULT (GETDATE()), 
    CONSTRAINT [CK_EmployeeDepartmentHistory_EndDate] CHECK (([EndDate] >= [StartDate]) OR ([EndDate] IS NULL)),
) ON [PRIMARY];
GO
ALTER TABLE [HumanResources].[EmployeeDepartmentHistory] ADD 
    CONSTRAINT [FK_EmployeeDepartmentHistory_Department_DepartmentID] FOREIGN KEY 
    (
        [DepartmentID]
    ) REFERENCES [HumanResources].[Department](
        [DepartmentID]
    ),
    CONSTRAINT [FK_EmployeeDepartmentHistory_Employee_BusinessEntityID] FOREIGN KEY 
    (
        [BusinessEntityID]
    ) REFERENCES [HumanResources].[Employee](
        [BusinessEntityID]
    ),
    CONSTRAINT [FK_EmployeeDepartmentHistory_Shift_ShiftID] FOREIGN KEY 
    (
        [ShiftID]
    ) REFERENCES [HumanResources].[Shift](
        [ShiftID]
    );
GO
ALTER TABLE [HumanResources].[EmployeeDepartmentHistory] WITH CHECK ADD 
    CONSTRAINT [PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_DepartmentID] PRIMARY KEY CLUSTERED 
    (
        [BusinessEntityID],
        [StartDate],
        [DepartmentID],
        [ShiftID]
    )  ON [PRIMARY];
GO
CREATE INDEX [IX_EmployeeDepartmentHistory_DepartmentID] ON [HumanResources].[EmployeeDepartmentHistory]([DepartmentID]) ON [PRIMARY];
GO
CREATE INDEX [IX_EmployeeDepartmentHistory_ShiftID] ON [HumanResources].[EmployeeDepartmentHistory]([ShiftID]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Employee department transfers.', N'SCHEMA', [HumanResources], N'TABLE', [EmployeeDepartmentHistory], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Employee identification number. Foreign key to Employee.BusinessEntityID.', N'SCHEMA', [HumanResources], N'TABLE', [EmployeeDepartmentHistory], N'COLUMN', [BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Department in which the employee worked including currently. Foreign key to Department.DepartmentID.', N'SCHEMA', [HumanResources], N'TABLE', [EmployeeDepartmentHistory], N'COLUMN', [DepartmentID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Identifies which 8-hour shift the employee works. Foreign key to Shift.Shift.ID.', N'SCHEMA', [HumanResources], N'TABLE', [EmployeeDepartmentHistory], N'COLUMN', [ShiftID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date the employee started work in the department.', N'SCHEMA', [HumanResources], N'TABLE', [EmployeeDepartmentHistory], N'COLUMN', [StartDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date the employee left the department. NULL = Current department.', N'SCHEMA', [HumanResources], N'TABLE', [EmployeeDepartmentHistory], N'COLUMN', [EndDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [HumanResources], N'TABLE', [EmployeeDepartmentHistory], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index.', N'SCHEMA', [HumanResources], N'TABLE', [EmployeeDepartmentHistory], N'INDEX', [IX_EmployeeDepartmentHistory_DepartmentID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index.', N'SCHEMA', [HumanResources], N'TABLE', [EmployeeDepartmentHistory], N'INDEX', [IX_EmployeeDepartmentHistory_ShiftID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [HumanResources], N'TABLE', [EmployeeDepartmentHistory], N'CONSTRAINT', [PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_DepartmentID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Department.DepartmentID.', N'SCHEMA', [HumanResources], N'TABLE', [EmployeeDepartmentHistory], N'CONSTRAINT', [FK_EmployeeDepartmentHistory_Department_DepartmentID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [HumanResources], N'TABLE', [EmployeeDepartmentHistory], N'CONSTRAINT', [DF_EmployeeDepartmentHistory_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [EndDate] >= [StartDate] OR [EndDate] IS NUL', N'SCHEMA', [HumanResources], N'TABLE', [EmployeeDepartmentHistory], N'CONSTRAINT', [CK_EmployeeDepartmentHistory_EndDate];