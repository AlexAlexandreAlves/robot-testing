*** Settings ***
Library         DateTime
Documentation   http://robotframework.org/robotframework/latest/libraries/DateTime.html
...     Get Current Date: Pega a data atual com base no OS
...    Convert Time: Convert a data com base no que é permitido pela librarie
...    Add Time To Date: Adiciona horas, dias, minutos, com base na librarie
...    Subtract Time From Date: Subtrai horas, dias, minutos com base na librarie

*** Test Cases ***
CT001: Pegando data e hora atuais
    Teste pegando data atual
    Teste pegando data e hora atuais
    Teste pegando ano - mês - dia separadamente

CT002: Manipulando o tempo
    Trabalhando com tempo

CT003: Cálculos com data
    Adicionando tempo de data
    Subtraindo tempo de data

*** Keywords ***
Teste pegando data atual
    ${AGORA}    Get Current Date     result_format=%d-%m-%y
    Log         ${AGORA}

Teste pegando data e hora atuais
    ${AGORA}    Get Current Date     result_format=%Y-%m-%dT%H:%M:%S
    Log         ${AGORA}

Teste pegando ano - mês - dia separadamente
    ${HOJE}     Get Current Date
    ${HOJE}     Convert Date   ${HOJE}   datetime
    Log         ${HOJE.day}-${HOJE.month}-${HOJE.year}

Trabalhando com tempo
    ${HORA}     Convert Time	1 minute 30 seconds
    Log         São ${HORA} segundos em 1 minuto e 30 segundos!
    ${HORA}     Convert Time	5400   verbose
    Log         5400 segundos é ${HORA}!
    ${HORA}     Convert Time	5500   timer   exclude_millis=yes
    Log         5500 segundos é ${HORA}!

Adicionando tempo de data
    ${HOJE}    Get Current Date
    ${DATAMAIS4HORAS}   Add Time To Date    ${HOJE}   4 hours   result_format=%d-%m-%Y %H:%M:%S
    Log         Data Atual: ${HOJE} - Data Mais 4 Horas: ${DATAMAIS4HORAS}
    ${HOJE}    Get Current Date
    ${DATAMAIS7DIAS}   Add Time To Date    ${HOJE}   7 days    result_format=%d-%m-%Y %H:%M:%S
    Log         Data Atual: ${HOJE} - Data Mais 7 Dias: ${DATAMAIS7DIAS}

Subtraindo tempo de data
    ${HOJE}    Get Current Date
    ${MENOS25MIN}   Subtract Time From Date    ${HOJE}   25 minutes    result_format=%d-%m-%Y %H:%M:%S
    Log         Hoje: ${HOJE} - Data menos 25 minutos: ${MENOS25MIN}
    ${HOJE}    Get Current Date
    ${MENOS2DIAS}   Subtract Time From Date    ${HOJE}   2 days        result_format=%d-%m-%Y %H:%M:%S
    Log         Hoje: ${HOJE} - Data menos 2 dias: ${MENOS2DIAS}
