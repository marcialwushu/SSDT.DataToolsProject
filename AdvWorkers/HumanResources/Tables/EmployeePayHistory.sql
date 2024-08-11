CREATE TABLE [HumanResources].[EmployeePayHistory](
    [BusinessEntityID] [int] NOT NULL,
    [RateChangeDate] [datetime] NOT NULL,
    [Rate] [money] NOT NULL,
    [PayFrequency] [tinyint] NOT NULL, 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_EmployeePayHistory_ModifiedDate] DEFAULT (GETDATE()),
    CONSTRAINT [CK_EmployeePayHistory_PayFrequency] CHECK ([PayFrequency] IN (1, 2)), -- 1 = monthly salary, 2 = biweekly salary
    CONSTRAINT [CK_EmployeePayHistory_Rate] CHECK ([Rate] BETWEEN 6.50 AND 200.00) 
) ON [PRIMARY];
GO
ALTER TABLE [HumanResources].[EmployeePayHistory] ADD 
    CONSTRAINT [FK_EmployeePayHistory_Employee_BusinessEntityID] FOREIGN KEY 
    (
        [BusinessEntityID]
    ) REFERENCES [HumanResources].[Employee](
        [BusinessEntityID]
    );
GO
ALTER TABLE [HumanResources].[EmployeePayHistory] WITH CHECK ADD 
    CONSTRAINT [PK_EmployeePayHistory_BusinessEntityID_RateChangeDate] PRIMARY KEY CLUSTERED 
    (
        [BusinessEntityID],
        [RateChangeDate]
    )  ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Employee pay history.', N'SCHEMA', [HumanResources], N'TABLE', [EmployeePayHistory], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Employee identification number. Foreign key to Employee.BusinessEntityID.', N'SCHEMA', [HumanResources], N'TABLE', [EmployeePayHistory], N'COLUMN', [BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date the change in pay is effective', N'SCHEMA', [HumanResources], N'TABLE', [EmployeePayHistory], N'COLUMN', [RateChangeDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Salary hourly rate.', N'SCHEMA', [HumanResources], N'TABLE', [EmployeePayHistory], N'COLUMN', [Rate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'1 = Salary received monthly, 2 = Salary received biweekly', N'SCHEMA', [HumanResources], N'TABLE', [EmployeePayHistory], N'COLUMN', [PayFrequency];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [HumanResources], N'TABLE', [EmployeePayHistory], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [HumanResources], N'TABLE', [EmployeePayHistory], N'CONSTRAINT', [PK_EmployeePayHistory_BusinessEntityID_RateChangeDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Employee.EmployeeID.', N'SCHEMA', [HumanResources], N'TABLE', [EmployeePayHistory], N'CONSTRAINT', [FK_EmployeePayHistory_Employee_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [HumanResources], N'TABLE', [EmployeePayHistory], N'CONSTRAINT', [DF_EmployeePayHistory_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [Rate] >= (6.50) AND [Rate] <= (200.00)', N'SCHEMA', [HumanResources], N'TABLE', [EmployeePayHistory], N'CONSTRAINT', [CK_EmployeePayHistory_Rate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [PayFrequency]=(3) OR [PayFrequency]=(2) OR [PayFrequency]=(1)', N'SCHEMA', [HumanResources], N'TABLE', [EmployeePayHistory], N'CONSTRAINT', [CK_EmployeePayHistory_PayFrequency];