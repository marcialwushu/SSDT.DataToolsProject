-- Database
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'AdventureWorks 2016 Sample OLTP Database', NULL, NULL, NULL, NULL;
GO
-- Files and Filegroups
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary filegroup for the AdventureWorks 2016 sample database.', N'FILEGROUP', [PRIMARY];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Person], N'TABLE', [Address], N'INDEX', [PK_Address_AddressID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Person], N'TABLE', [AddressType], N'INDEX', [PK_AddressType_AddressTypeID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [dbo], N'TABLE', [AWBuildVersion], N'INDEX', [PK_AWBuildVersion_SystemInformationID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index created by a primary key constraint.', N'SCHEMA', [Production], N'TABLE', [BillOfMaterials], N'INDEX', [PK_BillOfMaterials_BillOfMaterialsID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Person], N'TABLE', [BusinessEntity], N'INDEX', [PK_BusinessEntity_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Person], N'TABLE', [BusinessEntityAddress], N'INDEX', [PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressTypeID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Person], N'TABLE', [BusinessEntityContact], N'INDEX', [PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Person], N'TABLE', [ContactType], N'INDEX', [PK_ContactType_ContactTypeID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Person], N'TABLE', [CountryRegion], N'INDEX', [PK_CountryRegion_CountryRegionCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Sales], N'TABLE', [CountryRegionCurrency], N'INDEX', [PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Sales], N'TABLE', [CreditCard], N'INDEX', [PK_CreditCard_CreditCardID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Production], N'TABLE', [Culture], N'INDEX', [PK_Culture_CultureID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Sales], N'TABLE', [Currency], N'INDEX', [PK_Currency_CurrencyCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Sales], N'TABLE', [CurrencyRate], N'INDEX', [PK_CurrencyRate_CurrencyRateID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Sales], N'TABLE', [Customer], N'INDEX', [PK_Customer_CustomerID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index created by a primary key constraint.', N'SCHEMA', [dbo], N'TABLE', [DatabaseLog], N'INDEX', [PK_DatabaseLog_DatabaseLogID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [HumanResources], N'TABLE', [Department], N'INDEX', [PK_Department_DepartmentID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Production], N'TABLE', [Document], N'INDEX', [PK_Document_DocumentNode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Person], N'TABLE', [EmailAddress], N'INDEX', [PK_EmailAddress_BusinessEntityID_EmailAddressID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [HumanResources], N'TABLE', [Employee], N'INDEX', [PK_Employee_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [HumanResources], N'TABLE', [EmployeeDepartmentHistory], N'INDEX', [PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_DepartmentID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [HumanResources], N'TABLE', [EmployeePayHistory], N'INDEX', [PK_EmployeePayHistory_BusinessEntityID_RateChangeDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [dbo], N'TABLE', [ErrorLog], N'INDEX', [PK_ErrorLog_ErrorLogID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Production], N'TABLE', [Illustration], N'INDEX', [PK_Illustration_IllustrationID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [HumanResources], N'TABLE', [JobCandidate], N'INDEX', [PK_JobCandidate_JobCandidateID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Production], N'TABLE', [Location], N'INDEX', [PK_Location_LocationID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Person], N'TABLE', [Password], N'INDEX', [PK_Password_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Person], N'TABLE', [Person], N'INDEX', [PK_Person_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Sales], N'TABLE', [PersonCreditCard], N'INDEX', [PK_PersonCreditCard_BusinessEntityID_CreditCardID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Person], N'TABLE', [PersonPhone], N'INDEX', [PK_PersonPhone_BusinessEntityID_PhoneNumber_PhoneNumberTypeID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Person], N'TABLE', [PhoneNumberType], N'INDEX', [PK_PhoneNumberType_PhoneNumberTypeID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Production], N'TABLE', [Product], N'INDEX', [PK_Product_ProductID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Production], N'TABLE', [ProductCategory], N'INDEX', [PK_ProductCategory_ProductCategoryID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Production], N'TABLE', [ProductCostHistory], N'INDEX', [PK_ProductCostHistory_ProductID_StartDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Production], N'TABLE', [ProductDescription], N'INDEX', [PK_ProductDescription_ProductDescriptionID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Production], N'TABLE', [ProductDocument], N'INDEX', [PK_ProductDocument_ProductID_DocumentNode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Production], N'TABLE', [ProductInventory], N'INDEX', [PK_ProductInventory_ProductID_LocationID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Production], N'TABLE', [ProductListPriceHistory], N'INDEX', [PK_ProductListPriceHistory_ProductID_StartDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Production], N'TABLE', [ProductModel], N'INDEX', [PK_ProductModel_ProductModelID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Production], N'TABLE', [ProductModelIllustration], N'INDEX', [PK_ProductModelIllustration_ProductModelID_IllustrationID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Production], N'TABLE', [ProductModelProductDescriptionCulture], N'INDEX', [PK_ProductModelProductDescriptionCulture_ProductModelID_ProductDescriptionID_CultureID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Production], N'TABLE', [ProductPhoto], N'INDEX', [PK_ProductPhoto_ProductPhotoID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Nonclustered index created by a primary key constraint.', N'SCHEMA', [Production], N'TABLE', [ProductProductPhoto], N'INDEX', [PK_ProductProductPhoto_ProductID_ProductPhotoID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Production], N'TABLE', [ProductReview], N'INDEX', [PK_ProductReview_ProductReviewID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Production], N'TABLE', [ProductSubcategory], N'INDEX', [PK_ProductSubcategory_ProductSubcategoryID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Purchasing], N'TABLE', [ProductVendor], N'INDEX', [PK_ProductVendor_ProductID_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderDetail], N'INDEX', [PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'INDEX', [PK_PurchaseOrderHeader_PurchaseOrderID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderDetail], N'INDEX', [PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'INDEX', [PK_SalesOrderHeader_SalesOrderID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeaderSalesReason], N'INDEX', [PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Sales], N'TABLE', [SalesPerson], N'INDEX', [PK_SalesPerson_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Sales], N'TABLE', [SalesPersonQuotaHistory], N'INDEX', [PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Sales], N'TABLE', [SalesReason], N'INDEX', [PK_SalesReason_SalesReasonID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Sales], N'TABLE', [SalesTaxRate], N'INDEX', [PK_SalesTaxRate_SalesTaxRateID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Sales], N'TABLE', [SalesTerritory], N'INDEX', [PK_SalesTerritory_TerritoryID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Sales], N'TABLE', [SalesTerritoryHistory], N'INDEX', [PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Production], N'TABLE', [ScrapReason], N'INDEX', [PK_ScrapReason_ScrapReasonID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [HumanResources], N'TABLE', [Shift], N'INDEX', [PK_Shift_ShiftID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Purchasing], N'TABLE', [ShipMethod], N'INDEX', [PK_ShipMethod_ShipMethodID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Sales], N'TABLE', [ShoppingCartItem], N'INDEX', [PK_ShoppingCartItem_ShoppingCartItemID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Sales], N'TABLE', [SpecialOffer], N'INDEX', [PK_SpecialOffer_SpecialOfferID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Sales], N'TABLE', [SpecialOfferProduct], N'INDEX', [PK_SpecialOfferProduct_SpecialOfferID_ProductID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Person], N'TABLE', [StateProvince], N'INDEX', [PK_StateProvince_StateProvinceID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Sales], N'TABLE', [Store], N'INDEX', [PK_Store_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Production], N'TABLE', [TransactionHistory], N'INDEX', [PK_TransactionHistory_TransactionID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Production], N'TABLE', [TransactionHistoryArchive], N'INDEX', [PK_TransactionHistoryArchive_TransactionID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Production], N'TABLE', [UnitMeasure], N'INDEX', [PK_UnitMeasure_UnitMeasureCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Purchasing], N'TABLE', [Vendor], N'INDEX', [PK_Vendor_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Production], N'TABLE', [WorkOrder], N'INDEX', [PK_WorkOrder_WorkOrderID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Clustered index created by a primary key constraint.', N'SCHEMA', [Production], N'TABLE', [WorkOrderRouting], N'INDEX', [PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Product.ComponentID.', N'SCHEMA', [Production], N'TABLE', [BillOfMaterials], N'CONSTRAINT', [FK_BillOfMaterials_Product_ComponentID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing UnitMeasure.UnitMeasureCode.', N'SCHEMA', [Production], N'TABLE', [BillOfMaterials], N'CONSTRAINT', [FK_BillOfMaterials_UnitMeasure_UnitMeasureCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing AddressType.AddressTypeID.', N'SCHEMA', [Person], N'TABLE', [BusinessEntityAddress], N'CONSTRAINT', [FK_BusinessEntityAddress_AddressType_AddressTypeID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing BusinessEntity.BusinessEntityID.', N'SCHEMA', [Person], N'TABLE', [BusinessEntityAddress], N'CONSTRAINT', [FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing ContactType.ContactTypeID.', N'SCHEMA', [Person], N'TABLE', [BusinessEntityContact], N'CONSTRAINT', [FK_BusinessEntityContact_ContactType_ContactTypeID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing BusinessEntity.BusinessEntityID.', N'SCHEMA', [Person], N'TABLE', [BusinessEntityContact], N'CONSTRAINT', [FK_BusinessEntityContact_BusinessEntity_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Currency.CurrencyCode.', N'SCHEMA', [Sales], N'TABLE', [CountryRegionCurrency], N'CONSTRAINT', [FK_CountryRegionCurrency_Currency_CurrencyCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Currency.ToCurrencyCode.', N'SCHEMA', [Sales], N'TABLE', [CurrencyRate], N'CONSTRAINT', [FK_CurrencyRate_Currency_ToCurrencyCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Store.BusinessEntityID.', N'SCHEMA', [Sales], N'TABLE', [Customer], N'CONSTRAINT', [FK_Customer_Store_StoreID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing SalesTerritory.TerritoryID.', N'SCHEMA', [Sales], N'TABLE', [Customer], N'CONSTRAINT', [FK_Customer_SalesTerritory_TerritoryID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Shift.ShiftID', N'SCHEMA', [HumanResources], N'TABLE', [EmployeeDepartmentHistory], N'CONSTRAINT', [FK_EmployeeDepartmentHistory_Shift_ShiftID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Employee.EmployeeID.', N'SCHEMA', [HumanResources], N'TABLE', [EmployeeDepartmentHistory], N'CONSTRAINT', [FK_EmployeeDepartmentHistory_Employee_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing CreditCard.CreditCardID.', N'SCHEMA', [Sales], N'TABLE', [PersonCreditCard], N'CONSTRAINT', [FK_PersonCreditCard_CreditCard_CreditCardID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing PhoneNumberType.PhoneNumberTypeID.', N'SCHEMA', [Person], N'TABLE', [PersonPhone], N'CONSTRAINT', [FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing ProductModel.ProductModelID.', N'SCHEMA', [Production], N'TABLE', [Product], N'CONSTRAINT', [FK_Product_ProductModel_ProductModelID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing ProductSubcategory.ProductSubcategoryID.', N'SCHEMA', [Production], N'TABLE', [Product], N'CONSTRAINT', [FK_Product_ProductSubcategory_ProductSubcategoryID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing UnitMeasure.UnitMeasureCode.', N'SCHEMA', [Production], N'TABLE', [Product], N'CONSTRAINT', [FK_Product_UnitMeasure_WeightUnitMeasureCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Document.DocumentNode.', N'SCHEMA', [Production], N'TABLE', [ProductDocument], N'CONSTRAINT', [FK_ProductDocument_Document_DocumentNode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Product.ProductID.', N'SCHEMA', [Production], N'TABLE', [ProductInventory], N'CONSTRAINT', [FK_ProductInventory_Product_ProductID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Illustration.IllustrationID.', N'SCHEMA', [Production], N'TABLE', [ProductModelIllustration], N'CONSTRAINT', [FK_ProductModelIllustration_Illustration_IllustrationID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Culture.CultureID.', N'SCHEMA', [Production], N'TABLE', [ProductModelProductDescriptionCulture], N'CONSTRAINT', [FK_ProductModelProductDescriptionCulture_Culture_CultureID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing ProductModel.ProductModelID.', N'SCHEMA', [Production], N'TABLE', [ProductModelProductDescriptionCulture], N'CONSTRAINT', [FK_ProductModelProductDescriptionCulture_ProductModel_ProductModelID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing ProductPhoto.ProductPhotoID.', N'SCHEMA', [Production], N'TABLE', [ProductProductPhoto], N'CONSTRAINT', [FK_ProductProductPhoto_ProductPhoto_ProductPhotoID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing UnitMeasure.UnitMeasureCode.', N'SCHEMA', [Purchasing], N'TABLE', [ProductVendor], N'CONSTRAINT', [FK_ProductVendor_UnitMeasure_UnitMeasureCode];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Vendor.BusinessEntityID.', N'SCHEMA', [Purchasing], N'TABLE', [ProductVendor], N'CONSTRAINT', [FK_ProductVendor_Vendor_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing PurchaseOrderHeader.PurchaseOrderID.', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderDetail], N'CONSTRAINT', [FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing ShipMethod.ShipMethodID.', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'CONSTRAINT', [FK_PurchaseOrderHeader_ShipMethod_ShipMethodID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Vendor.VendorID.', N'SCHEMA', [Purchasing], N'TABLE', [PurchaseOrderHeader], N'CONSTRAINT', [FK_PurchaseOrderHeader_Vendor_VendorID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing SpecialOfferProduct.SpecialOfferIDProductID.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderDetail], N'CONSTRAINT', [FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Address.AddressID.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'CONSTRAINT', [FK_SalesOrderHeader_Address_ShipToAddressID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing CreditCard.CreditCardID.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'CONSTRAINT', [FK_SalesOrderHeader_CreditCard_CreditCardID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing CurrencyRate.CurrencyRateID.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'CONSTRAINT', [FK_SalesOrderHeader_CurrencyRate_CurrencyRateID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing Customer.CustomerID.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'CONSTRAINT', [FK_SalesOrderHeader_Customer_CustomerID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing SalesPerson.SalesPersonID.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'CONSTRAINT', [FK_SalesOrderHeader_SalesPerson_SalesPersonID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing SalesTerritory.TerritoryID.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'CONSTRAINT', [FK_SalesOrderHeader_SalesTerritory_TerritoryID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing ShipMethod.ShipMethodID.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeader], N'CONSTRAINT', [FK_SalesOrderHeader_ShipMethod_ShipMethodID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing SalesOrderHeader.SalesOrderID.', N'SCHEMA', [Sales], N'TABLE', [SalesOrderHeaderSalesReason], N'CONSTRAINT', [FK_SalesOrderHeaderSalesReason_SalesOrderHeader_SalesOrderID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing SalesTerritory.TerritoryID.', N'SCHEMA', [Sales], N'TABLE', [SalesPerson], N'CONSTRAINT', [FK_SalesPerson_SalesTerritory_TerritoryID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing SalesTerritory.TerritoryID.', N'SCHEMA', [Sales], N'TABLE', [SalesTerritoryHistory], N'CONSTRAINT', [FK_SalesTerritoryHistory_SalesTerritory_TerritoryID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing SpecialOffer.SpecialOfferID.', N'SCHEMA', [Sales], N'TABLE', [SpecialOfferProduct], N'CONSTRAINT', [FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing SalesTerritory.TerritoryID.', N'SCHEMA', [Person], N'TABLE', [StateProvince], N'CONSTRAINT', [FK_StateProvince_SalesTerritory_TerritoryID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing SalesPerson.SalesPersonID', N'SCHEMA', [Sales], N'TABLE', [Store], N'CONSTRAINT', [FK_Store_SalesPerson_SalesPersonID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing ScrapReason.ScrapReasonID.', N'SCHEMA', [Production], N'TABLE', [WorkOrder], N'CONSTRAINT', [FK_WorkOrder_ScrapReason_ScrapReasonID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing WorkOrder.WorkOrderID.', N'SCHEMA', [Production], N'TABLE', [WorkOrderRouting], N'CONSTRAINT', [FK_WorkOrderRouting_WorkOrder_WorkOrderID];