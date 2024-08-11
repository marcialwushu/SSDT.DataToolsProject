A segurança é um aspecto crucial na administração de bancos de dados, especialmente em SQL Server. Aqui estão alguns scripts T-SQL que você pode usar para verificar diferentes aspectos de segurança no seu ambiente SQL Server:

### 1. **Verificar Permissões de Usuário**
   - **Objetivo:** Verificar as permissões atribuídas a usuários e funções no banco de dados.

```sql
-- Lista todas as permissões atribuídas a usuários e funções no banco de dados atual
SELECT 
    dp.name AS PrincipalName,
    dp.type_desc AS PrincipalType,
    o.name AS ObjectName,
    p.permission_name AS PermissionName,
    p.state_desc AS PermissionState
FROM 
    sys.database_principals dp
    LEFT JOIN sys.database_permissions p ON dp.principal_id = p.grantee_principal_id
    LEFT JOIN sys.objects o ON p.major_id = o.object_id
WHERE 
    dp.type NOT IN ('R', 'X')  -- Exclui funções de banco de dados fixas e schemas
ORDER BY 
    dp.name, o.name, p.permission_name;
```

### 2. **Verificar Permissões de Stored Procedures**
   - **Objetivo:** Verificar se as stored procedures possuem permissões apropriadas e não concedem acesso indevido.

```sql
-- Verifica permissões de execução atribuídas a stored procedures
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

### 3. **Verificar Logins com Privilégios de Administrador**
   - **Objetivo:** Identificar logins que possuem privilégios administrativos elevados, como membros do grupo `sysadmin`.

```sql
-- Lista todos os logins que são membros da função de servidor sysadmin
SELECT 
    sl.name AS LoginName,
    rl.name AS RoleName
FROM 
    sys.server_principals sl
    JOIN sys.server_role_members srm ON sl.principal_id = srm.member_principal_id
    JOIN sys.server_principals rl ON srm.role_principal_id = rl.principal_id
WHERE 
    rl.name = 'sysadmin';
```

### 4. **Verificar Contas de Usuário sem Senhas Fortes**
   - **Objetivo:** Identificar contas de usuário que não têm uma política de senha forte aplicada ou têm a expiração da senha desativada.

```sql
-- Verifica logins que não têm políticas de senha forte ou expiração de senha aplicadas
SELECT 
    name AS LoginName,
    is_policy_checked AS PasswordPolicyEnforced,
    is_expiration_checked AS PasswordExpirationEnforced
FROM 
    sys.sql_logins
WHERE 
    is_policy_checked = 0 OR is_expiration_checked = 0;
```

### 5. **Verificar Funções de Servidor e Banco de Dados**
   - **Objetivo:** Listar membros de funções críticas, como `db_owner`, `db_securityadmin`, etc., para garantir que apenas usuários autorizados têm esses privilégios.

```sql
-- Lista todos os membros da função db_owner em todos os bancos de dados
EXEC sp_MSforeachdb 'USE [?]; 
SELECT 
    DB_NAME() AS DatabaseName, 
    dp.name AS UserName, 
    rp.name AS RoleName
FROM 
    sys.database_principals dp
    JOIN sys.database_role_members drm ON dp.principal_id = drm.member_principal_id
    JOIN sys.database_principals rp ON drm.role_principal_id = rp.principal_id
WHERE 
    rp.name = ''db_owner''';
```

### 6. **Verificar Objetos sem Permissões Específicas**
   - **Objetivo:** Identificar objetos que não têm permissões explícitas configuradas, dependendo de permissões herdadas.

```sql
-- Lista objetos que não têm permissões específicas configuradas
SELECT 
    o.name AS ObjectName,
    o.type_desc AS ObjectType
FROM 
    sys.objects o
    LEFT JOIN sys.database_permissions p ON o.object_id = p.major_id
WHERE 
    p.major_id IS NULL;
```

### 7. **Verificar Triggers de Logon**
   - **Objetivo:** Verificar se há triggers de logon configurados, que podem ser usados para auditoria ou controle de acesso.

```sql
-- Lista triggers de logon configurados no servidor
SELECT 
    name AS TriggerName,
    is_disabled AS IsDisabled,
    create_date AS CreatedDate,
    modify_date AS ModifiedDate
FROM 
    sys.server_triggers
WHERE 
    type_desc = 'LOGON';
```

### 8. **Verificar Conexões e Usuários Inativos**
   - **Objetivo:** Identificar logins e usuários que não têm se conectado ao servidor por um período prolongado.

```sql
-- Lista logins que não se conectaram ao servidor por mais de 90 dias
SELECT 
    name AS LoginName,
    last_successful_logon AS LastLogonDate
FROM 
    sys.dm_exec_sessions AS s
    JOIN sys.server_principals AS p ON s.login_name = p.name
WHERE 
    DATEDIFF(DAY, p.last_successful_logon, GETDATE()) > 90
ORDER BY 
    p.last_successful_logon;
```

### 9. **Verificar Objetos de Banco de Dados com Permissões Públicas**
   - **Objetivo:** Identificar objetos que têm permissões concedidas ao papel público, o que pode representar um risco de segurança.

```sql
-- Verifica se há permissões concedidas ao papel público em objetos do banco de dados
SELECT 
    o.name AS ObjectName,
    p.permission_name AS PermissionName,
    p.state_desc AS PermissionState
FROM 
    sys.database_permissions p
    JOIN sys.objects o ON p.major_id = o.object_id
    JOIN sys.database_principals dp ON p.grantee_principal_id = dp.principal_id
WHERE 
    dp.name = 'public';
```

### 10. **Verificar Colunas com Dados Sensíveis**
   - **Objetivo:** Identificar colunas que possam conter dados sensíveis (como senhas, cartões de crédito) e verificar se estão criptografadas.

```sql
-- Verifica se colunas sensíveis estão criptografadas
SELECT 
    t.name AS TableName,
    c.name AS ColumnName,
    c.is_encrypted AS IsEncrypted
FROM 
    sys.columns c
    JOIN sys.tables t ON c.object_id = t.object_id
WHERE 
    c.name LIKE '%password%' OR 
    c.name LIKE '%creditcard%' OR 
    c.name LIKE '%ssn%'  -- Adapte para outros padrões de dados sensíveis
ORDER BY 
    t.name, c.name;
```

### 11. **Verificar Conexões não Seguras (sem SSL)**
   - **Objetivo:** Identificar se o SQL Server está permitindo conexões não seguras (sem SSL).

```sql
-- Verifica se as conexões não seguras são permitidas (sem SSL)
SELECT 
    session_id, 
    encrypt_option
FROM 
    sys.dm_exec_connections
WHERE 
    encrypt_option = 'FALSE';
```

### Conclusão

Esses scripts ajudam a identificar potenciais vulnerabilidades e garantem que as práticas de segurança adequadas estão sendo seguidas no seu ambiente SQL Server. Implementar verificações regulares com esses scripts pode prevenir falhas de segurança e proteger os dados críticos do banco de dados.

