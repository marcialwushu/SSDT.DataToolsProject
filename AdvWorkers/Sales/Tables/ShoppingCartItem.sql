CREATE TABLE [Sales].[ShoppingCartItem](
    [ShoppingCartItemID] [int] IDENTITY (1, 1) NOT NULL,
    [ShoppingCartID] [nvarchar](50) NOT NULL,
    [Quantity] [int] NOT NULL CONSTRAINT [DF_ShoppingCartItem_Quantity] DEFAULT (1),
    [ProductID] [int] NOT NULL,
    [DateCreated] [datetime] NOT NULL CONSTRAINT [DF_ShoppingCartItem_DateCreated] DEFAULT (GETDATE()), 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_ShoppingCartItem_ModifiedDate] DEFAULT (GETDATE()), 
    CONSTRAINT [CK_ShoppingCartItem_Quantity] CHECK ([Quantity] >= 1) 
) ON [PRIMARY];
GO
ALTER TABLE [Sales].[ShoppingCartItem] ADD 
    CONSTRAINT [FK_ShoppingCartItem_Product_ProductID] FOREIGN KEY 
    (
        [ProductID]
    ) REFERENCES [Production].[Product](
        [ProductID]
    );
GO
ALTER TABLE [Sales].[ShoppingCartItem] WITH CHECK ADD 
    CONSTRAINT [PK_ShoppingCartItem_ShoppingCartItemID] PRIMARY KEY CLUSTERED 
    (
        [ShoppingCartItemID]
    )  ON [PRIMARY];
GO
CREATE INDEX [IX_ShoppingCartItem_ShoppingCartID_ProductID] ON [Sales].[ShoppingCartItem]([ShoppingCartID], [ProductID]) ON [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Contains online customer orders until the order is submitted or cancelled.', N'SCHEMA', [Sales], N'TABLE', [ShoppingCartItem], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key for ShoppingCartItem records.', N'SCHEMA', [Sales], N'TABLE', [ShoppingCartItem], N'COLUMN', [ShoppingCartItemID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Shopping cart identification number.', N'SCHEMA', [Sales], N'TABLE', [ShoppingCartItem], N'COLUMN', [ShoppingCartID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Product quantity ordered.', N'SCHEMA', [Sales], N'TABLE', [ShoppingCartItem], N'COLUMN', [Quantity];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Product ordered. Foreign key to Product.ProductID.', N'SCHEMA', [Sales], N'TABLE', [ShoppingCartItem], N'COLUMN', [ProductID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date the time the record was created.', N'SCHEMA', [Sales], N'TABLE', [ShoppingCartItem], N'COLUMN', [DateCreated];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Sales], N'TABLE', [ShoppingCartItem], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index.', N'SCHEMA', [Sales], N'TABLE', [ShoppingCartItem], N'INDEX', [IX_ShoppingCartItem_ShoppingCartID_ProductID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Sales], N'TABLE', [ShoppingCartItem], N'CONSTRAINT', [PK_ShoppingCartItem_ShoppingCartItemID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Product.ProductID.', N'SCHEMA', [Sales], N'TABLE', [ShoppingCartItem], N'CONSTRAINT', [FK_ShoppingCartItem_Product_ProductID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 1', N'SCHEMA', [Sales], N'TABLE', [ShoppingCartItem], N'CONSTRAINT', [DF_ShoppingCartItem_Quantity];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Sales], N'TABLE', [ShoppingCartItem], N'CONSTRAINT', [DF_ShoppingCartItem_DateCreated];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Sales], N'TABLE', [ShoppingCartItem], N'CONSTRAINT', [DF_ShoppingCartItem_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [Quantity] >= (1)', N'SCHEMA', [Sales], N'TABLE', [ShoppingCartItem], N'CONSTRAINT', [CK_ShoppingCartItem_Quantity];