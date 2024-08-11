Para verificar o uso de parâmetros nas stored procedures como uma medida de prevenção contra SQL Injection, você pode criar um script T-SQL que analisa o código SQL das stored procedures e identifica possíveis práticas inseguras, como a concatenação de strings que podem ser exploradas para SQL Injection.

Aqui está um exemplo de script T-SQL para esse cenário:

### **Script T-SQL para Verificação de SQL Injection**

```sql
-- Script para identificar possíveis vulnerabilidades de SQL Injection em stored procedures

SELECT 
    p.name AS ProcedureName,
    m.definition AS ProcedureDefinition
FROM 
    sys.sql_modules m
    INNER JOIN sys.procedures p ON m.object_id = p.object_id
WHERE 
    m.definition LIKE '%EXEC(%' -- Procura por execuções dinâmicas
    AND m.definition LIKE '%'' + %''%' -- Procura por concatenação de strings
    OR m.definition LIKE '%+ ''''%''%' -- Outra forma de concatenação
    OR m.definition LIKE '%sp_executesql%' -- Verifica uso de sp_executesql sem parâmetros
    OR m.definition LIKE '%EXEC(''%' -- Procura por execução de comandos usando strings concatenadas
ORDER BY 
    p.name;

```

### **Explicação do Script:**

- **Procura por Concatenação de Strings:** O script busca por procedimentos armazenados (`sys.procedures`) que contenham concatenações de strings nas suas definições (`sys.sql_modules`). A concatenação de strings é um sinal clássico de uma potencial vulnerabilidade de SQL Injection, especialmente se usada para construir instruções SQL dinâmicas.

- **Verificação de `sp_executesql`:** Também verifica se o comando `sp_executesql` é usado sem a correta parametrização. O `sp_executesql` é seguro quando usado com parâmetros, mas se os parâmetros não forem usados adequadamente, ele pode ser vulnerável.

### **Análise dos Resultados:**

Após executar o script, você obterá uma lista de stored procedures que podem ter vulnerabilidades relacionadas a SQL Injection. O próximo passo seria revisar manualmente as stored procedures identificadas para:

1. **Garantir o Uso de Parâmetros:** Certifique-se de que as stored procedures estão usando parâmetros adequadamente para evitar SQL Injection. Todas as entradas de usuário devem ser passadas como parâmetros em vez de serem concatenadas diretamente em instruções SQL.

2. **Evitar Concatenações Diretas:** Evite a concatenação de strings para criar instruções SQL dinâmicas. Em vez disso, utilize parâmetros dentro do `sp_executesql` ou outras abordagens seguras.

3. **Melhorar Segurança:** Se qualquer concatenação ou construção dinâmica de SQL for necessária, considere o uso de técnicas avançadas de sanitização ou, preferencialmente, refatore o código para eliminar a necessidade de construção dinâmica de SQL.

### **Exemplo de Procedimento Inseguro vs. Seguro:**

**Inseguro:**
```sql
CREATE PROCEDURE [dbo].[uspGetEmployeeData]
    @EmployeeID NVARCHAR(50)
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);
    SET @SQL = 'SELECT * FROM Employees WHERE EmployeeID = ''' + @EmployeeID + '''';
    EXEC(@SQL);  -- Vulnerável a SQL Injection
END;
```

**Seguro:**
```sql
CREATE PROCEDURE [dbo].[uspGetEmployeeData]
    @EmployeeID NVARCHAR(50)
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);
    SET @SQL = 'SELECT * FROM Employees WHERE EmployeeID = @EmployeeID';
    EXEC sp_executesql @SQL, N'@EmployeeID NVARCHAR(50)', @EmployeeID;  -- Uso seguro de sp_executesql com parâmetros
END;
```

### **Conclusão:**

O script de verificação fornecido ajuda a identificar possíveis vulnerabilidades de SQL Injection em suas stored procedures. Ele serve como um ponto de partida para uma auditoria de segurança e pode ser integrado a um processo de revisão de código para garantir que todas as práticas de segurança recomendadas estejam sendo seguidas no desenvolvimento de stored procedures.

