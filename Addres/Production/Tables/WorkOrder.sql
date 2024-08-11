CREATE TABLE [Production].[WorkOrder](
    [WorkOrderID] [int] IDENTITY (1, 1) NOT NULL,
    [ProductID] [int] NOT NULL,
    [OrderQty] [int] NOT NULL,
    [StockedQty] AS ISNULL([OrderQty] - [ScrappedQty], 0),
    [ScrappedQty] [smallint] NOT NULL,
    [StartDate] [datetime] NOT NULL,
    [EndDate] [datetime] NULL,
    [DueDate] [datetime] NOT NULL,
    [ScrapReasonID] [smallint] NULL, 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_WorkOrder_ModifiedDate] DEFAULT (GETDATE()), 
    CONSTRAINT [CK_WorkOrder_OrderQty] CHECK ([OrderQty] > 0), 
    CONSTRAINT [CK_WorkOrder_ScrappedQty] CHECK ([ScrappedQty] >= 0), 
    CONSTRAINT [CK_WorkOrder_EndDate] CHECK (([EndDate] >= [StartDate]) OR ([EndDate] IS NULL))
) ON [PRIMARY];
GO
ALTER TABLE [Production].[WorkOrder] ADD 
    CONSTRAINT [FK_WorkOrder_Product_ProductID] FOREIGN KEY 
    (
        [ProductID]
    ) REFERENCES [Production].[Product](
        [ProductID]
    ),
    CONSTRAINT [FK_WorkOrder_ScrapReason_ScrapReasonID] FOREIGN KEY 
    (
        [ScrapReasonID]
    ) REFERENCES [Production].[ScrapReason](
        [ScrapReasonID]
    );
GO
ALTER TABLE [Production].[WorkOrder] WITH CHECK ADD 
    CONSTRAINT [PK_WorkOrder_WorkOrderID] PRIMARY KEY CLUSTERED 
    (
        [WorkOrderID]
    )  ON [PRIMARY];
GO
CREATE INDEX [IX_WorkOrder_ScrapReasonID] ON [Production].[WorkOrder]([ScrapReasonID]) ON [PRIMARY];
GO
CREATE INDEX [IX_WorkOrder_ProductID] ON [Production].[WorkOrder]([ProductID]) ON [PRIMARY];
GO
CREATE TRIGGER [Production].[iWorkOrder] ON [Production].[WorkOrder] 
AFTER INSERT AS 
BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO [Production].[TransactionHistory](
            [ProductID]
            ,[ReferenceOrderID]
            ,[TransactionType]
            ,[TransactionDate]
            ,[Quantity]
            ,[ActualCost])
        SELECT 
            inserted.[ProductID]
            ,inserted.[WorkOrderID]
            ,'W'
            ,GETDATE()
            ,inserted.[OrderQty]
            ,0
        FROM inserted;
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
CREATE TRIGGER [Production].[uWorkOrder] ON [Production].[WorkOrder] 
AFTER UPDATE AS 
BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    BEGIN TRY
        IF UPDATE([ProductID]) OR UPDATE([OrderQty])
        BEGIN
            INSERT INTO [Production].[TransactionHistory](
                [ProductID]
                ,[ReferenceOrderID]
                ,[TransactionType]
                ,[TransactionDate]
                ,[Quantity])
            SELECT 
                inserted.[ProductID]
                ,inserted.[WorkOrderID]
                ,'W'
                ,GETDATE()
                ,inserted.[OrderQty]
            FROM inserted;
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
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Manufacturing work orders.', N'SCHEMA', [Production], N'TABLE', [WorkOrder], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key for WorkOrder records.', N'SCHEMA', [Production], N'TABLE', [WorkOrder], N'COLUMN', [WorkOrderID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Product identification number. Foreign key to Product.ProductID.', N'SCHEMA', [Production], N'TABLE', [WorkOrder], N'COLUMN', [ProductID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Product quantity to build.', N'SCHEMA', [Production], N'TABLE', [WorkOrder], N'COLUMN', [OrderQty];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Quantity built and put in inventory.', N'SCHEMA', [Production], N'TABLE', [WorkOrder], N'COLUMN', [StockedQty];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Quantity that failed inspection.', N'SCHEMA', [Production], N'TABLE', [WorkOrder], N'COLUMN', [ScrappedQty];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Work order start date.', N'SCHEMA', [Production], N'TABLE', [WorkOrder], N'COLUMN', [StartDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Work order end date.', N'SCHEMA', [Production], N'TABLE', [WorkOrder], N'COLUMN', [EndDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Work order due date.', N'SCHEMA', [Production], N'TABLE', [WorkOrder], N'COLUMN', [DueDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Reason for inspection failure.', N'SCHEMA', [Production], N'TABLE', [WorkOrder], N'COLUMN', [ScrapReasonID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Production], N'TABLE', [WorkOrder], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'AFTER INSERT trigger that inserts a row in the TransactionHistory table.', N'SCHEMA', [Production], N'TABLE', [WorkOrder], N'TRIGGER', [iWorkOrder];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'AFTER UPDATE trigger that inserts a row in the TransactionHistory table, updates ModifiedDate in the WorkOrder table.', N'SCHEMA', [Production], N'TABLE', [WorkOrder], N'TRIGGER', [uWorkOrder];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index.', N'SCHEMA', [Production], N'TABLE', [WorkOrder], N'INDEX', [IX_WorkOrder_ProductID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index.', N'SCHEMA', [Production], N'TABLE', [WorkOrder], N'INDEX', [IX_WorkOrder_ScrapReasonID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Production], N'TABLE', [WorkOrder], N'CONSTRAINT', [PK_WorkOrder_WorkOrderID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Product.ProductID.', N'SCHEMA', [Production], N'TABLE', [WorkOrder], N'CONSTRAINT', [FK_WorkOrder_Product_ProductID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Production], N'TABLE', [WorkOrder], N'CONSTRAINT', [DF_WorkOrder_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [OrderQty] > (0)', N'SCHEMA', [Production], N'TABLE', [WorkOrder], N'CONSTRAINT', [CK_WorkOrder_OrderQty];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [ScrappedQty] >= (0)', N'SCHEMA', [Production], N'TABLE', [WorkOrder], N'CONSTRAINT', [CK_WorkOrder_ScrappedQty];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [EndDate] >= [StartDate] OR [EndDate] IS NULL', N'SCHEMA', [Production], N'TABLE', [WorkOrder], N'CONSTRAINT', [CK_WorkOrder_EndDate];