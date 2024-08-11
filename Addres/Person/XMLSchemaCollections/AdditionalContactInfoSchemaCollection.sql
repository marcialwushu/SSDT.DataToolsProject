﻿CREATE XML SCHEMA COLLECTION [Person].[AdditionalContactInfoSchemaCollection] AS 
'<?xml version="1.0" encoding="UTF-8"?>
<xsd:schema targetNamespace="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo" 
    xmlns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo" 
    elementFormDefault="qualified"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema" >
    <!-- the following imports are not needed. They simply provide readability -->

    <xsd:import 
        namespace="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactRecord" />

    <xsd:import 
        namespace="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes" />

    <xsd:element name="AdditionalContactInfo" >
        <xsd:complexType mixed="true" >
            <xsd:sequence>
                <xsd:any processContents="strict" 
                    namespace="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactRecord 
                        http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"
                        minOccurs="0" maxOccurs="unbounded" />
            </xsd:sequence>
        </xsd:complexType>
    </xsd:element>
</xsd:schema>';
GO
-- XML Schemas
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Collection of XML schemas for the AdditionalContactInfo column in the Person.Contact table.', N'SCHEMA', [Person], N'XML SCHEMA COLLECTION', [AdditionalContactInfoSchemaCollection], NULL, NULL;