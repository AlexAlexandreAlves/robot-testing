*** Settings ***
Documentation        Neste arquivo de teste estão detalhados os usos das seguintes keywords:
...    No Operation: Literalmente não possui uma operação, mas o teste passa
...    Run Keyword And Ignore Error: Vai executar a falha em uma keyword e continuar, a suite vai passar
...    Should Be True: Espera que o resultado da keyword seja verdadeiro
...    Run Keyword And Continue On Failure: A keyword e suite falharão mas continuará a execução, não vai interromper
...    Run Keyword if  "${STOP}"=="Para tudo!"   Fatal Error: Encera a execução da suite se tiver um erro fatal

*** Test Cases ***
#### FALHAS PREVISTAS
CT001: Teste lidando com falhas previstas
    Essa keyword vai falhar, mas vou ignorar (a suíte irá passar)!
    Essa keyword encerra a execução da suíte!    Não pare, por favor!
    Essa keyword vai falhar, mas é uma falha que deve acontecer para meu teste ser considerado OK!
    Essa keyword vai falhar, não vou ignorar (a suíte irá falhar), mas vou continuar a execução!
    Essa keyword encerra a execução da suíte!    Para tudo!

CT002: Teste de continuação da suíte
    No Operation

CT003: Teste de continuação da suíte
    No Operation

*** Keywords ***
Essa keyword vai falhar, mas vou ignorar (a suíte irá passar)!
    Run Keyword And Ignore Error    Should Be True    "May" == "João"
    Log   Continuo a execução!!

Essa keyword vai falhar, mas é uma falha que deve acontecer para meu teste ser considerado OK!
    Run Keyword And Expect Error    '"May" == "João"' should be true.       Should Be True    "May" == "João"

Essa keyword vai falhar, não vou ignorar (a suíte irá falhar), mas vou continuar a execução!
    Run Keyword And Continue On Failure     Should Be True    "May" == "João"
    Log   Continuo a execução 1!!
    Log   Continuo a execução 2!!
    Log   Continuo a execução 3!!

Essa keyword encerra a execução da suíte!
    [Arguments]     ${STOP}
    Run Keyword if  "${STOP}"=="Para tudo!"   Fatal Error   msg=Para tudo, não adianta continuar com essa falha aqui!!!



    