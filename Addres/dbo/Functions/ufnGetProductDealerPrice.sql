CREATE FUNCTION [dbo].[ufnGetProductDealerPrice](@ProductID [int], @OrderDate [datetime])
RETURNS [money] 
AS 
-- Returns the dealer price for the product on a specific date.
BEGIN
    DECLARE @DealerPrice money;
    DECLARE @DealerDiscount money;

    SET @DealerDiscount = 0.60  -- 60% of list price

    SELECT @DealerPrice = plph.[ListPrice] * @DealerDiscount 
    FROM [Production].[Product] p 
        INNER JOIN [Production].[ProductListPriceHistory] plph 
        ON p.[ProductID] = plph.[ProductID] 
            AND p.[ProductID] = @ProductID 
            AND @OrderDate BETWEEN plph.[StartDate] AND COALESCE(plph.[EndDate], CONVERT(datetime, '99991231', 112)); -- Make sure we get all the prices!

    RETURN @DealerPrice;
END;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Scalar function returning the dealer price for a given product on a particular order date.', N'SCHEMA', [dbo], N'FUNCTION', [ufnGetProductDealerPrice], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the scalar function ufnGetProductDealerPrice. Enter a valid ProductID from the Production.Product table.', N'SCHEMA', [dbo], N'FUNCTION', [ufnGetProductDealerPrice], N'PARAMETER', '@ProductID';
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the scalar function ufnGetProductDealerPrice. Enter a valid order date.', N'SCHEMA', [dbo], N'FUNCTION', [ufnGetProductDealerPrice], N'PARAMETER', '@OrderDate';