CREATE TABLE [Production].[WorkOrderRouting](
    [WorkOrderID] [int] NOT NULL,
    [ProductID] [int] NOT NULL,
    [OperationSequence] [smallint] NOT NULL,
    [LocationID] [smallint] NOT NULL,
    [ScheduledStartDate] [datetime] NOT NULL,
    [ScheduledEndDate] [datetime] NOT NULL,
    [ActualStartDate] [datetime] NULL,
    [ActualEndDate] [datetime] NULL,
    [ActualResourceHrs] [decimal](9, 4) NULL,
    [PlannedCost] [money] NOT NULL,
    [ActualCost] [money] NULL, 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_WorkOrderRouting_ModifiedDate] DEFAULT (GETDATE()), 
    CONSTRAINT [CK_WorkOrderRouting_ScheduledEndDate] CHECK ([ScheduledEndDate] >= [ScheduledStartDate]), 
    CONSTRAINT [CK_WorkOrderRouting_ActualEndDate] CHECK (([ActualEndDate] >= [ActualStartDate]) 
        OR ([ActualEndDate] IS NULL) OR ([ActualStartDate] IS NULL)), 
    CONSTRAINT [CK_WorkOrderRouting_ActualResourceHrs] CHECK ([ActualResourceHrs] >= 0.0000), 
    CONSTRAINT [CK_WorkOrderRouting_PlannedCost] CHECK ([PlannedCost] > 0.00), 
    CONSTRAINT [CK_WorkOrderRouting_ActualCost] CHECK ([ActualCost] > 0.00) 
) ON [PRIMARY];
GO
ALTER TABLE [Production].[WorkOrderRouting] ADD 
    CONSTRAINT [FK_WorkOrderRouting_Location_LocationID] FOREIGN KEY 
    (
        [LocationID]
    ) REFERENCES [Production].[Location](
        [LocationID]
    ),
    CONSTRAINT [FK_WorkOrderRouting_WorkOrder_WorkOrderID] FOREIGN KEY 
    (
        [WorkOrderID]
    ) REFERENCES [Production].[WorkOrder](
        [WorkOrderID]
    );
GO
ALTER TABLE [Production].[WorkOrderRouting] WITH CHECK ADD 
    CONSTRAINT [PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence] PRIMARY KEY CLUSTERED 
    (
        [WorkOrderID],
        [ProductID],
        [OperationSequence]
    )  ON [PRIMARY];
GO
CREATE INDEX [IX_WorkOrderRouting_ProductID] ON [Production].[WorkOrderRouting]([ProductID]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Work order details.', N'SCHEMA', [Production], N'TABLE', [WorkOrderRouting], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key. Foreign key to WorkOrder.WorkOrderID.', N'SCHEMA', [Production], N'TABLE', [WorkOrderRouting], N'COLUMN', [WorkOrderID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key. Foreign key to Product.ProductID.', N'SCHEMA', [Production], N'TABLE', [WorkOrderRouting], N'COLUMN', [ProductID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key. Indicates the manufacturing process sequence.', N'SCHEMA', [Production], N'TABLE', [WorkOrderRouting], N'COLUMN', [OperationSequence];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Manufacturing location where the part is processed. Foreign key to Location.LocationID.', N'SCHEMA', [Production], N'TABLE', [WorkOrderRouting], N'COLUMN', [LocationID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Planned manufacturing start date.', N'SCHEMA', [Production], N'TABLE', [WorkOrderRouting], N'COLUMN', [ScheduledStartDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Planned manufacturing end date.', N'SCHEMA', [Production], N'TABLE', [WorkOrderRouting], N'COLUMN', [ScheduledEndDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Actual start date.', N'SCHEMA', [Production], N'TABLE', [WorkOrderRouting], N'COLUMN', [ActualStartDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Actual end date.', N'SCHEMA', [Production], N'TABLE', [WorkOrderRouting], N'COLUMN', [ActualEndDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Number of manufacturing hours used.', N'SCHEMA', [Production], N'TABLE', [WorkOrderRouting], N'COLUMN', [ActualResourceHrs];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Estimated manufacturing cost.', N'SCHEMA', [Production], N'TABLE', [WorkOrderRouting], N'COLUMN', [PlannedCost];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Actual manufacturing cost.', N'SCHEMA', [Production], N'TABLE', [WorkOrderRouting], N'COLUMN', [ActualCost];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Production], N'TABLE', [WorkOrderRouting], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index.', N'SCHEMA', [Production], N'TABLE', [WorkOrderRouting], N'INDEX', [IX_WorkOrderRouting_ProductID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Production], N'TABLE', [WorkOrderRouting], N'CONSTRAINT', [PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Location.LocationID.', N'SCHEMA', [Production], N'TABLE', [WorkOrderRouting], N'CONSTRAINT', [FK_WorkOrderRouting_Location_LocationID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Production], N'TABLE', [WorkOrderRouting], N'CONSTRAINT', [DF_WorkOrderRouting_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [ActualCost] > (0.00)', N'SCHEMA', [Production], N'TABLE', [WorkOrderRouting], N'CONSTRAINT', [CK_WorkOrderRouting_ActualCost];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [ActualResourceHrs] >= (0.0000)', N'SCHEMA', [Production], N'TABLE', [WorkOrderRouting], N'CONSTRAINT', [CK_WorkOrderRouting_ActualResourceHrs];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [PlannedCost] > (0.00)', N'SCHEMA', [Production], N'TABLE', [WorkOrderRouting], N'CONSTRAINT', [CK_WorkOrderRouting_PlannedCost];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [ActualEndDate] >= [ActualStartDate] OR [ActualEndDate] IS NULL OR [ActualStartDate] IS NULL', N'SCHEMA', [Production], N'TABLE', [WorkOrderRouting], N'CONSTRAINT', [CK_WorkOrderRouting_ActualEndDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [ScheduledEndDate] >= [ScheduledStartDate]', N'SCHEMA', [Production], N'TABLE', [WorkOrderRouting], N'CONSTRAINT', [CK_WorkOrderRouting_ScheduledEndDate];