CREATE FUNCTION [dbo].[ufnGetAccountingStartDate]()
RETURNS [datetime] 
AS 
BEGIN
    RETURN CONVERT(datetime, '20030701', 112);
END;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Scalar function used in the uSalesOrderHeader trigger to set the ending account date.', N'SCHEMA', [dbo], N'FUNCTION', [ufnGetAccountingStartDate], NULL, NULL;