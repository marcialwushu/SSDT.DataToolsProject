CREATE TABLE [Person].[Person](
    [BusinessEntityID] [int] NOT NULL,
	[PersonType] [nchar](2) NOT NULL,
    [NameStyle] [NameStyle] NOT NULL CONSTRAINT [DF_Person_NameStyle] DEFAULT (0),
    [Title] [nvarchar](8) NULL, 
    [FirstName] [Name] NOT NULL,
    [MiddleName] [Name] NULL,
    [LastName] [Name] NOT NULL,
    [Suffix] [nvarchar](10) NULL, 
    [EmailPromotion] [int] NOT NULL CONSTRAINT [DF_Person_EmailPromotion] DEFAULT (0), 
    [AdditionalContactInfo] [XML]([Person].[AdditionalContactInfoSchemaCollection]) NULL,
    [Demographics] [XML]([Person].[IndividualSurveySchemaCollection]) NULL, 
    [rowguid] uniqueidentifier ROWGUIDCOL NOT NULL CONSTRAINT [DF_Person_rowguid] DEFAULT (NEWID()), 
    [ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Person_ModifiedDate] DEFAULT (GETDATE()), 
    CONSTRAINT [CK_Person_EmailPromotion] CHECK ([EmailPromotion] BETWEEN 0 AND 2),
    CONSTRAINT [CK_Person_PersonType] CHECK ([PersonType] IS NULL OR UPPER([PersonType]) IN ('SC', 'VC', 'IN', 'EM', 'SP', 'GC'))
) ON [PRIMARY];
GO
ALTER TABLE [Person].[Person] ADD 
    CONSTRAINT [FK_Person_BusinessEntity_BusinessEntityID] FOREIGN KEY 
    (
        [BusinessEntityID]
    ) REFERENCES [Person].[BusinessEntity](
        [BusinessEntityID]
    );
GO
ALTER TABLE [Person].[Person] WITH CHECK ADD 
    CONSTRAINT [PK_Person_BusinessEntityID] PRIMARY KEY CLUSTERED 
    (
        [BusinessEntityID]
    )  ON [PRIMARY];
GO
CREATE INDEX [IX_Person_LastName_FirstName_MiddleName] ON [Person].[Person] ([LastName], [FirstName], [MiddleName]) ON [PRIMARY];
GO
CREATE UNIQUE INDEX [AK_Person_rowguid] ON [Person].[Person]([rowguid]) ON [PRIMARY];
GO
CREATE PRIMARY XML INDEX [PXML_Person_AddContact] ON [Person].[Person]([AdditionalContactInfo]);
GO
CREATE PRIMARY XML INDEX [PXML_Person_Demographics] ON [Person].[Person]([Demographics]);
GO
CREATE XML INDEX [XMLPATH_Person_Demographics] ON [Person].[Person]([Demographics]) 
USING XML INDEX [PXML_Person_Demographics] FOR PATH;
GO
CREATE XML INDEX [XMLPROPERTY_Person_Demographics] ON [Person].[Person]([Demographics]) 
USING XML INDEX [PXML_Person_Demographics] FOR PROPERTY;
GO
CREATE XML INDEX [XMLVALUE_Person_Demographics] ON [Person].[Person]([Demographics]) 
USING XML INDEX [PXML_Person_Demographics] FOR VALUE;
GO
CREATE TRIGGER [Person].[iuPerson] ON [Person].[Person] 
AFTER INSERT, UPDATE NOT FOR REPLICATION AS 
BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    IF UPDATE([BusinessEntityID]) OR UPDATE([Demographics]) 
    BEGIN
        UPDATE [Person].[Person] 
        SET [Person].[Person].[Demographics] = N'<IndividualSurvey xmlns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"> 
            <TotalPurchaseYTD>0.00</TotalPurchaseYTD> 
            </IndividualSurvey>' 
        FROM inserted 
        WHERE [Person].[Person].[BusinessEntityID] = inserted.[BusinessEntityID] 
            AND inserted.[Demographics] IS NULL;
        
        UPDATE [Person].[Person] 
        SET [Demographics].modify(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
            insert <TotalPurchaseYTD>0.00</TotalPurchaseYTD> 
            as first 
            into (/IndividualSurvey)[1]') 
        FROM inserted 
        WHERE [Person].[Person].[BusinessEntityID] = inserted.[BusinessEntityID] 
            AND inserted.[Demographics] IS NOT NULL 
            AND inserted.[Demographics].exist(N'declare default element namespace 
                "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
                /IndividualSurvey/TotalPurchaseYTD') <> 1;
    END;
END;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Human beings involved with AdventureWorks: employees, customer contacts, and vendor contacts.', N'SCHEMA', [Person], N'TABLE', [Person], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key for Person records.', N'SCHEMA', [Person], N'TABLE', [Person], N'COLUMN', [BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary type of person: SC = Store Contact, IN = Individual (retail) customer, SP = Sales person, EM = Employee (non-sales), VC = Vendor contact, GC = General contact', N'SCHEMA', [Person], N'TABLE', [Person], N'COLUMN', [PersonType];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'0 = The data in FirstName and LastName are stored in western style (first name, last name) order.  1 = Eastern style (last name, first name) order.', N'SCHEMA', [Person], N'TABLE', [Person], N'COLUMN', [NameStyle];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'A courtesy title. For example, Mr. or Ms.', N'SCHEMA', [Person], N'TABLE', [Person], N'COLUMN', [Title];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'First name of the person.', N'SCHEMA', [Person], N'TABLE', [Person], N'COLUMN', [FirstName];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Middle name or middle initial of the person.', N'SCHEMA', [Person], N'TABLE', [Person], N'COLUMN', [MiddleName];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Last name of the person.', N'SCHEMA', [Person], N'TABLE', [Person], N'COLUMN', [LastName];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Surname suffix. For example, Sr. or Jr.', N'SCHEMA', [Person], N'TABLE', [Person], N'COLUMN', [Suffix];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'0 = Contact does not wish to receive e-mail promotions, 1 = Contact does wish to receive e-mail promotions from AdventureWorks, 2 = Contact does wish to receive e-mail promotions from AdventureWorks and selected partners. ', N'SCHEMA', [Person], N'TABLE', [Person], N'COLUMN', [EmailPromotion];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Personal information such as hobbies, and income collected from online shoppers. Used for sales analysis.', N'SCHEMA', [Person], N'TABLE', [Person], N'COLUMN', [Demographics];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Additional contact information about the person stored in xml format. ', N'SCHEMA', [Person], N'TABLE', [Person], N'COLUMN', [AdditionalContactInfo];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', N'SCHEMA', [Person], N'TABLE', [Person], N'COLUMN', [rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Date and time the record was last updated.', N'SCHEMA', [Person], N'TABLE', [Person], N'COLUMN', [ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'AFTER INSERT, UPDATE trigger inserting Individual only if the Customer does not exist in the Store table and setting the ModifiedDate column in the Person table to the current date.', N'SCHEMA', [Person], N'TABLE', [Person], N'TRIGGER', [iuPerson];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', N'SCHEMA', [Person], N'TABLE', [Person], N'INDEX', [AK_Person_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary XML index.', N'SCHEMA', [Person], N'TABLE', [Person], N'INDEX', [PXML_Person_Demographics];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Secondary XML index for path.', N'SCHEMA', [Person], N'TABLE', [Person], N'INDEX', [XMLPATH_Person_Demographics];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Secondary XML index for property.', N'SCHEMA', [Person], N'TABLE', [Person], N'INDEX', [XMLPROPERTY_Person_Demographics];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Secondary XML index for value.', N'SCHEMA', [Person], N'TABLE', [Person], N'INDEX', [XMLVALUE_Person_Demographics];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary XML index.', N'SCHEMA', [Person], N'TABLE', [Person], N'INDEX', [PXML_Person_AddContact];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Primary key (clustered) constraint', N'SCHEMA', [Person], N'TABLE', [Person], N'CONSTRAINT', [PK_Person_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Foreign key constraint referencing BusinessEntity.BusinessEntityID.', N'SCHEMA', [Person], N'TABLE', [Person], N'CONSTRAINT', [FK_Person_BusinessEntity_BusinessEntityID];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0', N'SCHEMA', [Person], N'TABLE', [Person], N'CONSTRAINT', [DF_Person_EmailPromotion];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of 0', N'SCHEMA', [Person], N'TABLE', [Person], N'CONSTRAINT', [DF_Person_NameStyle];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of GETDATE()', N'SCHEMA', [Person], N'TABLE', [Person], N'CONSTRAINT', [DF_Person_ModifiedDate];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Default constraint value of NEWID()', N'SCHEMA', [Person], N'TABLE', [Person], N'CONSTRAINT', [DF_Person_rowguid];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [EmailPromotion] >= (0) AND [EmailPromotion] <= (2)', N'SCHEMA', [Person], N'TABLE', [Person], N'CONSTRAINT', [CK_Person_EmailPromotion];
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Check constraint [PersonType] is one of SC, VC, IN, EM or SP.', N'SCHEMA', [Person], N'TABLE', [Person], N'CONSTRAINT', [CK_Person_PersonType];