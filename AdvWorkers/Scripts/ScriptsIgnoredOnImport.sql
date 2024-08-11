
PRINT CONVERT(varchar(1000), @@VERSION);
GO

PRINT '';
GO

PRINT 'Started - ' + CONVERT(varchar, GETDATE(), 121);
GO

USE [master];
GO

-- ****************************************
-- Drop Database
-- ****************************************
PRINT '';
GO

PRINT '*** Dropping Database';
GO

IF @@ERROR = 3702 
    RAISERROR('$(DatabaseName) database cannot be dropped because there are still other open connections', 127, 127) WITH NOWAIT, LOG;
GO

-- ****************************************
-- Create Database
-- ****************************************
PRINT '';
GO

PRINT '*** Creating Database';
GO

PRINT '';
GO

PRINT '*** Checking for $(DatabaseName) Database';
GO

/* CHECK FOR DATABASE IF IT DOESN'T EXISTS, DO NOT RUN THE REST OF THE SCRIPT */
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.databases WHERE name = N'$(DatabaseName)')
BEGIN
PRINT '*******************************************************************************************************************************************************************'
+char(10)+'********$(DatabaseName) Database does not exist.  Make sure that the script is being run in SQLCMD mode and that the variables have been correctly set.*********'
+char(10)+'*******************************************************************************************************************************************************************';
SET NOEXEC ON;
END
GO

ALTER DATABASE $(DatabaseName) 
SET RECOVERY SIMPLE, 
    ANSI_NULLS ON, 
    ANSI_PADDING ON, 
    ANSI_WARNINGS ON, 
    ARITHABORT ON, 
    CONCAT_NULL_YIELDS_NULL ON, 
    QUOTED_IDENTIFIER ON, 
    NUMERIC_ROUNDABORT OFF, 
    PAGE_VERIFY CHECKSUM, 
    ALLOW_SNAPSHOT_ISOLATION OFF;
GO

-- ****************************************
-- Create DDL Trigger for Database
-- ****************************************
PRINT '';
GO

PRINT '*** Creating DDL Trigger for Database';
GO

SET QUOTED_IDENTIFIER ON;
GO

-- ****************************************
-- Create Error Log objects
-- ****************************************
PRINT '';
GO

PRINT '*** Creating Error Log objects';
GO

-- ****************************************
-- Create Data Types
-- ****************************************
PRINT '';
GO

PRINT '*** Creating Data Types';
GO

-- ******************************************************
-- Add pre-table database functions.
-- ******************************************************
PRINT '';
GO

PRINT '*** Creating Pre-Table Database Functions';
GO

-- ******************************************************
-- Create database schemas
-- ******************************************************
PRINT '';
GO

PRINT '*** Creating Database Schemas';
GO

-- ****************************************
-- Create XML schemas
-- ****************************************
PRINT '';
GO

PRINT '*** Creating XML Schemas';
GO

-- Create AdditionalContactInfo schema
PRINT '';
GO

PRINT 'Create AdditionalContactInfo schema';
GO

ALTER XML SCHEMA COLLECTION [Person].[AdditionalContactInfoSchemaCollection] ADD 
'<?xml version="1.0" encoding="UTF-8"?>
<xsd:schema targetNamespace="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactRecord"
    elementFormDefault="qualified"
    xmlns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactRecord"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema" >

    <xsd:element name="ContactRecord" >
        <xsd:complexType mixed="true" >
            <xsd:choice minOccurs="0" maxOccurs="unbounded" >
                <xsd:any processContents="strict"  
                    namespace="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes" />
            </xsd:choice>
            <xsd:attribute name="date" type="xsd:date" />
        </xsd:complexType>
    </xsd:element>
</xsd:schema>';
GO

ALTER XML SCHEMA COLLECTION [Person].[AdditionalContactInfoSchemaCollection] ADD 
'<?xml version="1.0" encoding="UTF-8"?>
<xsd:schema targetNamespace="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"
    xmlns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes" 
    elementFormDefault="qualified"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema" >

    <xsd:complexType name="specialInstructionsType" mixed="true">
        <xsd:sequence>
            <xsd:any processContents="strict" 
                namespace = "##targetNamespace"
                minOccurs="0" maxOccurs="unbounded" />
        </xsd:sequence>
    </xsd:complexType>

    <xsd:complexType name="phoneNumberType">
        <xsd:sequence>
            <xsd:element name="number" >
                <xsd:simpleType>
                    <xsd:restriction base="xsd:string">
                        <xsd:pattern value="[0-9\(\)\-]*"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="SpecialInstructions" minOccurs="0" type="specialInstructionsType" />
        </xsd:sequence>
    </xsd:complexType>

    <xsd:complexType name="eMailType">
        <xsd:sequence>
            <xsd:element name="eMailAddress" type="xsd:string" />
            <xsd:element name="SpecialInstructions" minOccurs="0" type="specialInstructionsType" />
        </xsd:sequence>
    </xsd:complexType>

    <xsd:complexType name="addressType">
        <xsd:sequence>
            <xsd:element name="Street" type="xsd:string" minOccurs="1" maxOccurs="2" />
            <xsd:element name="City" type="xsd:string" minOccurs="1" maxOccurs="1" />
            <xsd:element name="StateProvince" type="xsd:string" minOccurs="1" maxOccurs="1" />
            <xsd:element name="PostalCode" type="xsd:string" minOccurs="0" maxOccurs="1" />
            <xsd:element name="CountryRegion" type="xsd:string" minOccurs="1" maxOccurs="1" />
            <xsd:element name="SpecialInstructions" type="specialInstructionsType" minOccurs="0"/>
        </xsd:sequence>
    </xsd:complexType>

    <xsd:element name="telephoneNumber"            type="phoneNumberType" />
    <xsd:element name="mobile"                     type="phoneNumberType" />
    <xsd:element name="pager"                      type="phoneNumberType" />
    <xsd:element name="facsimileTelephoneNumber"   type="phoneNumberType" />
    <xsd:element name="telexNumber"                type="phoneNumberType" />
    <xsd:element name="internationaliSDNNumber"    type="phoneNumberType" />
    <xsd:element name="eMail"                      type="eMailType" />
    <xsd:element name="homePostalAddress"          type="addressType" />
    <xsd:element name="physicalDeliveryOfficeName" type="addressType" />
    <xsd:element name="registeredAddress"          type="addressType" /> 
</xsd:schema>';
GO

-- Create Individual survey schema.
PRINT '';
GO

PRINT 'Create Individual survey schema';
GO

-- Create resume schema.
PRINT '';
GO

PRINT 'Create Resume schema';
GO

-- Create Product catalog description schema.
PRINT '';
GO

PRINT 'Create Product catalog description schema';
GO

ALTER XML SCHEMA COLLECTION [Production].[ProductDescriptionSchemaCollection] ADD 
'<?xml version="1.0" encoding="UTF-8"?>
<xs:schema targetNamespace="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription" 
    xmlns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription" 
    elementFormDefault="qualified" 
    xmlns:mstns="http://tempuri.org/XMLSchema.xsd" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain" >

    <xs:import 
        namespace="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain" />

    <xs:element name="ProductDescription" type="ProductDescription" />
        <xs:complexType name="ProductDescription">
            <xs:annotation>
                <xs:documentation>Product description has a summary blurb, if its manufactured elsewhere it 
                includes a link to the manufacturers site for this component.
                Then it has optional zero or more sequences of features, pictures, categories
                and technical specifications.
                </xs:documentation>
            </xs:annotation>
            <xs:sequence>
                <xs:element name="Summary" type="Summary" minOccurs="0" />
                <xs:element name="Manufacturer" type="Manufacturer" minOccurs="0" />
                <xs:element name="Features" type="Features" minOccurs="0" maxOccurs="unbounded" />
                <xs:element name="Picture" type="Picture" minOccurs="0" maxOccurs="unbounded" />
                <xs:element name="Category" type="Category" minOccurs="0" maxOccurs="unbounded" />
                <xs:element name="Specifications" type="Specifications" minOccurs="0" maxOccurs="unbounded" />
            </xs:sequence>
            <xs:attribute name="ProductModelID" type="xs:string" />
            <xs:attribute name="ProductModelName" type="xs:string" />
        </xs:complexType>
  
        <xs:complexType name="Summary" mixed="true" >
            <xs:sequence>
                <xs:any processContents="skip" namespace="http://www.w3.org/1999/xhtml" minOccurs="0" maxOccurs="unbounded" />
            </xs:sequence>
        </xs:complexType>
        
        <xs:complexType name="Manufacturer">
            <xs:sequence>
                <xs:element name="Name" type="xs:string" minOccurs="0" />
                <xs:element name="CopyrightURL" type="xs:string" minOccurs="0" />
                <xs:element name="Copyright" type="xs:string" minOccurs="0" />
                <xs:element name="ProductURL" type="xs:string" minOccurs="0" />
            </xs:sequence>
        </xs:complexType>
  
        <xs:complexType name="Picture">
            <xs:annotation>
                <xs:documentation>Pictures of the component, some standard sizes are "Large" for zoom in, "Small" for a normal web page and "Thumbnail" for product listing pages.</xs:documentation>
            </xs:annotation>
            <xs:sequence>
                <xs:element name="Name" type="xs:string" minOccurs="0" />
                <xs:element name="Angle" type="xs:string" minOccurs="0" />
                <xs:element name="Size" type="xs:string" minOccurs="0" />
                <xs:element name="ProductPhotoID" type="xs:integer" minOccurs="0" />
            </xs:sequence>
        </xs:complexType>

        <xs:annotation>
            <xs:documentation>Features of the component that are more "sales" oriented.</xs:documentation>
        </xs:annotation>

        <xs:complexType name="Features" mixed="true"  >
            <xs:sequence>
                <xs:element ref="wm:Warranty"  />
                <xs:element ref="wm:Maintenance"  />
                <xs:any processContents="skip"  namespace="##other" minOccurs="0" maxOccurs="unbounded" />
            </xs:sequence>
        </xs:complexType>

        <xs:complexType name="Specifications" mixed="true">
            <xs:annotation>
                <xs:documentation>A single technical aspect of the component.</xs:documentation>
            </xs:annotation>
            <xs:sequence>
                <xs:any processContents="skip" minOccurs="0" maxOccurs="unbounded" />
            </xs:sequence>
        </xs:complexType>

        <xs:complexType name="Category">
            <xs:annotation>
                <xs:documentation>A single categorization element that designates a classification taxonomy and a code within that classification type.  Optional description for default display if needed.</xs:documentation>
            </xs:annotation>
            <xs:sequence>
                <xs:element ref="Taxonomy" />
                <xs:element ref="Code" />
                <xs:element ref="Description" minOccurs="0" />
            </xs:sequence>
        </xs:complexType>

    <xs:element name="Taxonomy" type="xs:string" />
    <xs:element name="Code" type="xs:string" />
    <xs:element name="Description" type="xs:string" />
</xs:schema>';
GO

-- Create Manufacturing instructions schema.
PRINT '';
GO

PRINT 'Create Manufacturing instructions schema';
GO

-- Create Store survey schema.
PRINT '';
GO

PRINT 'Create Store survey schema';
GO

-- ******************************************************
-- Create tables
-- ******************************************************
PRINT '';
GO

PRINT '*** Creating Tables';
GO

-- ******************************************************
-- Load data
-- ******************************************************
PRINT '';
GO

PRINT '*** Loading Data';
GO

PRINT 'Loading [Person].[Address]';
GO

BULK INSERT [Person].[Address] FROM '$(SqlSamplesSourceDataPath)Address.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE = 'char',
    FIELDTERMINATOR= '\t',
    ROWTERMINATOR = '\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Person].[AddressType]';
GO

BULK INSERT [Person].[AddressType] FROM '$(SqlSamplesSourceDataPath)AddressType.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE = 'char',
    FIELDTERMINATOR= '\t',
    ROWTERMINATOR = '\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [dbo].[AWBuildVersion]';
GO

INSERT INTO [dbo].[AWBuildVersion] 
VALUES
( CONVERT(nvarchar(25), SERVERPROPERTY('ProductVersion')), CONVERT(datetime, SERVERPROPERTY('ResourceLastUpdateDateTime')), CONVERT(datetime, GETDATE()) );
GO

PRINT 'Loading [Production].[BillOfMaterials]';
GO

BULK INSERT [Production].[BillOfMaterials] FROM '$(SqlSamplesSourceDataPath)BillOfMaterials.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE = 'char',
    FIELDTERMINATOR= '\t',
    ROWTERMINATOR = '\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Person].[BusinessEntity]';
GO

BULK INSERT [Person].[BusinessEntity] FROM '$(SqlSamplesSourceDataPath)BusinessEntity.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Person].[BusinessEntityAddress]';
GO

BULK INSERT [Person].[BusinessEntityAddress] FROM '$(SqlSamplesSourceDataPath)BusinessEntityAddress.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Person].[BusinessEntityContact]';
GO

BULK INSERT [Person].[BusinessEntityContact] FROM '$(SqlSamplesSourceDataPath)BusinessEntityContact.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Person].[ContactType]';
GO

BULK INSERT [Person].[ContactType] FROM '$(SqlSamplesSourceDataPath)ContactType.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Person].[CountryRegion]';
GO

BULK INSERT [Person].[CountryRegion] FROM '$(SqlSamplesSourceDataPath)CountryRegion.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Sales].[CountryRegionCurrency]';
GO

BULK INSERT [Sales].[CountryRegionCurrency] FROM '$(SqlSamplesSourceDataPath)CountryRegionCurrency.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Sales].[CreditCard]';
GO

BULK INSERT [Sales].[CreditCard] FROM '$(SqlSamplesSourceDataPath)CreditCard.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Production].[Culture]';
GO

BULK INSERT [Production].[Culture] FROM '$(SqlSamplesSourceDataPath)Culture.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Sales].[Currency]';
GO

BULK INSERT [Sales].[Currency] FROM '$(SqlSamplesSourceDataPath)Currency.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Sales].[CurrencyRate]';
GO

BULK INSERT [Sales].[CurrencyRate] FROM '$(SqlSamplesSourceDataPath)CurrencyRate.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Sales].[Customer]';
GO

BULK INSERT [Sales].[Customer] FROM '$(SqlSamplesSourceDataPath)Customer.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [HumanResources].[Department]';
GO

BULK INSERT [HumanResources].[Department] FROM '$(SqlSamplesSourceDataPath)Department.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Production].[Document]';
GO

BULK INSERT [Production].[Document] FROM '$(SqlSamplesSourceDataPath)Document.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK   
);
GO

PRINT 'Loading [Person].[EmailAddress]';
GO

BULK INSERT [Person].[EmailAddress] FROM '$(SqlSamplesSourceDataPath)EmailAddress.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [HumanResources].[Employee]';
GO

BULK INSERT [HumanResources].[Employee] FROM '$(SqlSamplesSourceDataPath)Employee.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [HumanResources].[EmployeeDepartmentHistory]';
GO

BULK INSERT [HumanResources].[EmployeeDepartmentHistory] FROM '$(SqlSamplesSourceDataPath)EmployeeDepartmentHistory.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [HumanResources].[EmployeePayHistory]';
GO

BULK INSERT [HumanResources].[EmployeePayHistory] FROM '$(SqlSamplesSourceDataPath)EmployeePayHistory.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Production].[Illustration]';
GO

BULK INSERT [Production].[Illustration] FROM '$(SqlSamplesSourceDataPath)Illustration.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [HumanResources].[JobCandidate]';
GO

BULK INSERT [HumanResources].[JobCandidate] FROM '$(SqlSamplesSourceDataPath)JobCandidate.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Production].[Location]';
GO

BULK INSERT [Production].[Location] FROM '$(SqlSamplesSourceDataPath)Location.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Person].[Password]';
GO

BULK INSERT [Person].[Password] FROM '$(SqlSamplesSourceDataPath)Password.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Person].[Person]';
GO

BULK INSERT [Person].[Person] FROM '$(SqlSamplesSourceDataPath)Person.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Sales].[PersonCreditCard]';
GO

BULK INSERT [Sales].[PersonCreditCard] FROM '$(SqlSamplesSourceDataPath)PersonCreditCard.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Person].[PersonPhone]';
GO

BULK INSERT [Person].[PersonPhone] FROM '$(SqlSamplesSourceDataPath)PersonPhone.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Person].[PhoneNumberType]';
GO

BULK INSERT [Person].[PhoneNumberType] FROM '$(SqlSamplesSourceDataPath)PhoneNumberType.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Production].[Product]';
GO

BULK INSERT [Production].[Product] FROM '$(SqlSamplesSourceDataPath)Product.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Production].[ProductCategory]';
GO

BULK INSERT [Production].[ProductCategory] FROM '$(SqlSamplesSourceDataPath)ProductCategory.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Production].[ProductCostHistory]';
GO

BULK INSERT [Production].[ProductCostHistory] FROM '$(SqlSamplesSourceDataPath)ProductCostHistory.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Production].[ProductDescription]';
GO

BULK INSERT [Production].[ProductDescription] FROM '$(SqlSamplesSourceDataPath)ProductDescription.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Production].[ProductDocument]';
GO

BULK INSERT [Production].[ProductDocument] FROM '$(SqlSamplesSourceDataPath)ProductDocument.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK   
);
GO

PRINT 'Loading [Production].[ProductInventory]';
GO

BULK INSERT [Production].[ProductInventory] FROM '$(SqlSamplesSourceDataPath)ProductInventory.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Production].[ProductListPriceHistory]';
GO

BULK INSERT [Production].[ProductListPriceHistory] FROM '$(SqlSamplesSourceDataPath)ProductListPriceHistory.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Production].[ProductModel]';
GO

BULK INSERT [Production].[ProductModel] FROM '$(SqlSamplesSourceDataPath)ProductModel.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Production].[ProductModelIllustration]';
GO

BULK INSERT [Production].[ProductModelIllustration] FROM '$(SqlSamplesSourceDataPath)ProductModelIllustration.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Production].[ProductModelProductDescriptionCulture]';
GO

BULK INSERT [Production].[ProductModelProductDescriptionCulture] FROM '$(SqlSamplesSourceDataPath)ProductModelProductDescriptionCulture.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Production].[ProductPhoto]';
GO

BULK INSERT [Production].[ProductPhoto] FROM '$(SqlSamplesSourceDataPath)ProductPhoto.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK   
);
GO

PRINT 'Loading [Production].[ProductProductPhoto]';
GO

BULK INSERT [Production].[ProductProductPhoto] FROM '$(SqlSamplesSourceDataPath)ProductProductPhoto.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Production].[ProductReview]';
GO

BULK INSERT [Production].[ProductReview] FROM '$(SqlSamplesSourceDataPath)ProductReview.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Production].[ProductSubcategory]';
GO

BULK INSERT [Production].[ProductSubcategory] FROM '$(SqlSamplesSourceDataPath)ProductSubcategory.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Purchasing].[ProductVendor]';
GO

BULK INSERT [Purchasing].[ProductVendor] FROM '$(SqlSamplesSourceDataPath)ProductVendor.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Purchasing].[PurchaseOrderDetail]';
GO

BULK INSERT [Purchasing].[PurchaseOrderDetail] FROM '$(SqlSamplesSourceDataPath)PurchaseOrderDetail.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Purchasing].[PurchaseOrderHeader]';
GO

BULK INSERT [Purchasing].[PurchaseOrderHeader] FROM '$(SqlSamplesSourceDataPath)PurchaseOrderHeader.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Sales].[SalesOrderDetail]';
GO

BULK INSERT [Sales].[SalesOrderDetail] FROM '$(SqlSamplesSourceDataPath)SalesOrderDetail.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Sales].[SalesOrderHeader]';
GO

BULK INSERT [Sales].[SalesOrderHeader] FROM '$(SqlSamplesSourceDataPath)SalesOrderHeader.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Sales].[SalesOrderHeaderSalesReason]';
GO

BULK INSERT [Sales].[SalesOrderHeaderSalesReason] FROM '$(SqlSamplesSourceDataPath)SalesOrderHeaderSalesReason.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Sales].[SalesPerson]';
GO

BULK INSERT [Sales].[SalesPerson] FROM '$(SqlSamplesSourceDataPath)SalesPerson.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Sales].[SalesPersonQuotaHistory]';
GO

BULK INSERT [Sales].[SalesPersonQuotaHistory] FROM '$(SqlSamplesSourceDataPath)SalesPersonQuotaHistory.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Sales].[SalesReason]';
GO

BULK INSERT [Sales].[SalesReason] FROM '$(SqlSamplesSourceDataPath)SalesReason.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Sales].[SalesTaxRate]';
GO

BULK INSERT [Sales].[SalesTaxRate] FROM '$(SqlSamplesSourceDataPath)SalesTaxRate.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Sales].[SalesTerritory]';
GO

BULK INSERT [Sales].[SalesTerritory] FROM '$(SqlSamplesSourceDataPath)SalesTerritory.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Sales].[SalesTerritoryHistory]';
GO

BULK INSERT [Sales].[SalesTerritoryHistory] FROM '$(SqlSamplesSourceDataPath)SalesTerritoryHistory.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Production].[ScrapReason]';
GO

BULK INSERT [Production].[ScrapReason] FROM '$(SqlSamplesSourceDataPath)ScrapReason.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [HumanResources].[Shift]';
GO

BULK INSERT [HumanResources].[Shift] FROM '$(SqlSamplesSourceDataPath)Shift.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Purchasing].[ShipMethod]';
GO

BULK INSERT [Purchasing].[ShipMethod] FROM '$(SqlSamplesSourceDataPath)ShipMethod.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Sales].[ShoppingCartItem]';
GO

BULK INSERT [Sales].[ShoppingCartItem] FROM '$(SqlSamplesSourceDataPath)ShoppingCartItem.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Sales].[SpecialOffer]';
GO

BULK INSERT [Sales].[SpecialOffer] FROM '$(SqlSamplesSourceDataPath)SpecialOffer.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Sales].[SpecialOfferProduct]';
GO

BULK INSERT [Sales].[SpecialOfferProduct] FROM '$(SqlSamplesSourceDataPath)SpecialOfferProduct.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Person].[StateProvince]';
GO

BULK INSERT [Person].[StateProvince] FROM '$(SqlSamplesSourceDataPath)StateProvince.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Sales].[Store]';
GO

BULK INSERT [Sales].[Store] FROM '$(SqlSamplesSourceDataPath)Store.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='widechar',
    FIELDTERMINATOR='+|',
    ROWTERMINATOR='&|\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Production].[TransactionHistory]';
GO

BULK INSERT [Production].[TransactionHistory] FROM '$(SqlSamplesSourceDataPath)TransactionHistory.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    TABLOCK
);
GO

PRINT 'Loading [Production].[TransactionHistoryArchive]';
GO

BULK INSERT [Production].[TransactionHistoryArchive] FROM '$(SqlSamplesSourceDataPath)TransactionHistoryArchive.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Production].[UnitMeasure]';
GO

BULK INSERT [Production].[UnitMeasure] FROM '$(SqlSamplesSourceDataPath)UnitMeasure.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Purchasing].[Vendor]';
GO

BULK INSERT [Purchasing].[Vendor] FROM '$(SqlSamplesSourceDataPath)Vendor.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Production].[WorkOrder]';
GO

BULK INSERT [Production].[WorkOrder] FROM '$(SqlSamplesSourceDataPath)WorkOrder.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

PRINT 'Loading [Production].[WorkOrderRouting]';
GO

BULK INSERT [Production].[WorkOrderRouting] FROM '$(SqlSamplesSourceDataPath)WorkOrderRouting.csv'
WITH (
    CHECK_CONSTRAINTS,
    CODEPAGE='ACP',
    DATAFILETYPE='char',
    FIELDTERMINATOR='\t',
    ROWTERMINATOR='\n',
    KEEPIDENTITY,
    TABLOCK
);
GO

-- ******************************************************
-- Add Primary Keys
-- ******************************************************
PRINT '';
GO

PRINT '*** Adding Primary Keys';
GO

SET QUOTED_IDENTIFIER ON;
GO

-- ******************************************************
-- Add Indexes
-- ******************************************************
PRINT '';
GO

PRINT '*** Adding Indexes';
GO

-- ****************************************
-- Create XML index for each XML column
-- ****************************************
PRINT '';
GO

PRINT '*** Creating XML index for each XML column';
GO

SET ARITHABORT ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

SET ANSI_NULLS ON;
GO

SET ANSI_WARNINGS ON;
GO

SET CONCAT_NULL_YIELDS_NULL ON;
GO

SET NUMERIC_ROUNDABORT OFF;
GO

-- ****************************************
-- Create Full Text catalog and indexes
-- ****************************************
PRINT '';
GO

PRINT '*** Creating Full Text catalog and indexes';
GO

-- ****************************************
-- Create Foreign key constraints
-- ****************************************
PRINT '';
GO

PRINT '*** Creating Foreign Key Constraints';
GO

-- ******************************************************
-- Add table triggers.
-- ******************************************************
PRINT '';
GO

PRINT '*** Creating Table Triggers';
GO

-- ******************************************************
-- Add database views.
-- ******************************************************
PRINT '';
GO

PRINT '*** Creating Table Views';
GO

-- ******************************************************
-- Add database functions.
-- ******************************************************
PRINT '';
GO

PRINT '*** Creating Database Functions';
GO

-- ******************************************************
-- Create stored procedures
-- ******************************************************
PRINT '';
GO

PRINT '*** Creating Stored Procedures';
GO

-- ******************************************************
-- Add Extended Properties
-- ******************************************************
PRINT '';
GO

PRINT '*** Creating Extended Properties';
GO

SET NOCOUNT ON;
GO

PRINT '    Database';
GO

PRINT '    Files and Filegroups';
GO

PRINT '    Schemas';
GO

PRINT '    Tables and Columns';
GO

PRINT '    Triggers';
GO

PRINT '    Views';
GO

PRINT '    Indexes';
GO

PRINT '    Constraints - PK, FK, DF, CK';
GO

PRINT '    Functions';
GO

PRINT '    Stored Procedures';
GO

PRINT '    XML Schemas';
GO

SET NOCOUNT OFF;
GO

-- ****************************************
-- Drop DDL Trigger for Database
-- ****************************************
PRINT '';
GO

PRINT '*** Disabling DDL Trigger for Database';
GO

USE [master];
GO

PRINT 'Finished - ' + CONVERT(varchar, GETDATE(), 121);
GO

SET NOEXEC OFF
GO


/*
-- Output database object creation messages
SELECT [PostTime], [DatabaseUser], [Event], [Schema], [Object], [TSQL], [XmlEvent]
FROM [dbo].[DatabaseLog];
*/

GO

/*============================================================================
  File:     instawdb.sql

  Summary:  Creates the AdventureWorks sample database. Run this on
  any version of SQL Server (2008R2 or later) to get AdventureWorks for your
  current version.  

  Date:     October 26, 2017
  Updated:  October 26, 2017

------------------------------------------------------------------------------
  This file is part of the Microsoft SQL Server Code Samples.

  Copyright (C) Microsoft Corporation.  All rights reserved.

  This source code is intended only as a supplement to Microsoft
  Development Tools and/or on-line documentation.  See these other
  materials for detailed information regarding Microsoft code samples.

  All data in this database is ficticious.
  
  THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
  KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
  IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
  PARTICULAR PURPOSE.
============================================================================*/

/*
 * HOW TO RUN THIS SCRIPT:
 *
 * 1. Enable full-text search on your SQL Server instance. 
 *
 * 2. Open the script inside SQL Server Management Studio and enable SQLCMD mode. 
 *    This option is in the Query menu.
 *
 * 3. Copy this script and the install files to C:\Samples\AdventureWorks, or
 *    set the following environment variable to your own data path.
 */
 :setvar SqlSamplesSourceDataPath "C:\Samples\AdventureWorks\"

/*
 * 4. Append the SQL Server version number to database name if you want to
 *    differentiate it from other installs of AdventureWorks.
 */

:setvar DatabaseName "AdventureWorks"

/* Execute the script
 */

IF '$(SqlSamplesSourceDataPath)' IS NULL OR '$(SqlSamplesSourceDataPath)' = ''
BEGIN
	RAISERROR(N'The variable SqlSamplesSourceDataPath must be defined.', 16, 127) WITH NOWAIT
	RETURN
END;


SET NOCOUNT OFF;

GO

--Erro de Sintaxe: Sintaxe incorreta próximo de :.
--/*============================================================================
--  File:     instawdb.sql
--
--  Summary:  Creates the AdventureWorks sample database. Run this on
--  any version of SQL Server (2008R2 or later) to get AdventureWorks for your
--  current version.  
--
--  Date:     October 26, 2017
--  Updated:  October 26, 2017
--
--------------------------------------------------------------------------------
--  This file is part of the Microsoft SQL Server Code Samples.
--
--  Copyright (C) Microsoft Corporation.  All rights reserved.
--
--  This source code is intended only as a supplement to Microsoft
--  Development Tools and/or on-line documentation.  See these other
--  materials for detailed information regarding Microsoft code samples.
--
--  All data in this database is ficticious.
--  
--  THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
--  KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
--  IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
--  PARTICULAR PURPOSE.
--============================================================================*/
--
--/*
-- * HOW TO RUN THIS SCRIPT:
-- *
-- * 1. Enable full-text search on your SQL Server instance. 
-- *
-- * 2. Open the script inside SQL Server Management Studio and enable SQLCMD mode. 
-- *    This option is in the Query menu.
-- *
-- * 3. Copy this script and the install files to C:\Samples\AdventureWorks, or
-- *    set the following environment variable to your own data path.
-- */
-- :setvar SqlSamplesSourceDataPath "C:\Samples\AdventureWorks\"
--
--/*
-- * 4. Append the SQL Server version number to database name if you want to
-- *    differentiate it from other installs of AdventureWorks.
-- */
--
--:setvar DatabaseName "AdventureWorks"
--
--/* Execute the script
-- */
--
--IF '$(SqlSamplesSourceDataPath)' IS NULL OR '$(SqlSamplesSourceDataPath)' = ''
--BEGIN
--	RAISERROR(N'The variable SqlSamplesSourceDataPath must be defined.', 16, 127) WITH NOWAIT
--	RETURN
--END;
--
--
--SET NOCOUNT OFF;

GO

--Erro de Sintaxe: Sintaxe incorreta próximo de $(DatabaseName).
--IF EXISTS (SELECT [name] FROM [master].[sys].[databases] WHERE [name] = N'$(DatabaseName)')
--    DROP DATABASE $(DatabaseName);
--
---- If the database has any other open connections close the network connection.

GO


CREATE DATABASE $(DatabaseName);

GO

--Erro de Sintaxe: Sintaxe incorreta próximo de $(DatabaseName).
--
--CREATE DATABASE $(DatabaseName);

GO


USE $(DatabaseName);

GO

--Erro de Sintaxe: Sintaxe incorreta próximo de USE.
--
--USE $(DatabaseName);



GO
