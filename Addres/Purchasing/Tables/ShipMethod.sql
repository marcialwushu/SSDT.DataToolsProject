CREATE TABLE [Purchasing].[ShipMethod](
    [ShipMethodID] [int] IDENTITY (1, 1) NOT NULL,
    [Name] [Name] NOT NULL,
    [ShipBase] [money] NOT NULL CONSTRAINT [DF_ShipMethod_ShipBase] DEFAULT (0.00),
    [ShipRate] [money] NOT NULL CONSTRAINT [DF_ShipMethod_ShipRate] DEFAULT (0.00),
    [rowguid] uniqueidentifier ROWGUIDCOL NOT NULL CONSTRAINT [DF_ShipMethod_rowguid] DEFAULT (NEWID()), 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_ShipMethod_ModifiedDate] DEFAULT (GETDATE()), 
    CONSTRAINT [CK_ShipMethod_ShipBase] CHECK ([ShipBase] > 0.00), 
    CONSTRAINT [CK_ShipMethod_ShipRate] CHECK ([ShipRate] > 0.00), 
) ON [PRIMARY];
GO
ALTER TABLE [Purchasing].[ShipMethod] WITH CHECK ADD 
    CONSTRAINT [PK_ShipMethod_ShipMethodID] PRIMARY KEY CLUSTERED 
    (
        [ShipMethodID]
    )  ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_ShipMethod_Name] ON [Purchasing].[ShipMethod]([Name]) ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_ShipMethod_rowguid] ON [Purchasing].[ShipMethod]([rowguid]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Shipping company lookup table.', N'SCHEMA', [Purchasing], N'TABLE', [ShipMethod], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key for ShipMethod records.', N'SCHEMA', [Purchasing], N'TABLE', [ShipMethod], N'COLUMN', [ShipMethodID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Shipping company name.', N'SCHEMA', [Purchasing], N'TABLE', [ShipMethod], N'COLUMN', [Name];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Minimum shipping charge.', N'SCHEMA', [Purchasing], N'TABLE', [ShipMethod], N'COLUMN', [ShipBase];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Shipping charge per pound.', N'SCHEMA', [Purchasing], N'TABLE', [ShipMethod], N'COLUMN', [ShipRate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', N'SCHEMA', [Purchasing], N'TABLE', [ShipMethod], N'COLUMN', [rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Purchasing], N'TABLE', [ShipMethod], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index.', N'SCHEMA', [Purchasing], N'TABLE', [ShipMethod], N'INDEX', [AK_ShipMethod_Name];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', N'SCHEMA', [Purchasing], N'TABLE', [ShipMethod], N'INDEX', [AK_ShipMethod_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Purchasing], N'TABLE', [ShipMethod], N'CONSTRAINT', [PK_ShipMethod_ShipMethodID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0.0', N'SCHEMA', [Purchasing], N'TABLE', [ShipMethod], N'CONSTRAINT', [DF_ShipMethod_ShipBase];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0.0', N'SCHEMA', [Purchasing], N'TABLE', [ShipMethod], N'CONSTRAINT', [DF_ShipMethod_ShipRate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Purchasing], N'TABLE', [ShipMethod], N'CONSTRAINT', [DF_ShipMethod_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of NEWID()', N'SCHEMA', [Purchasing], N'TABLE', [ShipMethod], N'CONSTRAINT', [DF_ShipMethod_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [ShipBase] > (0.00)', N'SCHEMA', [Purchasing], N'TABLE', [ShipMethod], N'CONSTRAINT', [CK_ShipMethod_ShipBase];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [ShipRate] > (0.00)', N'SCHEMA', [Purchasing], N'TABLE', [ShipMethod], N'CONSTRAINT', [CK_ShipMethod_ShipRate];