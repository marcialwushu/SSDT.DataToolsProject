CREATE PROCEDURE [HumanResources].[uspUpdateEmployeePersonalInfo]
    @BusinessEntityID [int], 
    @NationalIDNumber [nvarchar](15), 
    @BirthDate [datetime], 
    @MaritalStatus [nchar](1), 
    @Gender [nchar](1)
WITH EXECUTE AS CALLER
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        UPDATE [HumanResources].[Employee] 
        SET [NationalIDNumber] = @NationalIDNumber 
            ,[BirthDate] = @BirthDate 
            ,[MaritalStatus] = @MaritalStatus 
            ,[Gender] = @Gender 
        WHERE [BusinessEntityID] = @BusinessEntityID;
    END TRY
    BEGIN CATCH
        EXECUTE [dbo].[uspLogError];
    END CATCH;
END;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Updates the Employee table with the values specified in the input parameters for the given EmployeeID.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeePersonalInfo], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeePersonalInfo. Enter a valid BusinessEntityID from the HumanResources.Employee table.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeePersonalInfo], N'PARAMETER', '@BusinessEntityID';
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeHireInfo. Enter a national ID for the employee.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeePersonalInfo], N'PARAMETER', '@NationalIDNumber';
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeHireInfo. Enter a birth date for the employee.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeePersonalInfo], N'PARAMETER', '@BirthDate';
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeHireInfo. Enter a marital status for the employee.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeePersonalInfo], N'PARAMETER', '@MaritalStatus';
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeHireInfo. Enter a gender for the employee.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeePersonalInfo], N'PARAMETER', '@Gender';