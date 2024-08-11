CREATE PROCEDURE [HumanResources].[uspUpdateEmployeeHireInfo]
    @BusinessEntityID [int], 
    @JobTitle [nvarchar](50), 
    @HireDate [datetime], 
    @RateChangeDate [datetime], 
    @Rate [money], 
    @PayFrequency [tinyint], 
    @CurrentFlag [dbo].[Flag] 
WITH EXECUTE AS CALLER
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE [HumanResources].[Employee] 
        SET [JobTitle] = @JobTitle 
            ,[HireDate] = @HireDate 
            ,[CurrentFlag] = @CurrentFlag 
        WHERE [BusinessEntityID] = @BusinessEntityID;

        INSERT INTO [HumanResources].[EmployeePayHistory] 
            ([BusinessEntityID]
            ,[RateChangeDate]
            ,[Rate]
            ,[PayFrequency]) 
        VALUES (@BusinessEntityID, @RateChangeDate, @Rate, @PayFrequency);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback any active or uncommittable transactions before
        -- inserting information in the ErrorLog
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END

        EXECUTE [dbo].[uspLogError];
    END CATCH;
END;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Updates the Employee table and inserts a new row in the EmployeePayHistory table with the values specified in the input parameters.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeeHireInfo], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeHireInfo. Enter a valid BusinessEntityID from the Employee table.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeeHireInfo], N'PARAMETER', '@BusinessEntityID';
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeHireInfo. Enter a title for the employee.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeeHireInfo], N'PARAMETER', '@JobTitle';
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeHireInfo. Enter a hire date for the employee.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeeHireInfo], N'PARAMETER', '@HireDate';
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeHireInfo. Enter the date the rate changed for the employee.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeeHireInfo], N'PARAMETER', '@RateChangeDate';
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeHireInfo. Enter the new rate for the employee.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeeHireInfo], N'PARAMETER', '@Rate';
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeHireInfo. Enter the pay frequency for the employee.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeeHireInfo], N'PARAMETER', '@PayFrequency';
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeHireInfo. Enter the current flag for the employee.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeeHireInfo], N'PARAMETER', '@CurrentFlag';