CREATE TABLE [Purchasing].[Vendor](
    [BusinessEntityID] [int] NOT NULL,
    [AccountNumber] [AccountNumber] NOT NULL,
    [Name] [Name] NOT NULL,
    [CreditRating] [tinyint] NOT NULL,
    [PreferredVendorStatus] [Flag] NOT NULL CONSTRAINT [DF_Vendor_PreferredVendorStatus] DEFAULT (1), 
    [ActiveFlag] [Flag] NOT NULL CONSTRAINT [DF_Vendor_ActiveFlag] DEFAULT (1),
    [PurchasingWebServiceURL] [nvarchar](1024) NULL, 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Vendor_ModifiedDate] DEFAULT (GETDATE()),
    CONSTRAINT [CK_Vendor_CreditRating] CHECK ([CreditRating] BETWEEN 1 AND 5)
) ON [PRIMARY];
GO
ALTER TABLE [Purchasing].[Vendor] ADD 
	CONSTRAINT [FK_Vendor_BusinessEntity_BusinessEntityID] FOREIGN KEY
	(
		[BusinessEntityID]
	) REFERENCES [Person].[BusinessEntity](
		[BusinessEntityID]
	);
GO
ALTER TABLE [Purchasing].[Vendor] WITH CHECK ADD 
    CONSTRAINT [PK_Vendor_BusinessEntityID] PRIMARY KEY CLUSTERED 
    (
        [BusinessEntityID]
    )  ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_Vendor_AccountNumber] ON [Purchasing].[Vendor]([AccountNumber]) ON [PRIMARY];
GO
CREATE TRIGGER [Purchasing].[dVendor] ON [Purchasing].[Vendor] 
INSTEAD OF DELETE NOT FOR REPLICATION AS 
BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    BEGIN TRY
        DECLARE @DeleteCount int;

        SELECT @DeleteCount = COUNT(*) FROM deleted;
        IF @DeleteCount > 0 
        BEGIN
            RAISERROR
                (N'Vendors cannot be deleted. They can only be marked as not active.', -- Message
                10, -- Severity.
                1); -- State.

        -- Rollback any active or uncommittable transactions
            IF @@TRANCOUNT > 0
            BEGIN
                ROLLBACK TRANSACTION;
            END
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
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Companies from whom Adventure Works Cycles purchases parts or other goods.', N'SCHEMA', [Purchasing], N'TABLE', [Vendor], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key for Vendor records.  Foreign key to BusinessEntity.BusinessEntityID', N'SCHEMA', [Purchasing], N'TABLE', [Vendor], N'COLUMN', [BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Vendor account (identification) number.', N'SCHEMA', [Purchasing], N'TABLE', [Vendor], N'COLUMN', [AccountNumber];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Company name.', N'SCHEMA', [Purchasing], N'TABLE', [Vendor], N'COLUMN', [Name];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'1 = Superior, 2 = Excellent, 3 = Above average, 4 = Average, 5 = Below average', N'SCHEMA', [Purchasing], N'TABLE', [Vendor], N'COLUMN', [CreditRating];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'0 = Do not use if another vendor is available. 1 = Preferred over other vendors supplying the same product.', N'SCHEMA', [Purchasing], N'TABLE', [Vendor], N'COLUMN', [PreferredVendorStatus];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'0 = Vendor no longer used. 1 = Vendor is actively used.', N'SCHEMA', [Purchasing], N'TABLE', [Vendor], N'COLUMN', [ActiveFlag];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Vendor URL.', N'SCHEMA', [Purchasing], N'TABLE', [Vendor], N'COLUMN', [PurchasingWebServiceURL];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Purchasing], N'TABLE', [Vendor], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'INSTEAD OF DELETE trigger which keeps Vendors from being deleted.', N'SCHEMA', [Purchasing], N'TABLE', [Vendor], N'TRIGGER', [dVendor];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index.', N'SCHEMA', [Purchasing], N'TABLE', [Vendor], N'INDEX', [AK_Vendor_AccountNumber];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Purchasing], N'TABLE', [Vendor], N'CONSTRAINT', [PK_Vendor_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing BusinessEntity.BusinessEntityID', N'SCHEMA', [Purchasing], N'TABLE', [Vendor], N'CONSTRAINT', [FK_Vendor_BusinessEntity_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 1 (TRUE)', N'SCHEMA', [Purchasing], N'TABLE', [Vendor], N'CONSTRAINT', [DF_Vendor_ActiveFlag];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 1 (TRUE)', N'SCHEMA', [Purchasing], N'TABLE', [Vendor], N'CONSTRAINT', [DF_Vendor_PreferredVendorStatus];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Purchasing], N'TABLE', [Vendor], N'CONSTRAINT', [DF_Vendor_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [CreditRating] BETWEEN (1) AND (5)', N'SCHEMA', [Purchasing], N'TABLE', [Vendor], N'CONSTRAINT', [CK_Vendor_CreditRating];