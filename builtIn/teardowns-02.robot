*** Settings ***
Suite Teardown     Limpar Dados Após Testes na Suíte
Test Teardown        Limpar Dados Após Cada Teste na Suíte
Documentation        Neste arquivo de teste estão detalhados os usos das seguintes keywords:
...    Modelo BDD: GIVEN, WHEN, AND, THEN
...    Suite Teardown: Faz uma execução após rodar a suite de testes
...    Test Teardown: Faz uma execução junto em cada teste

*** Test Cases ***
CT001 Login Bem-Sucedido
    [Tags]    login    sucesso
    Given Abrir Página de Login
    When Preencher Campos de Login    usuário    senha
    And Submeter Formulário de Login
    Then Verificar Login Bem-Sucedido

CT002 Login Com Falha
    [Tags]    login    falha
    Abrir Página de Login
    Preencher Campos de Login    usuário_inexistente    senha_incorreta
    Submeter Formulário de Login
    Verificar Login Com Falha

CT003 Forçando teste a passar com Pass
    [Tags]    login    sucesso
    Abrir Página de Login
    Preencher Campos de Login    usuário    senha
    Submeter Formulário de Login
    Verificar Login Bem-Sucedido
    Pass Execution  message=Login bem-sucedido, forçando aprovação

CT004 Forçando teste a falhar com Fail
    [Tags]    login    falha
    Abrir Página de Login
    Preencher Campos de Login    usuário_inexistente    senha_incorreta
    Submeter Formulário de Login
    Verificar Login Com Falha
    Fail     msg=Login falhou pois estou forçando a falha

*** Keywords ***

Abrir Página de Login
    Log    Abrindo a página de login

Preencher Campos de Login
    [Arguments]    ${username}    ${password}
    Log    Preenchendo campos de login com usuário: ${username} e senha: ${password}

Submeter Formulário de Login
    Log    Submetendo formulário de login

Verificar Login Bem-Sucedido
    Log    Verificando login bem-sucedido

Verificar Login Com Falha
    Log    Verificando login com falha

Limpar Dados Após Testes na Suíte
   Log    Limpando dados após a execução da suíte de teste

Limpar Dados Após Cada Teste na Suíte
   Log    Limpando dados após a execução de cada de teste