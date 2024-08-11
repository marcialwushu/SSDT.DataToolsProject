CREATE TABLE [Sales].[SalesOrderDetail](
    [SalesOrderID] [int] NOT NULL,
    [SalesOrderDetailID] [int] IDENTITY (1, 1) NOT NULL,
    [CarrierTrackingNumber] [nvarchar](25) NULL, 
    [OrderQty] [smallint] NOT NULL,
    [ProductID] [int] NOT NULL,
    [SpecialOfferID] [int] NOT NULL,
    [UnitPrice] [money] NOT NULL,
    [UnitPriceDiscount] [money] NOT NULL CONSTRAINT [DF_SalesOrderDetail_UnitPriceDiscount] DEFAULT (0.0),
    [LineTotal] AS ISNULL([UnitPrice] * (1.0 - [UnitPriceDiscount]) * [OrderQty], 0.0),
    [rowguid] uniqueidentifier ROWGUIDCOL NOT NULL CONSTRAINT [DF_SalesOrderDetail_rowguid] DEFAULT (NEWID()), 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesOrderDetail_ModifiedDate] DEFAULT (GETDATE()), 
    CONSTRAINT [CK_SalesOrderDetail_OrderQty] CHECK ([OrderQty] > 0), 
    CONSTRAINT [CK_SalesOrderDetail_UnitPrice] CHECK ([UnitPrice] >= 0.00), 
    CONSTRAINT [CK_SalesOrderDetail_UnitPriceDiscount] CHECK ([UnitPriceDiscount] >= 0.00) 
) ON [PRIMARY];
GO
ALTER TABLE [Sales].[SalesOrderDetail] ADD 
    CONSTRAINT [FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID] FOREIGN KEY 
    (
        [SalesOrderID]
    ) REFERENCES [Sales].[SalesOrderHeader](
        [SalesOrderID]
    ) ON DELETE CASCADE,
    CONSTRAINT [FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID] FOREIGN KEY 
    (
        [SpecialOfferID],
        [ProductID]
    ) REFERENCES [Sales].[SpecialOfferProduct](
        [SpecialOfferID],
        [ProductID]
    );
GO
ALTER TABLE [Sales].[SalesOrderDetail] WITH CHECK ADD 
    CONSTRAINT [PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID] PRIMARY KEY CLUSTERED 
    (
        [SalesOrderID],
        [SalesOrderDetailID]
    )  ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_SalesOrderDetail_rowguid] ON [Sales].[SalesOrderDetail]([rowguid]) ON [PRIMARY];
GO
CREATE INDEX [IX_SalesOrderDetail_ProductID] ON [Sales].[SalesOrderDetail]([ProductID]) ON [PRIMARY];
GO
CREATE TRIGGER [Sales].[iduSalesOrderDetail] ON [Sales].[SalesOrderDetail] 
AFTER INSERT, DELETE, UPDATE AS 
BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    BEGIN TRY
        -- If inserting or updating these columns
        IF UPDATE([ProductID]) OR UPDATE([OrderQty]) OR UPDATE([UnitPrice]) OR UPDATE([UnitPriceDiscount]) 
        -- Insert record into TransactionHistory
        BEGIN
            INSERT INTO [Production].[TransactionHistory]
                ([ProductID]
                ,[ReferenceOrderID]
                ,[ReferenceOrderLineID]
                ,[TransactionType]
                ,[TransactionDate]
                ,[Quantity]
                ,[ActualCost])
            SELECT 
                inserted.[ProductID]
                ,inserted.[SalesOrderID]
                ,inserted.[SalesOrderDetailID]
                ,'S'
                ,GETDATE()
                ,inserted.[OrderQty]
                ,inserted.[UnitPrice]
            FROM inserted 
                INNER JOIN [Sales].[SalesOrderHeader] 
                ON inserted.[SalesOrderID] = [Sales].[SalesOrderHeader].[SalesOrderID];

            UPDATE [Person].[Person] 
            SET [Demographics].modify('declare default element namespace 
                "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
                replace value of (/IndividualSurvey/TotalPurchaseYTD)[1] 
                with data(/IndividualSurvey/TotalPurchaseYTD)[1] + sql:column ("inserted.LineTotal")') 
            FROM inserted 
                INNER JOIN [Sales].[SalesOrderHeader] AS SOH
                ON inserted.[SalesOrderID] = SOH.[SalesOrderID] 
                INNER JOIN [Sales].[Customer] AS C
                ON SOH.[CustomerID] = C.[CustomerID]
            WHERE C.[PersonID] = [Person].[Person].[BusinessEntityID];
        END;

        -- Update SubTotal in SalesOrderHeader record. Note that this causes the 
        -- SalesOrderHeader trigger to fire which will update the RevisionNumber.
        UPDATE [Sales].[SalesOrderHeader]
        SET [Sales].[SalesOrderHeader].[SubTotal] = 
            (SELECT SUM([Sales].[SalesOrderDetail].[LineTotal])
                FROM [Sales].[SalesOrderDetail]
                WHERE [Sales].[SalesOrderHeader].[SalesOrderID] = [Sales].[SalesOrderDetail].[SalesOrderID])
        WHERE [Sales].[SalesOrderHeader].[SalesOrderID] IN (SELECT inserted.[SalesOrderID] FROM inserted);

        UPDATE [Person].[Person] 
        SET [Demographics].modify('declare default element namespace 
            "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
            replace value of (/IndividualSurvey/TotalPurchaseYTD)[1] 
            with data(/IndividualSurvey/TotalPurchaseYTD)[1] - sql:column("deleted.LineTotal")') 
        FROM deleted 
            INNER JOIN [Sales].[SalesOrderHeader] 
            ON deleted.[SalesOrderID] = [Sales].[SalesOrderHeader].[SalesOrderID] 
            INNER JOIN [Sales].[Customer]
            ON [Sales].[Customer].[CustomerID] = [Sales].[SalesOrderHeader].[CustomerID]
        WHERE [Sales].[Customer].[PersonID] = [Person].[Person].[BusinessEntityID];
    END TRY
    BEGIN CATCH
        EXECUTE [dbo].[uspPrintError];

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
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Individual products associated with a specific sales order. See SalesOrderHeader.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderDetail], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key. Foreign key to SalesOrderHeader.SalesOrderID.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderDetail], N'COLUMN', [SalesOrderID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key. One incremental unique number per product sold.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderDetail], N'COLUMN', [SalesOrderDetailID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Shipment tracking number supplied by the shipper.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderDetail], N'COLUMN', [CarrierTrackingNumber];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Quantity ordered per product.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderDetail], N'COLUMN', [OrderQty];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Product sold to customer. Foreign key to Product.ProductID.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderDetail], N'COLUMN', [ProductID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Promotional code. Foreign key to SpecialOffer.SpecialOfferID.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderDetail], N'COLUMN', [SpecialOfferID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Selling price of a single product.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderDetail], N'COLUMN', [UnitPrice];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Discount amount.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderDetail], N'COLUMN', [UnitPriceDiscount];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Per product subtotal. Computed as UnitPrice * (1 - UnitPriceDiscount) * OrderQty.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderDetail], N'COLUMN', [LineTotal];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderDetail], N'COLUMN', [rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderDetail], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'AFTER INSERT, DELETE, UPDATE trigger that inserts a row in the TransactionHistory table, updates ModifiedDate in SalesOrderDetail and updates the SalesOrderHeader.SubTotal column.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderDetail], N'TRIGGER', [iduSalesOrderDetail];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderDetail], N'INDEX', [AK_SalesOrderDetail_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderDetail], N'INDEX', [IX_SalesOrderDetail_ProductID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Sales], N'TABLE', [SalesOrderDetail], N'CONSTRAINT', [PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing SalesOrderHeader.PurchaseOrderID.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderDetail], N'CONSTRAINT', [FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0.0', N'SCHEMA', [Sales], N'TABLE', [SalesOrderDetail], N'CONSTRAINT', [DF_SalesOrderDetail_UnitPriceDiscount];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Sales], N'TABLE', [SalesOrderDetail], N'CONSTRAINT', [DF_SalesOrderDetail_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of NEWID()', N'SCHEMA', [Sales], N'TABLE', [SalesOrderDetail], N'CONSTRAINT', [DF_SalesOrderDetail_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [OrderQty] > (0)', N'SCHEMA', [Sales], N'TABLE', [SalesOrderDetail], N'CONSTRAINT', [CK_SalesOrderDetail_OrderQty];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [UnitPrice] >= (0.00)', N'SCHEMA', [Sales], N'TABLE', [SalesOrderDetail], N'CONSTRAINT', [CK_SalesOrderDetail_UnitPrice];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [UnitPriceDiscount] >= (0.00)', N'SCHEMA', [Sales], N'TABLE', [SalesOrderDetail], N'CONSTRAINT', [CK_SalesOrderDetail_UnitPriceDiscount];