CREATE TABLE [Purchasing].[PurchaseOrderHeader](
    [PurchaseOrderID] [int] IDENTITY (1, 1) NOT NULL, 
    [RevisionNumber] [tinyint] NOT NULL CONSTRAINT [DF_PurchaseOrderHeader_RevisionNumber] DEFAULT (0), 
    [Status] [tinyint] NOT NULL CONSTRAINT [DF_PurchaseOrderHeader_Status] DEFAULT (1), 
    [EmployeeID] [int] NOT NULL, 
    [VendorID] [int] NOT NULL, 
    [ShipMethodID] [int] NOT NULL, 
    [OrderDate] [datetime] NOT NULL CONSTRAINT [DF_PurchaseOrderHeader_OrderDate] DEFAULT (GETDATE()), 
    [ShipDate] [datetime] NULL, 
    [SubTotal] [money] NOT NULL CONSTRAINT [DF_PurchaseOrderHeader_SubTotal] DEFAULT (0.00), 
    [TaxAmt] [money] NOT NULL CONSTRAINT [DF_PurchaseOrderHeader_TaxAmt] DEFAULT (0.00), 
    [Freight] [money] NOT NULL CONSTRAINT [DF_PurchaseOrderHeader_Freight] DEFAULT (0.00), 
    [TotalDue] AS ISNULL([SubTotal] + [TaxAmt] + [Freight], 0) PERSISTED NOT NULL, 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_PurchaseOrderHeader_ModifiedDate] DEFAULT (GETDATE()), 
    CONSTRAINT [CK_PurchaseOrderHeader_Status] CHECK ([Status] BETWEEN 1 AND 4), -- 1 = Pending; 2 = Approved; 3 = Rejected; 4 = Complete 
    CONSTRAINT [CK_PurchaseOrderHeader_ShipDate] CHECK (([ShipDate] >= [OrderDate]) OR ([ShipDate] IS NULL)), 
    CONSTRAINT [CK_PurchaseOrderHeader_SubTotal] CHECK ([SubTotal] >= 0.00), 
    CONSTRAINT [CK_PurchaseOrderHeader_TaxAmt] CHECK ([TaxAmt] >= 0.00), 
    CONSTRAINT [CK_PurchaseOrderHeader_Freight] CHECK ([Freight] >= 0.00) 
) ON [PRIMARY];
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD 
    CONSTRAINT [FK_PurchaseOrderHeader_Employee_EmployeeID] FOREIGN KEY 
    (
        [EmployeeID]
    ) REFERENCES [HumanResources].[Employee](
        [BusinessEntityID]
    ),
    CONSTRAINT [FK_PurchaseOrderHeader_Vendor_VendorID] FOREIGN KEY 
    (
        [VendorID]
    ) REFERENCES [Purchasing].[Vendor](
        [BusinessEntityID]
    ),
    CONSTRAINT [FK_PurchaseOrderHeader_ShipMethod_ShipMethodID] FOREIGN KEY 
    (
        [ShipMethodID]
    ) REFERENCES [Purchasing].[ShipMethod](
        [ShipMethodID]
    );
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader] WITH CHECK ADD 
    CONSTRAINT [PK_PurchaseOrderHeader_PurchaseOrderID] PRIMARY KEY CLUSTERED 
    (
        [PurchaseOrderID]
    )  ON [PRIMARY];
GO
CREATE INDEX [IX_PurchaseOrderHeader_VendorID] ON [Purchasing].[PurchaseOrderHeader]([VendorID]) ON [PRIMARY];
GO
CREATE INDEX [IX_PurchaseOrderHeader_EmployeeID] ON [Purchasing].[PurchaseOrderHeader]([EmployeeID]) ON [PRIMARY];
GO
CREATE TRIGGER [Purchasing].[uPurchaseOrderHeader] ON [Purchasing].[PurchaseOrderHeader] 
AFTER UPDATE AS 
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
            UPDATE [Purchasing].[PurchaseOrderHeader]
            SET [Purchasing].[PurchaseOrderHeader].[RevisionNumber] = 
                [Purchasing].[PurchaseOrderHeader].[RevisionNumber] + 1
            WHERE [Purchasing].[PurchaseOrderHeader].[PurchaseOrderID] IN 
                (SELECT inserted.[PurchaseOrderID] FROM inserted);
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
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'General purchase order information. See PurchaseOrderDetail.', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key.', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'COLUMN', [PurchaseOrderID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Incremental number to track changes to the purchase order over time.', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'COLUMN', [RevisionNumber];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Order current status. 1 = Pending; 2 = Approved; 3 = Rejected; 4 = Complete', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'COLUMN', [Status];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Employee who created the purchase order. Foreign key to Employee.BusinessEntityID.', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'COLUMN', [EmployeeID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Vendor with whom the purchase order is placed. Foreign key to Vendor.BusinessEntityID.', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'COLUMN', [VendorID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Shipping method. Foreign key to ShipMethod.ShipMethodID.', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'COLUMN', [ShipMethodID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Purchase order creation date.', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'COLUMN', [OrderDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Estimated shipment date from the vendor.', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'COLUMN', [ShipDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Purchase order subtotal. Computed as SUM(PurchaseOrderDetail.LineTotal)for the appropriate PurchaseOrderID.', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'COLUMN', [SubTotal];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Tax amount.', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'COLUMN', [TaxAmt];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Shipping cost.', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'COLUMN', [Freight];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Total due to vendor. Computed as Subtotal + TaxAmt + Freight.', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'COLUMN', [TotalDue];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'AFTER UPDATE trigger that updates the RevisionNumber and ModifiedDate columns in the PurchaseOrderHeader table.', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'TRIGGER', [uPurchaseOrderHeader];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index.', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'INDEX', [IX_PurchaseOrderHeader_EmployeeID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index.', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'INDEX', [IX_PurchaseOrderHeader_VendorID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'CONSTRAINT', [PK_PurchaseOrderHeader_PurchaseOrderID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Employee.EmployeeID.', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'CONSTRAINT', [FK_PurchaseOrderHeader_Employee_EmployeeID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'CONSTRAINT', [DF_PurchaseOrderHeader_RevisionNumber];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0.0', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'CONSTRAINT', [DF_PurchaseOrderHeader_Freight];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0.0', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'CONSTRAINT', [DF_PurchaseOrderHeader_SubTotal];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0.0', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'CONSTRAINT', [DF_PurchaseOrderHeader_TaxAmt];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 1', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'CONSTRAINT', [DF_PurchaseOrderHeader_Status];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'CONSTRAINT', [DF_PurchaseOrderHeader_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'CONSTRAINT', [DF_PurchaseOrderHeader_OrderDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [Freight] >= (0.00)', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'CONSTRAINT', [CK_PurchaseOrderHeader_Freight];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [SubTotal] >= (0.00)', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'CONSTRAINT', [CK_PurchaseOrderHeader_SubTotal];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [TaxAmt] >= (0.00)', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'CONSTRAINT', [CK_PurchaseOrderHeader_TaxAmt];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [ShipDate] >= [OrderDate] OR [ShipDate] IS NULL', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'CONSTRAINT', [CK_PurchaseOrderHeader_ShipDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [Status] BETWEEN (1) AND (4)', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'CONSTRAINT', [CK_PurchaseOrderHeader_Status];