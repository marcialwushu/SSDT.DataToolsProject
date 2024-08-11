CREATE TABLE [Sales].[SalesReason](
    [SalesReasonID] [int] IDENTITY (1, 1) NOT NULL,
    [Name] [Name] NOT NULL,
    [ReasonType] [Name] NOT NULL, 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_SalesReason_ModifiedDate] DEFAULT (GETDATE()) 
) ON [PRIMARY];
GO
ALTER TABLE [Sales].[SalesReason] WITH CHECK ADD 
    CONSTRAINT [PK_SalesReason_SalesReasonID] PRIMARY KEY CLUSTERED 
    (
        [SalesReasonID]
    )  ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Lookup table of customer purchase reasons.', N'SCHEMA', [Sales], N'TABLE', [SalesReason], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key for SalesReason records.', N'SCHEMA', [Sales], N'TABLE', [SalesReason], N'COLUMN', [SalesReasonID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Sales reason description.', N'SCHEMA', [Sales], N'TABLE', [SalesReason], N'COLUMN', [Name];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Category the sales reason belongs to.', N'SCHEMA', [Sales], N'TABLE', [SalesReason], N'COLUMN', [ReasonType];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Sales], N'TABLE', [SalesReason], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Sales], N'TABLE', [SalesReason], N'CONSTRAINT', [PK_SalesReason_SalesReasonID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Sales], N'TABLE', [SalesReason], N'CONSTRAINT', [DF_SalesReason_ModifiedDate];