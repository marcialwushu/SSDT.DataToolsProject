CREATE TABLE [HumanResources].[Employee](
    [BusinessEntityID] [int] NOT NULL,
    [NationalIDNumber] [nvarchar](15) NOT NULL, 
    [LoginID] [nvarchar](256) NOT NULL,     
    [OrganizationNode] [hierarchyid] NULL,
	[OrganizationLevel] AS OrganizationNode.GetLevel(),
    [JobTitle] [nvarchar](50) NOT NULL, 
    [BirthDate] [date] NOT NULL,
    [MaritalStatus] [nchar](1) NOT NULL, 
    [Gender] [nchar](1) NOT NULL, 
    [HireDate] [date] NOT NULL,
    [SalariedFlag] [Flag] NOT NULL CONSTRAINT [DF_Employee_SalariedFlag] DEFAULT (1),
    [VacationHours] [smallint] NOT NULL CONSTRAINT [DF_Employee_VacationHours] DEFAULT (0),
    [SickLeaveHours] [smallint] NOT NULL CONSTRAINT [DF_Employee_SickLeaveHours] DEFAULT (0),
    [CurrentFlag] [Flag] NOT NULL CONSTRAINT [DF_Employee_CurrentFlag] DEFAULT (1),
    [rowguid] uniqueidentifier ROWGUIDCOL NOT NULL CONSTRAINT [DF_Employee_rowguid] DEFAULT (NEWID()), 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Employee_ModifiedDate] DEFAULT (GETDATE()),
    CONSTRAINT [CK_Employee_BirthDate] CHECK ([BirthDate] BETWEEN '1930-01-01' AND DATEADD(YEAR, -18, GETDATE())),
    CONSTRAINT [CK_Employee_MaritalStatus] CHECK (UPPER([MaritalStatus]) IN ('M', 'S')), -- Married or Single
    CONSTRAINT [CK_Employee_HireDate] CHECK ([HireDate] BETWEEN '1996-07-01' AND DATEADD(DAY, 1, GETDATE())),
    CONSTRAINT [CK_Employee_Gender] CHECK (UPPER([Gender]) IN ('M', 'F')), -- Male or Female
    CONSTRAINT [CK_Employee_VacationHours] CHECK ([VacationHours] BETWEEN -40 AND 240), 
    CONSTRAINT [CK_Employee_SickLeaveHours] CHECK ([SickLeaveHours] BETWEEN 0 AND 120) 
) ON [PRIMARY];
GO
ALTER TABLE [HumanResources].[Employee] ADD 
    CONSTRAINT [FK_Employee_Person_BusinessEntityID] FOREIGN KEY 
    (
        [BusinessEntityID]
    ) REFERENCES [Person].[Person](
        [BusinessEntityID]
    );
GO
ALTER TABLE [HumanResources].[Employee] WITH CHECK ADD 
    CONSTRAINT [PK_Employee_BusinessEntityID] PRIMARY KEY CLUSTERED 
    (
        [BusinessEntityID]
    )  ON [PRIMARY];
GO
CREATE INDEX [IX_Employee_OrganizationNode] ON [HumanResources].[Employee] ([OrganizationNode]);
GO
CREATE INDEX [IX_Employee_OrganizationLevel_OrganizationNode] ON [HumanResources].[Employee] ([OrganizationLevel], [OrganizationNode]);
GO
CREATE UNIQUE INDEX [AK_Employee_LoginID] ON [HumanResources].[Employee]([LoginID]) ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_Employee_NationalIDNumber] ON [HumanResources].[Employee]([NationalIDNumber]) ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_Employee_rowguid] ON [HumanResources].[Employee]([rowguid]) ON [PRIMARY];
GO
CREATE TRIGGER [HumanResources].[dEmployee] ON [HumanResources].[Employee] 
INSTEAD OF DELETE NOT FOR REPLICATION AS 
BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    BEGIN
        RAISERROR
            (N'Employees cannot be deleted. They can only be marked as not current.', -- Message
            10, -- Severity.
            1); -- State.

        -- Rollback any active or uncommittable transactions
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
    END;
END;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Employee information such as salary, department, and title.', N'SCHEMA', [HumanResources], N'TABLE', [Employee], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key for Employee records.  Foreign key to BusinessEntity.BusinessEntityID.', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'COLUMN', [BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique national identification number such as a social security number.', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'COLUMN', [NationalIDNumber];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Network login.', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'COLUMN', [LoginID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Where the employee is located in corporate hierarchy.', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'COLUMN', [OrganizationNode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'The depth of the employee in the corporate hierarchy.', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'COLUMN', [OrganizationLevel];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Work title such as Buyer or Sales Representative.', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'COLUMN', [JobTitle];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date of birth.', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'COLUMN', [BirthDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'M = Married, S = Single', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'COLUMN', [MaritalStatus];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'M = Male, F = Female', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'COLUMN', [Gender];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Employee hired on this date.', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'COLUMN', [HireDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Job classification. 0 = Hourly, not exempt from collective bargaining. 1 = Salaried, exempt from collective bargaining.', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'COLUMN', [SalariedFlag];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Number of available vacation hours.', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'COLUMN', [VacationHours];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Number of available sick leave hours.', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'COLUMN', [SickLeaveHours];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'0 = Inactive, 1 = Active', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'COLUMN', [CurrentFlag];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'COLUMN', [rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'COLUMN', [ModifiedDate];
GO
-- Triggers
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'INSTEAD OF DELETE trigger which keeps Employees from being deleted.', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'TRIGGER', [dEmployee];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index.', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'INDEX', [AK_Employee_LoginID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index.', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'INDEX', [AK_Employee_NationalIDNumber];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'INDEX', [AK_Employee_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index.', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'INDEX', [IX_Employee_OrganizationNode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index.', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'INDEX', [IX_Employee_OrganizationLevel_OrganizationNode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'CONSTRAINT', [PK_Employee_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Person.BusinessEntityID.', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'CONSTRAINT', [FK_Employee_Person_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'CONSTRAINT', [DF_Employee_SickLeaveHours];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'CONSTRAINT', [DF_Employee_VacationHours];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 1 (TRUE)', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'CONSTRAINT', [DF_Employee_SalariedFlag];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 1', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'CONSTRAINT', [DF_Employee_CurrentFlag];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'CONSTRAINT', [DF_Employee_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of NEWID()', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'CONSTRAINT', [DF_Employee_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [BirthDate] >= ''1930-01-01'' AND [BirthDate] <= dateadd(year,(-18),GETDATE())', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'CONSTRAINT', [CK_Employee_BirthDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [HireDate] >= ''1996-07-01'' AND [HireDate] <= dateadd(day,(1),GETDATE())', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'CONSTRAINT', [CK_Employee_HireDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [SickLeaveHours] >= (0) AND [SickLeaveHours] <= (120)', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'CONSTRAINT', [CK_Employee_SickLeaveHours];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [VacationHours] >= (-40) AND [VacationHours] <= (240)', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'CONSTRAINT', [CK_Employee_VacationHours];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [Gender]=''f'' OR [Gender]=''m'' OR [Gender]=''F'' OR [Gender]=''M''', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'CONSTRAINT', [CK_Employee_Gender];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [MaritalStatus]=''s'' OR [MaritalStatus]=''m'' OR [MaritalStatus]=''S'' OR [MaritalStatus]=''M''', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'CONSTRAINT', [CK_Employee_MaritalStatus];