A análise estática de T-SQL envolve a verificação do código SQL sem executá-lo, para identificar problemas de desempenho, segurança, legibilidade, e aderência às melhores práticas. Abaixo estão exemplos de scripts que podem ser usados para realizar uma análise estática do código T-SQL em stored procedures, funções, triggers, e outros objetos do banco de dados.

### 1. **Verificação de Uso de `SELECT *`**
   - **Objetivo:** Identificar o uso de `SELECT *` que pode causar problemas de desempenho e manutenibilidade.

```sql
-- Verifica se há uso de SELECT * em stored procedures, funções e triggers
SELECT 
    OBJECT_NAME(m.object_id) AS ObjectName,
    o.type_desc AS ObjectType,
    m.definition AS ObjectDefinition
FROM 
    sys.sql_modules m
    JOIN sys.objects o ON m.object_id = o.object_id
WHERE 
    m.definition LIKE '%SELECT *%'
ORDER BY 
    ObjectName;
```

### 2. **Verificação de Índices Não Utilizados**
   - **Objetivo:** Identificar índices que não estão sendo utilizados para otimização.

```sql
-- Verifica índices que não foram utilizados desde a última reinicialização do SQL Server
SELECT 
    OBJECT_NAME(i.object_id) AS TableName,
    i.name AS IndexName,
    i.index_id,
    dmusi.user_seeks,
    dmusi.user_scans,
    dmusi.user_lookups,
    dmusi.user_updates
FROM 
    sys.indexes AS i
    LEFT JOIN sys.dm_db_index_usage_stats dmusi 
    ON i.object_id = dmusi.object_id AND i.index_id = dmusi.index_id
WHERE 
    i.is_primary_key = 0 -- Ignora a chave primária
    AND i.is_unique = 0 -- Ignora índices únicos
    AND dmusi.user_seeks = 0 
    AND dmusi.user_scans = 0 
    AND dmusi.user_lookups = 0
ORDER BY 
    OBJECT_NAME(i.object_id), i.name;
```

### 3. **Verificação de Funções em Cláusulas `WHERE`**
   - **Objetivo:** Identificar o uso de funções em colunas dentro de cláusulas `WHERE`, que pode impedir o uso eficiente de índices.

```sql
-- Verifica o uso de funções em colunas nas cláusulas WHERE
SELECT 
    OBJECT_NAME(m.object_id) AS ObjectName,
    m.definition AS ObjectDefinition
FROM 
    sys.sql_modules m
WHERE 
    m.definition LIKE '%WHERE%' 
    AND (m.definition LIKE '%ISNULL(%' 
         OR m.definition LIKE '%COALESCE(%'
         OR m.definition LIKE '%SUBSTRING(%'
         OR m.definition LIKE '%UPPER(%'
         OR m.definition LIKE '%LOWER(%')
ORDER BY 
    ObjectName;
```

### 4. **Verificação de Chaves Primárias e Estrangeiras**
   - **Objetivo:** Identificar tabelas sem chaves primárias ou estrangeiras definidas.

```sql
-- Verifica se todas as tabelas têm uma chave primária
SELECT 
    t.name AS TableName
FROM 
    sys.tables t
LEFT JOIN 
    sys.indexes i ON t.object_id = i.object_id AND i.is_primary_key = 1
WHERE 
    i.object_id IS NULL;

-- Verifica se todas as tabelas têm chaves estrangeiras
SELECT 
    t.name AS TableName
FROM 
    sys.tables t
LEFT JOIN 
    sys.foreign_keys fk ON t.object_id = fk.parent_object_id
WHERE 
    fk.object_id IS NULL;
```

### 5. **Verificação de Tratamento de Erros**
   - **Objetivo:** Identificar stored procedures ou triggers que não têm tratamento de erros com `TRY...CATCH`.

```sql
-- Verifica o uso de TRY...CATCH em stored procedures e triggers
SELECT 
    OBJECT_NAME(m.object_id) AS ObjectName,
    o.type_desc AS ObjectType,
    m.definition AS ObjectDefinition
FROM 
    sys.sql_modules m
    JOIN sys.objects o ON m.object_id = o.object_id
WHERE 
    m.definition NOT LIKE '%BEGIN TRY%'
    OR m.definition NOT LIKE '%BEGIN CATCH%'
ORDER BY 
    ObjectName;
```

### 6. **Verificação de Nomes de Objetos**
   - **Objetivo:** Garantir que os nomes de tabelas, colunas, stored procedures, e outros objetos sigam as convenções de nomenclatura estabelecidas.

```sql
-- Verifica se os nomes de tabelas seguem a convenção PascalCase
SELECT 
    t.name AS TableName
FROM 
    sys.tables t
WHERE 
    t.name COLLATE Latin1_General_BIN != LOWER(t.name)  -- Verifica se o nome não está em minúsculas
    AND t.name NOT LIKE '[a-z]%' -- Verifica se o nome não começa com uma letra minúscula
    AND t.name NOT LIKE '%[^a-zA-Z0-9]%' -- Verifica se o nome não contém caracteres especiais
ORDER BY 
    t.name;
```

### 7. **Verificação de Permissões de Execução**
   - **Objetivo:** Identificar stored procedures que têm permissões de execução concedidas de maneira inadequada.

```sql
-- Verifica se as stored procedures têm permissões de execução específicas
SELECT 
    p.name AS ProcedureName,
    dp.name AS PrincipalName,
    pr.permission_name AS PermissionName,
    pr.state_desc AS PermissionState
FROM 
    sys.procedures p
    JOIN sys.database_permissions pr ON p.object_id = pr.major_id
    JOIN sys.database_principals dp ON pr.grantee_principal_id = dp.principal_id
WHERE 
    pr.permission_name = 'EXECUTE'
ORDER BY 
    p.name, dp.name;
```

### 8. **Verificação de Código Duplicado**
   - **Objetivo:** Identificar blocos de código SQL duplicados em stored procedures, funções, ou triggers.

```sql
-- Verifica código duplicado em stored procedures e funções
WITH CodeSnippets AS (
    SELECT 
        OBJECT_NAME(m.object_id) AS ObjectName,
        m.definition AS CodeSnippet,
        ROW_NUMBER() OVER (PARTITION BY m.definition ORDER BY m.object_id) AS RowNumber
    FROM 
        sys.sql_modules m
)
SELECT 
    cs1.ObjectName AS ObjectName1,
    cs2.ObjectName AS ObjectName2,
    cs1.CodeSnippet
FROM 
    CodeSnippets cs1
    JOIN CodeSnippets cs2 ON cs1.CodeSnippet = cs2.CodeSnippet AND cs1.ObjectName <> cs2.ObjectName
WHERE 
    cs1.RowNumber = 1;
```

### 9. **Verificação de Comentários no Código**
   - **Objetivo:** Verificar se o código SQL está devidamente comentado para facilitar a manutenção.

```sql
-- Verifica se stored procedures e funções têm comentários suficientes
SELECT 
    OBJECT_NAME(m.object_id) AS ObjectName,
    m.definition AS ObjectDefinition
FROM 
    sys.sql_modules m
WHERE 
    m.definition NOT LIKE '%--%'
    AND m.definition NOT LIKE '%/*%'
ORDER BY 
    ObjectName;
```

### 10. **Verificação de Código Obsoleto**
   - **Objetivo:** Identificar o uso de funções e tipos de dados obsoletos, como `TEXT`, `NTEXT`, `IMAGE`.

```sql
-- Verifica o uso de tipos de dados obsoletos
SELECT 
    c.name AS ColumnName,
    t.name AS TableName,
    tp.name AS DataType
FROM 
    sys.columns c
    JOIN sys.tables t ON c.object_id = t.object_id
    JOIN sys.types tp ON c.user_type_id = tp.user_type_id
WHERE 
    tp.name IN ('text', 'ntext', 'image');
```

### Conclusão

Esses scripts oferecem uma forma poderosa de realizar análises estáticas em seu código T-SQL, ajudando a identificar problemas comuns antes que eles se tornem questões críticas em produção. Implementar esses scripts como parte de seu processo de revisão de código ou em pipelines de CI/CD pode melhorar significativamente a qualidade, desempenho, e segurança do seu ambiente de banco de dados.

