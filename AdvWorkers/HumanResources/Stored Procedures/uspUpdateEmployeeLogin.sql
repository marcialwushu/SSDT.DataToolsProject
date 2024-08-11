CREATE PROCEDURE [HumanResources].[uspUpdateEmployeeLogin]
    @BusinessEntityID [int], 
    @OrganizationNode [hierarchyid],
    @LoginID [nvarchar](256),
    @JobTitle [nvarchar](50),
    @HireDate [datetime],
    @CurrentFlag [dbo].[Flag]
WITH EXECUTE AS CALLER
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        UPDATE [HumanResources].[Employee] 
        SET [OrganizationNode] = @OrganizationNode 
            ,[LoginID] = @LoginID 
            ,[JobTitle] = @JobTitle 
            ,[HireDate] = @HireDate 
            ,[CurrentFlag] = @CurrentFlag 
        WHERE [BusinessEntityID] = @BusinessEntityID;
    END TRY
    BEGIN CATCH
        EXECUTE [dbo].[uspLogError];
    END CATCH;
END;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Updates the Employee table with the values specified in the input parameters for the given BusinessEntityID.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeeLogin], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeLogin. Enter a valid EmployeeID from the Employee table.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeeLogin], N'PARAMETER', '@BusinessEntityID';
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeHireInfo. Enter a valid ManagerID for the employee.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeeLogin], N'PARAMETER', '@OrganizationNode';
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeHireInfo. Enter a valid login for the employee.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeeLogin], N'PARAMETER', '@LoginID';
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeHireInfo. Enter a title for the employee.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeeLogin], N'PARAMETER', '@JobTitle';
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeHireInfo. Enter a hire date for the employee.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeeLogin], N'PARAMETER', '@HireDate';
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeHireInfo. Enter the current flag for the employee.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeeLogin], N'PARAMETER', '@CurrentFlag';