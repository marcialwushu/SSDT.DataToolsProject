CREATE FUNCTION [dbo].[ufnGetProductStandardCost](@ProductID [int], @OrderDate [datetime])
RETURNS [money] 
AS 
-- Returns the standard cost for the product on a specific date.
BEGIN
    DECLARE @StandardCost money;

    SELECT @StandardCost = pch.[StandardCost] 
    FROM [Production].[Product] p 
        INNER JOIN [Production].[ProductCostHistory] pch 
        ON p.[ProductID] = pch.[ProductID] 
            AND p.[ProductID] = @ProductID 
            AND @OrderDate BETWEEN pch.[StartDate] AND COALESCE(pch.[EndDate], CONVERT(datetime, '99991231', 112)); -- Make sure we get all the prices!

    RETURN @StandardCost;
END;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Scalar function returning the standard cost for a given product on a particular order date.', N'SCHEMA', [dbo], N'FUNCTION', [ufnGetProductStandardCost], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the scalar function ufnGetProductStandardCost. Enter a valid ProductID from the Production.Product table.', N'SCHEMA', [dbo], N'FUNCTION', [ufnGetProductStandardCost], N'PARAMETER', '@ProductID';
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the scalar function ufnGetProductStandardCost. Enter a valid order date.', N'SCHEMA', [dbo], N'FUNCTION', [ufnGetProductStandardCost], N'PARAMETER', '@OrderDate';