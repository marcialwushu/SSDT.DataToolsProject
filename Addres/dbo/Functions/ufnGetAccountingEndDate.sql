CREATE FUNCTION [dbo].[ufnGetAccountingEndDate]()
RETURNS [datetime] 
AS 
BEGIN
    RETURN DATEADD(millisecond, -2, CONVERT(datetime, '20040701', 112));
END;
GO
-- Functions
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Scalar function used in the uSalesOrderHeader trigger to set the starting account date.', N'SCHEMA', [dbo], N'FUNCTION', [ufnGetAccountingEndDate], NULL, NULL;