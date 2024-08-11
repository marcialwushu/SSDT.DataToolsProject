CREATE TABLE [Production].[Location](
    [LocationID] [smallint] IDENTITY (1, 1) NOT NULL,
    [Name] [Name] NOT NULL,
    [CostRate] [smallmoney] NOT NULL CONSTRAINT [DF_Location_CostRate] DEFAULT (0.00),
    [Availability] [decimal](8, 2) NOT NULL CONSTRAINT [DF_Location_Availability] DEFAULT (0.00), 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Location_ModifiedDate] DEFAULT (GETDATE()), 
    CONSTRAINT [CK_Location_CostRate] CHECK ([CostRate] >= 0.00), 
    CONSTRAINT [CK_Location_Availability] CHECK ([Availability] >= 0.00) 
) ON [PRIMARY];
GO
ALTER TABLE [Production].[Location] WITH CHECK ADD 
    CONSTRAINT [PK_Location_LocationID] PRIMARY KEY CLUSTERED 
    (
        [LocationID]
    )  ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_Location_Name] ON [Production].[Location]([Name]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Product inventory and manufacturing locations.', N'SCHEMA', [Production], N'TABLE', [Location], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key for Location records.', N'SCHEMA', [Production], N'TABLE', [Location], N'COLUMN', [LocationID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Location description.', N'SCHEMA', [Production], N'TABLE', [Location], N'COLUMN', [Name];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Standard hourly cost of the manufacturing location.', N'SCHEMA', [Production], N'TABLE', [Location], N'COLUMN', [CostRate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Work capacity (in hours) of the manufacturing location.', N'SCHEMA', [Production], N'TABLE', [Location], N'COLUMN', [Availability];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Production], N'TABLE', [Location], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index.', N'SCHEMA', [Production], N'TABLE', [Location], N'INDEX', [AK_Location_Name];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Production], N'TABLE', [Location], N'CONSTRAINT', [PK_Location_LocationID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0.00', N'SCHEMA', [Production], N'TABLE', [Location], N'CONSTRAINT', [DF_Location_Availability];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0.0', N'SCHEMA', [Production], N'TABLE', [Location], N'CONSTRAINT', [DF_Location_CostRate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Production], N'TABLE', [Location], N'CONSTRAINT', [DF_Location_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [Availability] >= (0.00)', N'SCHEMA', [Production], N'TABLE', [Location], N'CONSTRAINT', [CK_Location_Availability];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [CostRate] >= (0.00)', N'SCHEMA', [Production], N'TABLE', [Location], N'CONSTRAINT', [CK_Location_CostRate];