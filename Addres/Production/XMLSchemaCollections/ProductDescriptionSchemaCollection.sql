CREATE XML SCHEMA COLLECTION [Production].[ProductDescriptionSchemaCollection] AS 
'<xsd:schema targetNamespace="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain"
    xmlns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain" 
    elementFormDefault="qualified" 
    xmlns:xsd="http://www.w3.org/2001/XMLSchema" >
  
    <xsd:element name="Warranty"  >
        <xsd:complexType>
            <xsd:sequence>
                <xsd:element name="WarrantyPeriod" type="xsd:string"  />
                <xsd:element name="Description" type="xsd:string"  />
            </xsd:sequence>
        </xsd:complexType>
    </xsd:element>

    <xsd:element name="Maintenance"  >
        <xsd:complexType>
            <xsd:sequence>
                <xsd:element name="NoOfYears" type="xsd:string"  />
                <xsd:element name="Description" type="xsd:string"  />
            </xsd:sequence>
        </xsd:complexType>
    </xsd:element>
</xsd:schema>';
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Collection of XML schemas for the CatalogDescription column in the Production.ProductModel table.', N'SCHEMA', [Production], N'XML SCHEMA COLLECTION', [ProductDescriptionSchemaCollection], NULL, NULL;