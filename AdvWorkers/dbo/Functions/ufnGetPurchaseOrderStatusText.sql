﻿CREATE FUNCTION [dbo].[ufnGetPurchaseOrderStatusText](@Status [tinyint])
RETURNS [nvarchar](15) 
AS 
-- Returns the sales order status text representation for the status value.
BEGIN
    DECLARE @ret [nvarchar](15);

    SET @ret = 
        CASE @Status
            WHEN 1 THEN 'Pending'
            WHEN 2 THEN 'Approved'
            WHEN 3 THEN 'Rejected'
            WHEN 4 THEN 'Complete'
            ELSE '** Invalid **'
        END;
    
    RETURN @ret
END;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Scalar function returning the text representation of the Status column in the PurchaseOrderHeader table.', N'SCHEMA', [dbo], N'FUNCTION', [ufnGetPurchaseOrderStatusText], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the scalar function ufnGetPurchaseOrdertStatusText. Enter a valid integer.', N'SCHEMA', [dbo], N'FUNCTION', [ufnGetPurchaseOrderStatusText], N'PARAMETER', '@Status';