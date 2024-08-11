CREATE TABLE [Person].[CountryRegion](
    [CountryRegionCode] [nvarchar](3) NOT NULL, 
    [Name] [Name] NOT NULL, 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_CountryRegion_ModifiedDate] DEFAULT (GETDATE()) 
) ON [PRIMARY];
GO
ALTER TABLE [Person].[CountryRegion] WITH CHECK ADD 
    CONSTRAINT [PK_CountryRegion_CountryRegionCode] PRIMARY KEY CLUSTERED 
    (
        [CountryRegionCode]
    )  ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_CountryRegion_Name] ON [Person].[CountryRegion]([Name]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Lookup table containing the ISO standard codes for countries and regions.', N'SCHEMA', [Person], N'TABLE', [CountryRegion], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ISO standard code for countries and regions.', N'SCHEMA', [Person], N'TABLE', [CountryRegion], N'COLUMN', [CountryRegionCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Country or region name.', N'SCHEMA', [Person], N'TABLE', [CountryRegion], N'COLUMN', [Name];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Person], N'TABLE', [CountryRegion], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index.', N'SCHEMA', [Person], N'TABLE', [CountryRegion], N'INDEX', [AK_CountryRegion_Name];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Person], N'TABLE', [CountryRegion], N'CONSTRAINT', [PK_CountryRegion_CountryRegionCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Person], N'TABLE', [CountryRegion], N'CONSTRAINT', [DF_CountryRegion_ModifiedDate];