*** Settings ***
Documentation   https://docs.robotframework.org/docs/different_libraries/database
...             Instale: "pip install -U robotframework-databaselibrary"
...             Para acessar o DB o Robot precisa conhecer o DRIVER de cada banco, então precisamos instalar esse DRIVER também (instale apenas para o DB necessário) ...
...             Para PostgreSQL: "pip install psycopg2"
...             Para SQLite 3: não precisa instalar nada!
...             Para MySQL: "pip install pymysql"
...             Para SQL Server: "pip install pymssql"
...             Para Oracle: "pip install cx-Oracle"
...             Execute SQL String: Executa um comando SQL via string, pode ser usada para criar via arquivos de banco de dados também
...             Query: Executa uma query no banco de dados
...             Check If Exists In Database: Verifica se um registro existe no banco de dados
...             Row Count: Conta todos os registros existentes no banco de dados
...             Delete All Rows From Table: Deleta todas as linhas da tabela
...             Disconnect From Database: Desconecta do banco de dados

Library         DatabaseLibrary
Test Setup      Conectar no Banco de Dados
Test Teardown   Desconectar do Banco de Dados

*** Test Cases ***
CT001: Executando scripts SQL via Arquivos
    Executar script via ARQUIVO no Banco de Dados       ${CURDIR}/my_sql_scripts/create_table_accounts.sql
    Executar script via ARQUIVO no Banco de Dados       ${CURDIR}/my_sql_scripts/insert_into_account.sql
    Confere se "Aristoteles" foi inserido com sucesso

CT002: Executando scripts SQL via STRING
    Executar script via STRING no Banco de Dados        INSERT INTO public.account(user_id, username, password, email) VALUES (2, 'Luiz Silva', 'robot987', 'robotizando2@robot.com')
    Confere se "Luiz Silva" foi inserido com sucesso

CT003: Select Statement
    ${RESPOSTA_SELECT}      Executar query no Banco de dados    SELECT * from account
    Log    ${RESPOSTA_SELECT}
    ## Para pegar um campo específico, utilize as tuplas [NUM_LINHA][NUM_COLUNA]
    Log    Usuário ${RESPOSTA_SELECT[0][0]} - Nome: ${RESPOSTA_SELECT[0][1]} - E-mail: ${RESPOSTA_SELECT[0][3]}
    Log    Usuário ${RESPOSTA_SELECT[1][0]} - Nome: ${RESPOSTA_SELECT[1][1]} - E-mail: ${RESPOSTA_SELECT[1][3]}

CT004: Limpando Tabelas
    Limpar Tabela    account
    Executar script via STRING no Banco de Dados     DROP table account

*** Keywords ***
Conectar no Banco de Dados
    ## PostgreSQL
    Connect To Database   dbapiModuleName=psycopg2   dbName=postgres   dbUsername=postgres   dbPassword=admin   dbHost=localhost   dbPort=5432

    ## SQLite 3 e conexão via string de conexão
      # Connect To Database Using Custom Params   dbapiModuleName=sqlite3    db_connect_string=database="./${DBName}.db", isolation_level=None
    ## MySQL
      # Connect To Database   dbapiModuleName=pymysql   dbName=${DBName}   dbUsername=${DBUser}   dbPassword=${DBPass}   dbHost=${DBHost}   dbPort=${DBPort}
    ## SQL Server
      # Connect To Database   dbapiModuleName=pymssql   dbName=${DBName}   dbUsername=${DBUser}   dbPassword=${DBPass}   dbHost=${DBHost}   dbPort=${DBPort}	  
    ## Oracle
      # Connect To Database Using Custom Params    dbapiModuleName=cx_Oracle    db_connect_string="${DBName}/${DBUser}@${DBHost}:${DBPort}/${DBalias}"

Desconectar do Banco de Dados
    Disconnect From Database

Executar script via STRING no Banco de Dados
    [Arguments]          ${SCRIPT}
    Execute SQL String   sqlString=${SCRIPT}

Executar script via ARQUIVO no Banco de Dados
    [Arguments]          ${FILE}
    Execute SQL Script   sqlScriptFileName=${FILE}

Executar query no Banco de dados
    [Arguments]         ${QUERY}
    ${RESPONSE_QUERY}   Query   selectStatement=${QUERY}
    RETURN            ${RESPONSE_QUERY}

Confere se "${USER}" foi inserido com sucesso
    Check If Exists In Database    selectStatement=SELECT username FROM account WHERE username = '${USER}'

Limpar Tabela
    [Arguments]     ${TABELA}
    ${REGISTROS}    Row Count    selectStatement=SELECT * FROM ${TABELA}
    Run Keyword If  ${REGISTROS} > 0    Delete All Rows From Table    ${TABELA}
