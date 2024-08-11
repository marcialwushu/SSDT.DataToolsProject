CREATE SCHEMA [HumanResources] AUTHORIZATION [dbo];
GO
-- Schemas
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Contains objects related to employees and departments.', N'SCHEMA', [HumanResources], NULL, NULL, NULL, NULL;