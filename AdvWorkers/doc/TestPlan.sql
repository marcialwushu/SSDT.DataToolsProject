/*
Não altere variáveis de nome ou caminho do banco de dados.
As variáveis sqlcmd serão substituídas adequadamente durante 
a compilação e implantação.
*/
ALTER DATABASE [$(DatabaseName)]
ADD LOG FILE
(
	NAME = [TestPlan_log],
	FILENAME = '$(DefaultLogPath)$(DefaultFilePrefix)_TestPlan.ldf',
	SIZE = 1024 KB,
	FILEGROWTH = 10%
)
