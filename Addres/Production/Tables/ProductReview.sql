CREATE TABLE [Production].[ProductReview](
    [ProductReviewID] [int] IDENTITY (1, 1) NOT NULL,
    [ProductID] [int] NOT NULL,
    [ReviewerName] [Name] NOT NULL,
    [ReviewDate] [datetime] NOT NULL CONSTRAINT [DF_ProductReview_ReviewDate] DEFAULT (GETDATE()),
    [EmailAddress] [nvarchar](50) NOT NULL,
    [Rating] [int] NOT NULL,
    [Comments] [nvarchar](3850), 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_ProductReview_ModifiedDate] DEFAULT (GETDATE()), 
    CONSTRAINT [CK_ProductReview_Rating] CHECK ([Rating] BETWEEN 1 AND 5), 
) ON [PRIMARY];
GO
ALTER TABLE [Production].[ProductReview] ADD 
    CONSTRAINT [FK_ProductReview_Product_ProductID] FOREIGN KEY 
    (
        [ProductID]
    ) REFERENCES [Production].[Product](
        [ProductID]
    );
GO
ALTER TABLE [Production].[ProductReview] WITH CHECK ADD 
    CONSTRAINT [PK_ProductReview_ProductReviewID] PRIMARY KEY CLUSTERED 
    (
        [ProductReviewID]
    )  ON [PRIMARY];
GO
CREATE NONCLUSTERED INDEX [IX_ProductReview_ProductID_Name] ON [Production].[ProductReview]([ProductID], [ReviewerName]) INCLUDE ([Comments]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Customer reviews of products they have purchased.', N'SCHEMA', [Production], N'TABLE', [ProductReview], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key for ProductReview records.', N'SCHEMA', [Production], N'TABLE', [ProductReview], N'COLUMN', [ProductReviewID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Product identification number. Foreign key to Product.ProductID.', N'SCHEMA', [Production], N'TABLE', [ProductReview], N'COLUMN', [ProductID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Name of the reviewer.', N'SCHEMA', [Production], N'TABLE', [ProductReview], N'COLUMN', [ReviewerName];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date review was submitted.', N'SCHEMA', [Production], N'TABLE', [ProductReview], N'COLUMN', [ReviewDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Reviewer''s e-mail address.', N'SCHEMA', [Production], N'TABLE', [ProductReview], N'COLUMN', [EmailAddress];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Product rating given by the reviewer. Scale is 1 to 5 with 5 as the highest rating.', N'SCHEMA', [Production], N'TABLE', [ProductReview], N'COLUMN', [Rating];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Reviewer''s comments', N'SCHEMA', [Production], N'TABLE', [ProductReview], N'COLUMN', [Comments];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Production], N'TABLE', [ProductReview], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index.', N'SCHEMA', [Production], N'TABLE', [ProductReview], N'INDEX', [IX_ProductReview_ProductID_Name];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Production], N'TABLE', [ProductReview], N'CONSTRAINT', [PK_ProductReview_ProductReviewID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Product.ProductID.', N'SCHEMA', [Production], N'TABLE', [ProductReview], N'CONSTRAINT', [FK_ProductReview_Product_ProductID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Production], N'TABLE', [ProductReview], N'CONSTRAINT', [DF_ProductReview_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Production], N'TABLE', [ProductReview], N'CONSTRAINT', [DF_ProductReview_ReviewDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [Rating] BETWEEN (1) AND (5)', N'SCHEMA', [Production], N'TABLE', [ProductReview], N'CONSTRAINT', [CK_ProductReview_Rating];