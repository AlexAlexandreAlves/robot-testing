*** Settings ***

Documentation   http://robotframework.org/robotframework/latest/libraries/Process.html

...    Start Process: Inicia o processo mas não aguarda uma reposta
...    Terminate Process: Encerra um processo
...    Run Keyword And Continue On Failure: Executa uma Keyword e não encerra em caso de falha
...    Should Be Equal As Integers: Verifica se o retorno é um numero inteiro
...    stderr: O stderr printa o erro que o script retornou
...    stdout: A saída que o script retornou
...    Run Process    mkdir robot_teste   cwd=${CURDIR}   shell=True: Executa um comando como se estive no prompt
...    de comando do windows
...    
Library         Process

*** Test Cases ***
CT001: Abrindo programas
    Abra e feche o Notepad

CT002: Executando e aguardando scripts/programas
    Execute um script e aguarde ele finalizar com sucesso
    Execute um script e aguarde ele finalizar com falha

CT003: Execute comandos de prompt
    Executando comandos diversos de prompt

*** Keywords ***
Abra e feche o Notepad
    ## Inicia o processo e não espera por resposta dele
    ## Lembrete: Para caminhos no Windows use barras duplas!!
    ${MEU_PROCESSO}     Start Process    C:\\WINDOWS\\system32\\notepad.exe
    Sleep  3s
    Terminate Process   ${MEU_PROCESSO}   kill=True

Verifica sucesso na execução do processo
    [Arguments]      ${PROCESSO}
    ## RC igual a zero indica SUCESSO na execução do processo
    Run Keyword And Continue On Failure    Should Be Equal As Integers    ${PROCESSO.rc}    0
    ...   msg=ATENÇÃO! O seu processo não executou com sucesso
    ## Se ocorreu erro, vamos printar ele
    Run Keyword If   ${PROCESSO.rc}!=0   Log   FALHA OCORRIDA: "${PROCESSO.stderr}"

Execute um script e aguarde ele finalizar com sucesso
    ## Inicia o processo e espera pelo seu término
    ${MEU_PROCESSO}     Run Process     python   hello_world.py
    Log    Resultado da execução (sucesso/falha): ${MEU_PROCESSO.rc}
    Log    Saída da execução: ${MEU_PROCESSO.stdout}
    Verifica sucesso na execução do processo      ${MEU_PROCESSO}

Execute um script e aguarde ele finalizar com falha
    ## Inicia o processo e espera pelo seu término
    ${MEU_PROCESSO}     Run Process     python   hello_world_fail.py
    Log    Resultado da execução (sucesso/falha): ${MEU_PROCESSO.rc}
    Log    Saída da execução: ${MEU_PROCESSO.stdout}
    Log    Falha da execução: ${MEU_PROCESSO.stderr}
    Verifica sucesso na execução do processo      ${MEU_PROCESSO}

Executando comandos diversos de prompt
    ## Use o atributo shell=True para habilitar funções de shell,
    ## como criar um diretório, por exemplo
    ## CURDIR = Variavel do robot que referencia o diretório corrente
    Run Process    mkdir robot_teste   cwd=${CURDIR}   shell=True
