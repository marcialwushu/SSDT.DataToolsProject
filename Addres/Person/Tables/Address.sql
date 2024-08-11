CREATE TABLE [Person].[Address](
    [AddressID] [int] IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [AddressLine1] [nvarchar](60) NOT NULL, 
    [AddressLine2] [nvarchar](60) NULL, 
    [City] [nvarchar](30) NOT NULL, 
    [StateProvinceID] [int] NOT NULL,
    [PostalCode] [nvarchar](15) NOT NULL, 
	[SpatialLocation] [geography] NULL,
    [rowguid] uniqueidentifier ROWGUIDCOL NOT NULL CONSTRAINT [DF_Address_rowguid] DEFAULT (NEWID()),
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Address_ModifiedDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO
ALTER TABLE [Person].[Address] ADD 
    CONSTRAINT [FK_Address_StateProvince_StateProvinceID] FOREIGN KEY 
    (
        [StateProvinceID]
    ) REFERENCES [Person].[StateProvince](
        [StateProvinceID]
    );
GO
ALTER TABLE [Person].[Address] WITH CHECK ADD 
    CONSTRAINT [PK_Address_AddressID] PRIMARY KEY CLUSTERED 
    (
        [AddressID]
    )  ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_Address_rowguid] ON [Person].[Address]([rowguid]) ON [PRIMARY];
GO
CREATE UNIQUE INDEX [IX_Address_AddressLine1_AddressLine2_City_StateProvinceID_PostalCode] ON [Person].[Address] ([AddressLine1], [AddressLine2], [City], [StateProvinceID], [PostalCode]) ON [PRIMARY];
GO
CREATE INDEX [IX_Address_StateProvinceID] ON [Person].[Address]([StateProvinceID]) ON [PRIMARY];
GO
-- Tables and Columns
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Street address information for customers, employees, and vendors.', N'SCHEMA', [Person], N'TABLE', [Address], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key for Address records.', N'SCHEMA', [Person], N'TABLE', [Address], N'COLUMN', [AddressID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'First street address line.', N'SCHEMA', [Person], N'TABLE', [Address], N'COLUMN', [AddressLine1];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Second street address line.', N'SCHEMA', [Person], N'TABLE', [Address], N'COLUMN', [AddressLine2];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Name of the city.', N'SCHEMA', [Person], N'TABLE', [Address], N'COLUMN', [City];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique identification number for the state or province. Foreign key to StateProvince table.', N'SCHEMA', [Person], N'TABLE', [Address], N'COLUMN', [StateProvinceID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Postal code for the street address.', N'SCHEMA', [Person], N'TABLE', [Address], N'COLUMN', [PostalCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Latitude and longitude of this address.', N'SCHEMA', [Person], N'TABLE', [Address], N'COLUMN', [SpatialLocation];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', N'SCHEMA', [Person], N'TABLE', [Address], N'COLUMN', [rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Person], N'TABLE', [Address], N'COLUMN', [ModifiedDate];
GO
-- Indexes
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', N'SCHEMA', [Person], N'TABLE', [Address], N'INDEX', [AK_Address_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index.', N'SCHEMA', [Person], N'TABLE', [Address], N'INDEX', [IX_Address_AddressLine1_AddressLine2_City_StateProvinceID_PostalCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index.', N'SCHEMA', [Person], N'TABLE', [Address], N'INDEX', [IX_Address_StateProvinceID];
GO
-- Constraints - PK, FK, DF, CK
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Person], N'TABLE', [Address], N'CONSTRAINT', [PK_Address_AddressID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing StateProvince.StateProvinceID.', N'SCHEMA', [Person], N'TABLE', [Address], N'CONSTRAINT', [FK_Address_StateProvince_StateProvinceID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Person], N'TABLE', [Address], N'CONSTRAINT', [DF_Address_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of NEWID()', N'SCHEMA', [Person], N'TABLE', [Address], N'CONSTRAINT', [DF_Address_rowguid];