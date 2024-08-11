CREATE FUNCTION [dbo].[ufnGetProductListPrice](@ProductID [int], @OrderDate [datetime])
RETURNS [money] 
AS 
BEGIN
    DECLARE @ListPrice money;

    SELECT @ListPrice = plph.[ListPrice] 
    FROM [Production].[Product] p 
        INNER JOIN [Production].[ProductListPriceHistory] plph 
        ON p.[ProductID] = plph.[ProductID] 
            AND p.[ProductID] = @ProductID 
            AND @OrderDate BETWEEN plph.[StartDate] AND COALESCE(plph.[EndDate], CONVERT(datetime, '99991231', 112)); -- Make sure we get all the prices!

    RETURN @ListPrice;
END;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Scalar function returning the list price for a given product on a particular order date.', N'SCHEMA', [dbo], N'FUNCTION', [ufnGetProductListPrice], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the scalar function ufnGetProductListPrice. Enter a valid ProductID from the Production.Product table.', N'SCHEMA', [dbo], N'FUNCTION', [ufnGetProductListPrice], N'PARAMETER', '@ProductID';
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the scalar function ufnGetProductListPrice. Enter a valid order date.', N'SCHEMA', [dbo], N'FUNCTION', [ufnGetProductListPrice], N'PARAMETER', '@OrderDate';