CREATE TABLE [Sales].[SalesOrderHeader](
    [SalesOrderID] [int] IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [RevisionNumber] [tinyint] NOT NULL CONSTRAINT [DF_SalesOrderHeader_RevisionNumber] DEFAULT (0),
    [OrderDate] [datetime] NOT NULL CONSTRAINT [DF_SalesOrderHeader_OrderDate] DEFAULT (GETDATE()),
    [DueDate] [datetime] NOT NULL,
    [ShipDate] [datetime] NULL,
    [Status] [tinyint] NOT NULL CONSTRAINT [DF_SalesOrderHeader_Status] DEFAULT (1),
    [OnlineOrderFlag] [Flag] NOT NULL CONSTRAINT [DF_SalesOrderHeader_OnlineOrderFlag] DEFAULT (1),
    [SalesOrderNumber] AS ISNULL(N'SO' + CONVERT(nvarchar(23), [SalesOrderID]), N'*** ERROR ***'), 
    [PurchaseOrderNumber] [OrderNumber] NULL,
    [AccountNumber] [AccountNumber] NULL,
    [CustomerID] [int] NOT NULL,
    [SalesPersonID] [int] NULL,
    [TerritoryID] [int] NULL,
    [BillToAddressID] [int] NOT NULL,
    [ShipToAddressID] [int] NOT NULL,
    [ShipMethodID] [int] NOT NULL,
    [CreditCardID] [int] NULL,
    [CreditCardApprovalCode] [varchar](15) NULL,    
    [CurrencyRateID] [int] NULL,
    [SubTotal] [money] NOT NULL CONSTRAINT [DF_SalesOrderHeader_SubTotal] DEFAULT (0.00),
    [TaxAmt] [money] NOT NULL CONSTRAINT [DF_SalesOrderHeader_TaxAmt] DEFAULT (0.00),
    [Freight] [money] NOT NULL CONSTRAINT [DF_SalesOrderHeader_Freight] DEFAULT (0.00),
    [TotalDue] AS ISNULL([SubTotal] + [TaxAmt] + [Freight], 0),
    [Comment] [nvarchar](128) NULL,
    [rowguid] uniqueidentifier ROWGUIDCOL NOT NULL CONSTRAINT [DF_SalesOrderHeader_rowguid] DEFAULT (NEWID()), 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesOrderHeader_ModifiedDate] DEFAULT (GETDATE()),
    CONSTRAINT [CK_SalesOrderHeader_Status] CHECK ([Status] BETWEEN 0 AND 8), 
    CONSTRAINT [CK_SalesOrderHeader_DueDate] CHECK ([DueDate] >= [OrderDate]), 
    CONSTRAINT [CK_SalesOrderHeader_ShipDate] CHECK (([ShipDate] >= [OrderDate]) OR ([ShipDate] IS NULL)), 
    CONSTRAINT [CK_SalesOrderHeader_SubTotal] CHECK ([SubTotal] >= 0.00), 
    CONSTRAINT [CK_SalesOrderHeader_TaxAmt] CHECK ([TaxAmt] >= 0.00), 
    CONSTRAINT [CK_SalesOrderHeader_Freight] CHECK ([Freight] >= 0.00) 
) ON [PRIMARY];
GO
ALTER TABLE [Sales].[SalesOrderHeader] ADD 
    CONSTRAINT [FK_SalesOrderHeader_Address_BillToAddressID] FOREIGN KEY 
    (
        [BillToAddressID]
    ) REFERENCES [Person].[Address](
        [AddressID]
    ),
    CONSTRAINT [FK_SalesOrderHeader_Address_ShipToAddressID] FOREIGN KEY 
    (
        [ShipToAddressID]
    ) REFERENCES [Person].[Address](
        [AddressID]
    ),
    CONSTRAINT [FK_SalesOrderHeader_CreditCard_CreditCardID] FOREIGN KEY 
    (
        [CreditCardID]
    ) REFERENCES [Sales].[CreditCard](
        [CreditCardID]
    ),
    CONSTRAINT [FK_SalesOrderHeader_CurrencyRate_CurrencyRateID] FOREIGN KEY 
    (
        [CurrencyRateID]
    ) REFERENCES [Sales].[CurrencyRate](
        [CurrencyRateID]
    ),
    CONSTRAINT [FK_SalesOrderHeader_Customer_CustomerID] FOREIGN KEY 
    (
        [CustomerID]
    ) REFERENCES [Sales].[Customer](
        [CustomerID]
    ),
    CONSTRAINT [FK_SalesOrderHeader_SalesPerson_SalesPersonID] FOREIGN KEY 
    (
        [SalesPersonID]
    ) REFERENCES [Sales].[SalesPerson](
        [BusinessEntityID]
    ),
    CONSTRAINT [FK_SalesOrderHeader_ShipMethod_ShipMethodID] FOREIGN KEY 
    (
        [ShipMethodID]
    ) REFERENCES [Purchasing].[ShipMethod](
        [ShipMethodID]
    ),
    CONSTRAINT [FK_SalesOrderHeader_SalesTerritory_TerritoryID] FOREIGN KEY 
    (
        [TerritoryID]
    ) REFERENCES [Sales].[SalesTerritory](
        [TerritoryID]
    );
GO
ALTER TABLE [Sales].[SalesOrderHeader] WITH CHECK ADD 
    CONSTRAINT [PK_SalesOrderHeader_SalesOrderID] PRIMARY KEY CLUSTERED 
    (
        [SalesOrderID]
    )  ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_SalesOrderHeader_rowguid] ON [Sales].[SalesOrderHeader]([rowguid]) ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_SalesOrderHeader_SalesOrderNumber] ON [Sales].[SalesOrderHeader]([SalesOrderNumber]) ON [PRIMARY];
GO
CREATE INDEX [IX_SalesOrderHeader_CustomerID] ON [Sales].[SalesOrderHeader]([CustomerID]) ON [PRIMARY];
GO
CREATE INDEX [IX_SalesOrderHeader_SalesPersonID] ON [Sales].[SalesOrderHeader]([SalesPersonID]) ON [PRIMARY];
GO
CREATE TRIGGER [Sales].[uSalesOrderHeader] ON [Sales].[SalesOrderHeader] 
AFTER UPDATE NOT FOR REPLICATION AS 
BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    BEGIN TRY
        -- Update RevisionNumber for modification of any field EXCEPT the Status.
        IF NOT UPDATE([Status])
        BEGIN
            UPDATE [Sales].[SalesOrderHeader]
            SET [Sales].[SalesOrderHeader].[RevisionNumber] = 
                [Sales].[SalesOrderHeader].[RevisionNumber] + 1
            WHERE [Sales].[SalesOrderHeader].[SalesOrderID] IN 
                (SELECT inserted.[SalesOrderID] FROM inserted);
        END;

        -- Update the SalesPerson SalesYTD when SubTotal is updated
        IF UPDATE([SubTotal])
        BEGIN
            DECLARE @StartDate datetime,
                    @EndDate datetime

            SET @StartDate = [dbo].[ufnGetAccountingStartDate]();
            SET @EndDate = [dbo].[ufnGetAccountingEndDate]();

            UPDATE [Sales].[SalesPerson]
            SET [Sales].[SalesPerson].[SalesYTD] = 
                (SELECT SUM([Sales].[SalesOrderHeader].[SubTotal])
                FROM [Sales].[SalesOrderHeader] 
                WHERE [Sales].[SalesPerson].[BusinessEntityID] = [Sales].[SalesOrderHeader].[SalesPersonID]
                    AND ([Sales].[SalesOrderHeader].[Status] = 5) -- Shipped
                    AND [Sales].[SalesOrderHeader].[OrderDate] BETWEEN @StartDate AND @EndDate)
            WHERE [Sales].[SalesPerson].[BusinessEntityID] 
                IN (SELECT DISTINCT inserted.[SalesPersonID] FROM inserted 
                    WHERE inserted.[OrderDate] BETWEEN @StartDate AND @EndDate);

            -- Update the SalesTerritory SalesYTD when SubTotal is updated
            UPDATE [Sales].[SalesTerritory]
            SET [Sales].[SalesTerritory].[SalesYTD] = 
                (SELECT SUM([Sales].[SalesOrderHeader].[SubTotal])
                FROM [Sales].[SalesOrderHeader] 
                WHERE [Sales].[SalesTerritory].[TerritoryID] = [Sales].[SalesOrderHeader].[TerritoryID]
                    AND ([Sales].[SalesOrderHeader].[Status] = 5) -- Shipped
                    AND [Sales].[SalesOrderHeader].[OrderDate] BETWEEN @StartDate AND @EndDate)
            WHERE [Sales].[SalesTerritory].[TerritoryID] 
                IN (SELECT DISTINCT inserted.[TerritoryID] FROM inserted 
                    WHERE inserted.[OrderDate] BETWEEN @StartDate AND @EndDate);
        END;
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
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'General sales order information.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'COLUMN', [SalesOrderID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Incremental number to track changes to the sales order over time.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'COLUMN', [RevisionNumber];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Dates the sales order was created.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'COLUMN', [OrderDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date the order is due to the customer.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'COLUMN', [DueDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date the order was shipped to the customer.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'COLUMN', [ShipDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Order current status. 1 = In process; 2 = Approved; 3 = Backordered; 4 = Rejected; 5 = Shipped; 6 = Cancelled', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'COLUMN', [Status];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'0 = Order placed by sales person. 1 = Order placed online by customer.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'COLUMN', [OnlineOrderFlag];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique sales order identification number.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'COLUMN', [SalesOrderNumber];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Customer purchase order number reference. ', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'COLUMN', [PurchaseOrderNumber];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Financial accounting number reference.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'COLUMN', [AccountNumber];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Customer identification number. Foreign key to Customer.BusinessEntityID.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'COLUMN', [CustomerID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Sales person who created the sales order. Foreign key to SalesPerson.BusinessEntityID.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'COLUMN', [SalesPersonID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Territory in which the sale was made. Foreign key to SalesTerritory.SalesTerritoryID.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'COLUMN', [TerritoryID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Customer billing address. Foreign key to Address.AddressID.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'COLUMN', [BillToAddressID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Customer shipping address. Foreign key to Address.AddressID.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'COLUMN', [ShipToAddressID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Shipping method. Foreign key to ShipMethod.ShipMethodID.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'COLUMN', [ShipMethodID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Credit card identification number. Foreign key to CreditCard.CreditCardID.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'COLUMN', [CreditCardID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Approval code provided by the credit card company.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'COLUMN', [CreditCardApprovalCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Currency exchange rate used. Foreign key to CurrencyRate.CurrencyRateID.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'COLUMN', [CurrencyRateID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Sales subtotal. Computed as SUM(SalesOrderDetail.LineTotal)for the appropriate SalesOrderID.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'COLUMN', [SubTotal];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Tax amount.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'COLUMN', [TaxAmt];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Shipping cost.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'COLUMN', [Freight];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Total due from customer. Computed as Subtotal + TaxAmt + Freight.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'COLUMN', [TotalDue];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Sales representative comments.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'COLUMN', [Comment];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'COLUMN', [rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'AFTER UPDATE trigger that updates the RevisionNumber and ModifiedDate columns in the SalesOrderHeader table.Updates the SalesYTD column in the SalesPerson and SalesTerritory tables.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'TRIGGER', [uSalesOrderHeader];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'INDEX', [AK_SalesOrderHeader_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'INDEX', [AK_SalesOrderHeader_SalesOrderNumber];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'INDEX', [IX_SalesOrderHeader_CustomerID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'INDEX', [IX_SalesOrderHeader_SalesPersonID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'CONSTRAINT', [PK_SalesOrderHeader_SalesOrderID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Address.AddressID.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'CONSTRAINT', [FK_SalesOrderHeader_Address_BillToAddressID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'CONSTRAINT', [DF_SalesOrderHeader_RevisionNumber];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0.0', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'CONSTRAINT', [DF_SalesOrderHeader_Freight];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0.0', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'CONSTRAINT', [DF_SalesOrderHeader_SubTotal];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0.0', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'CONSTRAINT', [DF_SalesOrderHeader_TaxAmt];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 1 (TRUE)', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'CONSTRAINT', [DF_SalesOrderHeader_OnlineOrderFlag];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 1', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'CONSTRAINT', [DF_SalesOrderHeader_Status];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'CONSTRAINT', [DF_SalesOrderHeader_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'CONSTRAINT', [DF_SalesOrderHeader_OrderDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of NEWID()', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'CONSTRAINT', [DF_SalesOrderHeader_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [Freight] >= (0.00)', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'CONSTRAINT', [CK_SalesOrderHeader_Freight];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [SubTotal] >= (0.00)', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'CONSTRAINT', [CK_SalesOrderHeader_SubTotal];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [TaxAmt] >= (0.00)', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'CONSTRAINT', [CK_SalesOrderHeader_TaxAmt];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [DueDate] >= [OrderDate]', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'CONSTRAINT', [CK_SalesOrderHeader_DueDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [ShipDate] >= [OrderDate] OR [ShipDate] IS NULL', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'CONSTRAINT', [CK_SalesOrderHeader_ShipDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [Status] BETWEEN (0) AND (8)', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'CONSTRAINT', [CK_SalesOrderHeader_Status];