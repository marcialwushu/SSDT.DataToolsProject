## Procedure 

```sql
CREATE PROCEDURE [HumanResources].[uspUpdateEmployeeLogin]
    @BusinessEntityID [int], 
    @OrganizationNode [hierarchyid],
    @LoginID [nvarchar](256),
    @JobTitle [nvarchar](50),
    @HireDate [datetime],
    @CurrentFlag [dbo].[Flag]
WITH EXECUTE AS CALLER
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        UPDATE [HumanResources].[Employee] 
        SET [OrganizationNode] = @OrganizationNode 
            ,[LoginID] = @LoginID 
            ,[JobTitle] = @JobTitle 
            ,[HireDate] = @HireDate 
            ,[CurrentFlag] = @CurrentFlag 
        WHERE [BusinessEntityID] = @BusinessEntityID;
    END TRY
    BEGIN CATCH
        EXECUTE [dbo].[uspLogError];
    END CATCH;
END;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Updates the Employee table with the values specified in the input parameters for the given BusinessEntityID.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeeLogin], NULL, NULL;
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeLogin. Enter a valid EmployeeID from the Employee table.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeeLogin], N'PARAMETER', '@BusinessEntityID';
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeHireInfo. Enter a valid ManagerID for the employee.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeeLogin], N'PARAMETER', '@OrganizationNode';
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeHireInfo. Enter a valid login for the employee.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeeLogin], N'PARAMETER', '@LoginID';
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeHireInfo. Enter a title for the employee.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeeLogin], N'PARAMETER', '@JobTitle';
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeHireInfo. Enter a hire date for the employee.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeeLogin], N'PARAMETER', '@HireDate';
GO
EXECUTE [sys].[sp_addextendedproperty] N'MS_Description', N'Input parameter for the stored procedure uspUpdateEmployeeHireInfo. Enter the current flag for the employee.', N'SCHEMA', [HumanResources], N'PROCEDURE', [uspUpdateEmployeeLogin], N'PARAMETER', '@CurrentFlag';
```

Aqui está um exemplo de como criar um teste unitário para a stored procedure `[HumanResources].[uspUpdateEmployeeLogin]`. O teste unitário será criado usando T-SQL para validar o comportamento da stored procedure em diferentes cenários. Este exemplo pressupõe que você tem uma tabela temporária ou uma abordagem de rollback (transações) para garantir que os testes não alterem permanentemente os dados.

### 1. **Preparação do Ambiente de Teste**

Primeiro, crie os dados de teste em uma tabela temporária (ou você pode criar transações para evitar que os testes impactem os dados reais):

```sql
BEGIN TRANSACTION;

-- Criação de dados de teste
INSERT INTO [HumanResources].[Employee] 
    ([BusinessEntityID], [OrganizationNode], [LoginID], [JobTitle], [HireDate], [CurrentFlag])
VALUES 
    (1, HIERARCHYID::GetRoot(), 'oldlogin@example.com', 'Old Job Title', '2000-01-01', 1);

```

### 2. **Teste Unitário: Verificar Atualização Bem-sucedida**

Neste teste, validaremos se a stored procedure atualiza corretamente os valores para um `BusinessEntityID` existente.

```sql
-- Teste: Atualização bem-sucedida
DECLARE @BusinessEntityID INT = 1;
DECLARE @OrganizationNode HIERARCHYID = HIERARCHYID::GetRoot().GetDescendant(NULL, NULL);
DECLARE @LoginID NVARCHAR(256) = 'newlogin@example.com';
DECLARE @JobTitle NVARCHAR(50) = 'New Job Title';
DECLARE @HireDate DATETIME = '2024-08-11';
DECLARE @CurrentFlag BIT = 0;

-- Executa a procedure
EXEC [HumanResources].[uspUpdateEmployeeLogin] 
    @BusinessEntityID = @BusinessEntityID,
    @OrganizationNode = @OrganizationNode,
    @LoginID = @LoginID,
    @JobTitle = @JobTitle,
    @HireDate = @HireDate,
    @CurrentFlag = @CurrentFlag;

-- Verifica se os dados foram atualizados corretamente
DECLARE @UpdatedLoginID NVARCHAR(256);
DECLARE @UpdatedJobTitle NVARCHAR(50);
DECLARE @UpdatedHireDate DATETIME;
DECLARE @UpdatedCurrentFlag BIT;

SELECT 
    @UpdatedLoginID = [LoginID],
    @UpdatedJobTitle = [JobTitle],
    @UpdatedHireDate = [HireDate],
    @UpdatedCurrentFlag = [CurrentFlag]
FROM 
    [HumanResources].[Employee]
WHERE 
    [BusinessEntityID] = @BusinessEntityID;

-- Validação
IF @UpdatedLoginID = @LoginID AND 
   @UpdatedJobTitle = @JobTitle AND 
   @UpdatedHireDate = @HireDate AND 
   @UpdatedCurrentFlag = @CurrentFlag
BEGIN
    PRINT 'Teste de atualização bem-sucedido passou';
END
ELSE
BEGIN
    PRINT 'Teste de atualização bem-sucedido falhou';
END
```

### 3. **Teste Unitário: Verificar Tratamento de Erros**

Aqui, verificamos se a stored procedure corretamente invoca o procedimento de log de erros ao encontrar uma condição de erro, como um `BusinessEntityID` inexistente.

```sql
-- Teste: Tratamento de erro (BusinessEntityID inexistente)
DECLARE @InvalidBusinessEntityID INT = 999; -- ID que não existe

BEGIN TRY
    EXEC [HumanResources].[uspUpdateEmployeeLogin] 
        @BusinessEntityID = @InvalidBusinessEntityID,
        @OrganizationNode = @OrganizationNode,
        @LoginID = @LoginID,
        @JobTitle = @JobTitle,
        @HireDate = @HireDate,
        @CurrentFlag = @CurrentFlag;

    PRINT 'Erro esperado, mas não ocorreu';
END TRY
BEGIN CATCH
    PRINT 'Tratamento de erro executado corretamente';
    -- Opcional: verificar o conteúdo de [dbo].[uspLogError] se necessário
END CATCH;
```

### 4. **Teste Unitário: Reverter Alterações**

Reverter as alterações após a execução dos testes para garantir que o ambiente de teste volte ao estado original.

```sql
-- Reverter alterações
ROLLBACK TRANSACTION;

-- Limpar dados de teste, se necessário (se não estiver usando transações)
-- DELETE FROM [HumanResources].[Employee] WHERE [BusinessEntityID] = 1;
```

### 5. **Execução e Análise dos Resultados**

Execute os scripts acima em seu ambiente de teste para verificar a funcionalidade da stored procedure. Certifique-se de interpretar os resultados e ajustar a procedure ou os testes conforme necessário.

### Considerações Finais

- **Isolamento:** Garanta que os testes sejam isolados para não interferirem com outros processos ou dados.
- **Repetibilidade:** Certifique-se de que os testes possam ser executados várias vezes sem alterar os resultados.
- **Documentação:** Documente os resultados dos testes para referência futura e auditoria.

Esse exemplo fornece uma base para criar testes unitários para stored procedures no SQL Server, ajudando a garantir a qualidade e confiabilidade do código.
