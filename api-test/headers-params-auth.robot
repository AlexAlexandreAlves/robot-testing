*** Settings ***
Documentation       Exemplos da própria Library: https://github.com/bulkan/robotframework-requests/blob/master/tests/testcase.robot
...                 Doc da API do GitHub: https://developer.github.com/v3/
Library             RequestsLibrary
Library             Collections
Library             String
Resource            ./variables/my-user-and-passwords.robot

*** Variables ***
${GITHUB_HOST}      /https://github.com
${ISSUES_URL}       /AlexAlexandreAlves/robot-testing/issues

*** Test Cases ***
CT001: Fazendo autenticação básica (Basic Authentication)
    # Conectar com autenticação básica na API do GitHub
    Conectar com autenticação por token na API do GitHub
    Solicitar os dados do meu usuário

CT002: Usando parâmetros
    Conectar na API do GitHub sem autenticação
    Pesquisar issues com o state "open" e com o label "bug"

CT003: Usando headers

    # Conectar com autenticação básica na API do GitHub
    Conectar com autenticação por token na API do GitHub
    Enviar a reação "+1" para a issue "1"

CT004: Teste utilizando os dados de um arquivo externo
    Postar uma nova issue com label "robot framework"

*** Keywords ***
Conectar com autenticação por token na API do GitHub
    ${HEADERS}          Create Dictionary    Authorization=Bearer ${MY_GITHUB_TOKEN}
    Create Session      alias=mygithubAuth   url=${GITHUB_HOST}     headers=${HEADERS}     disable_warnings=True

Solicitar os dados do meu usuário
    ${MY_USER_DATA}     GET On Session          alias=mygithubAuth   url=${GITHUB_HOST}/AlexAlexandreAlves     expected_status=any
    Log                 Meus dados: ${MY_USER_DATA}
    Confere sucesso na requisição   ${MY_USER_DATA}

Conectar na API do GitHub sem autenticação
    Create Session      alias=mygithub        url=${GITHUB_HOST}     disable_warnings=True

Pesquisar issues com o state "${STATE}" e com o label "${LABEL}"
    &{PARAMS}           Create Dictionary    state=${STATE}       labels=${LABEL}
    ${MY_ISSUES}        GET On Session          alias=mygithub       url=${GITHUB_HOST}/AlexAlexandreAlves/robot-testing/issues    params=${PARAMS}    expected_status=any 
    Log                 Lista de Issues: ${MY_ISSUES}
    Confere sucesso na requisição   ${MY_ISSUES}


# O endpoint não funciona mais 

Enviar a reação "${REACTION}" para a issue "${ISSUE_NUMBER}"
    ${HEADERS}          Create Dictionary    Accept=application/vnd.github.squirrel-girl-preview+json
    ${MY_REACTION}      POST On Session    alias=mygithubAuth    url=https://github.com/repos/AlexAlexandreAlves/robot-testing/issues/comments/1/reactions
    ...                                 data={"content": "${REACTION}"}     headers=${HEADERS}
    Log                 Meus dados: ${MY_REACTION}
    Confere sucesso na requisição   ${MY_REACTION}


# O endpoint não funciona mais 

Postar uma nova issue com label "${LABEL}"
    ${BODY}         Format String    ${CURDIR}/data/post-issue.json
    ...             user_git=${MY_GITHUB_USER}
    ...             label=${LABEL}
    Log             Meu Body ficou:\n${BODY}
    ${RESPONSE}     POST On Session    alias=mygithubAuth    url=${ISSUES_URL}   data=${BODY}
    Confere sucesso na requisição   ${RESPONSE}

Confere sucesso na requisição
    [Arguments]      ${RESPONSE}
    Should Be True   '${RESPONSE.status_code}'=='200' or '${RESPONSE.status_code}'=='201'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}
