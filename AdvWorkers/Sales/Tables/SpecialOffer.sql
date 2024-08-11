CREATE TABLE [Sales].[SpecialOffer](
    [SpecialOfferID] [int] IDENTITY (1, 1) NOT NULL,
    [Description] [nvarchar](255) NOT NULL,
    [DiscountPct] [smallmoney] NOT NULL CONSTRAINT [DF_SpecialOffer_DiscountPct] DEFAULT (0.00),
    [Type] [nvarchar](50) NOT NULL,
    [Category] [nvarchar](50) NOT NULL,
    [StartDate] [datetime] NOT NULL,
    [EndDate] [datetime] NOT NULL,
    [MinQty] [int] NOT NULL CONSTRAINT [DF_SpecialOffer_MinQty] DEFAULT (0), 
    [MaxQty] [int] NULL,
    [rowguid] uniqueidentifier ROWGUIDCOL NOT NULL CONSTRAINT [DF_SpecialOffer_rowguid] DEFAULT (NEWID()), 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_SpecialOffer_ModifiedDate] DEFAULT (GETDATE()), 
    CONSTRAINT [CK_SpecialOffer_EndDate] CHECK ([EndDate] >= [StartDate]), 
    CONSTRAINT [CK_SpecialOffer_DiscountPct] CHECK ([DiscountPct] >= 0.00), 
    CONSTRAINT [CK_SpecialOffer_MinQty] CHECK ([MinQty] >= 0), 
    CONSTRAINT [CK_SpecialOffer_MaxQty]  CHECK ([MaxQty] >= 0)
) ON [PRIMARY];
GO
ALTER TABLE [Sales].[SpecialOffer] WITH CHECK ADD 
    CONSTRAINT [PK_SpecialOffer_SpecialOfferID] PRIMARY KEY CLUSTERED 
    (
        [SpecialOfferID]
    )  ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_SpecialOffer_rowguid] ON [Sales].[SpecialOffer]([rowguid]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Sale discounts lookup table.', N'SCHEMA', [Sales], N'TABLE', [SpecialOffer], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key for SpecialOffer records.', N'SCHEMA', [Sales], N'TABLE', [SpecialOffer], N'COLUMN', [SpecialOfferID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Discount description.', N'SCHEMA', [Sales], N'TABLE', [SpecialOffer], N'COLUMN', [Description];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Discount precentage.', N'SCHEMA', [Sales], N'TABLE', [SpecialOffer], N'COLUMN', [DiscountPct];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Discount type category.', N'SCHEMA', [Sales], N'TABLE', [SpecialOffer], N'COLUMN', [Type];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Group the discount applies to such as Reseller or Customer.', N'SCHEMA', [Sales], N'TABLE', [SpecialOffer], N'COLUMN', [Category];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Discount start date.', N'SCHEMA', [Sales], N'TABLE', [SpecialOffer], N'COLUMN', [StartDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Discount end date.', N'SCHEMA', [Sales], N'TABLE', [SpecialOffer], N'COLUMN', [EndDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Minimum discount percent allowed.', N'SCHEMA', [Sales], N'TABLE', [SpecialOffer], N'COLUMN', [MinQty];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Maximum discount percent allowed.', N'SCHEMA', [Sales], N'TABLE', [SpecialOffer], N'COLUMN', [MaxQty];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', N'SCHEMA', [Sales], N'TABLE', [SpecialOffer], N'COLUMN', [rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Sales], N'TABLE', [SpecialOffer], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', N'SCHEMA', [Sales], N'TABLE', [SpecialOffer], N'INDEX', [AK_SpecialOffer_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Sales], N'TABLE', [SpecialOffer], N'CONSTRAINT', [PK_SpecialOffer_SpecialOfferID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0.0', N'SCHEMA', [Sales], N'TABLE', [SpecialOffer], N'CONSTRAINT', [DF_SpecialOffer_DiscountPct];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0.0', N'SCHEMA', [Sales], N'TABLE', [SpecialOffer], N'CONSTRAINT', [DF_SpecialOffer_MinQty];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Sales], N'TABLE', [SpecialOffer], N'CONSTRAINT', [DF_SpecialOffer_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of NEWID()', N'SCHEMA', [Sales], N'TABLE', [SpecialOffer], N'CONSTRAINT', [DF_SpecialOffer_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [DiscountPct] >= (0.00)', N'SCHEMA', [Sales], N'TABLE', [SpecialOffer], N'CONSTRAINT', [CK_SpecialOffer_DiscountPct];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [MaxQty] >= (0)', N'SCHEMA', [Sales], N'TABLE', [SpecialOffer], N'CONSTRAINT', [CK_SpecialOffer_MaxQty];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [MinQty] >= (0)', N'SCHEMA', [Sales], N'TABLE', [SpecialOffer], N'CONSTRAINT', [CK_SpecialOffer_MinQty];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [EndDate] >= [StartDate]', N'SCHEMA', [Sales], N'TABLE', [SpecialOffer], N'CONSTRAINT', [CK_SpecialOffer_EndDate];