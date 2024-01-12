*** Settings ***
Library         DateTime
Test Teardown   Teardown do meu teste
Test Timeout    1 seconds

Documentation        Neste arquivo de teste estão detalhados os usos das seguintes keywords e libs:
...    Test Timeout: Necessario que um teste esteja dentro de um Test Teardown
...    poderão demorar no máximo um segundo para serem executados
...    Run Keyword If Timeout Occurred: Considera o timeout global e só funciona dentro de um Test Teardown, considerando
...    1 seg para cada teste singularmente e não a suite
...    Sleep: Força um tempo especifico que não seja o tempo definido globalmente
...    Wait Until Keyword Succeeds: Aguarda um tempo especifico para passar o teste, neste caso tenta 60x e passa quando chega no segundo 15


*** Test Cases ***
#### TIMEOUT
CT001: Teste lidando com o timeout do teste
    Simular espera do teste    2s

#### ESPERANDO UMA KEYWORD
CT002: Teste de espera
    [Timeout]   2 minutes
    Esperar uma keyword obter sucesso!

*** Keywords ***
Teardown do meu teste
    Run Keyword If Timeout Occurred     Log  Esse teste demorou demais, possível problema de performance!

Simular espera do teste
    [Arguments]     ${TEMPO}
    Sleep           ${TEMPO}

Esperar uma keyword obter sucesso!
    Wait Until Keyword Succeeds    60x   1 seconds   Essa keyword só passa se estivermos no segundo 15!

Essa keyword só passa se estivermos no segundo 15!
    ${HORA_ATUAL}   Get Current Date
    ${HORA_ATUAL}   Convert Date    ${HORA_ATUAL}    datetime
    Log    Hora atual: ${HORA_ATUAL.hour}\nMinuto atual: ${HORA_ATUAL.minute}\nSegundo atual: ${HORA_ATUAL.second}
    Run Keyword If    "${HORA_ATUAL.second}"!="15"    Fail    msg=Ainda não estamos no segundo 15!!
