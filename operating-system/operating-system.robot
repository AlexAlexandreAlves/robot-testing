*** Settings ***

Documentation   http://robotframework.org/robotframework/latest/libraries/OperatingSystem.html
...     Create File: Cria um arquivo no destino designado
...    Copy File: Copia o arquivo no destino designado
...    Get File: Pega o arquivo
...    Get File Size: Pega o tamanho do arquivo
...    Get Binary File: Pega o arquivo do tipo binario
...    Get Binary File Size: Pega o tamanho do arquivo do tipo binario
...    List Directory: Lista arquivos no diretorio
...    Remove File: Remove arquivos

Library         OperatingSystem

*** Test Cases ***
CT001: Criando arquivos
    Criando um arquivo texto
    Criando um arquivo JSON

CT002: Copiando arquivos
    Copiando meu arquivo

CT003: Lendo meu arquivo
    Lendo o conteúdo
    Lendo o binário

CT004: Excluindo arquivos
    Listando arquivos do meu diretório
    Excluir arquivo     arquivo_TEXTO_COPIA.txt
    Excluir arquivo     arquivo_JSON_COPIA.json
    Listando arquivos do meu diretório

*** Keywords ***
Criando um arquivo texto
    Create File         ./my-files/arquivo_TEXTO.txt     Esse curso vai me tornar um ninja em Robot Framework!!!!

Criando um arquivo JSON
    Create File         ./my-files/arquivo_JSON.json     {"teste01": "valor01", "teste02": 2, "teste03": [1, 2, 3]}

Copiando meu arquivo
    Copy File           ./my-files/arquivo_TEXTO.txt     ./my-files/arquivo_TEXTO_COPIA.txt
    Copy File           ./my-files/arquivo_JSON.json     ./my-files/arquivo_JSON_COPIA.json

Lendo o conteúdo
    ## O conteúdo é retornado em STRING
    ${MEU_ARQUIVO}      Get File          ./my-files/arquivo_TEXTO.txt
    ${SIZE}             Get File Size     ./my-files/arquivo_TEXTO.txt
    Log   ${MEU_ARQUIVO}

Lendo o binário
    ## O binário é retornado
    Should Exist        ./my-files/arquivo_PDF.pdf      msg=O arquivo não existe!! Verifique!
    ${MEU_ARQUIVO}      Get Binary File   ./my-files/arquivo_PDF.pdf
    ${SIZE}             Get File Size     ./my-files/arquivo_PDF.pdf
    Log   ${MEU_ARQUIVO}

Listando arquivos do meu diretório
    List Directory      ./my-files

Excluir arquivo
    [Arguments]         ${ARQUIVO}
    Remove File         ./my-files/${ARQUIVO}
