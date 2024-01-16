*** Settings ***
Library     RequestsLibrary
Library     OperatingSystem
Library     Collections

*** Variables ***
${MEU_DICT_ESPERADO}    {"primeiro_nome": "Alex", "nomes_do_meio": "Alexandre", "ultimo_nome": "Alves", "apelido": "Ale"}

*** Test Cases ***
Exemplo: Conferindo JSON complexo
    Pega JSON
    # Confere objetos e sub-objetos do JSON
    Confere listas no JSON

*** Keywords ***
Pega JSON
    ${MEU_ARQUIVO_STRING}     Get File    ${CURDIR}/data/json-complexo.json
    Log     ${MEU_ARQUIVO_STRING}
    ### A Get File retorna ums STRING, vamos transformá-la em JSON
    ${MEU_ARQUIVO_JSON}     Evaluate     [json.loads($MEU_ARQUIVO_STRING)]
    Log     ${MEU_ARQUIVO_JSON}
    RETURN        ${MEU_ARQUIVO_JSON}

Confere objetos e sub-objetos do JSON
    ${MEU_ARQUIVO_STRING}     Pega JSON
    ${MEU_DICT_ESPERADO}     Evaluate     [json.loads($MEU_DICT_ESPERADO)]

    # Conferindo um sub-dicionário dentro de um JSON
    Dictionary Should Contain Sub Dictionary    ${MEU_DICT_ESPERADO["pessoa"]["nome"]}
    ...         ${MEU_ARQUIVO_STRING}

    # ### Conferindo campo a campo 
    # List Should Contain Value    ${MEU_JSON_COMPLEXO["pessoa"]["nome"]}    primeiro_nome    Alex

    # Chegando em um valor dentro de uma lista de dicionários
    # Log     ${MEU_JSON_COMPLEXO}
    # Dictionary Should Contain Item    ${MEU_JSON_COMPLEXO["pessoa"]["hobbies"]["livros"][0]}    titulo    O Símbolo Perdido
    # List Should Contain Value    ${MEU_JSON_COMPLEXO["pessoa"]["hobbies"]["livros"][1]}    titulo    Sócios no Crime
    # List Should Contain Value    ${MEU_JSON_COMPLEXO["pessoa"]["hobbies"]["livros"][2]}    titulo    Fortaleza Digital

Confere listas no JSON
    ${MEU_ARQUIVO_JSON}     Pega JSON

    ### Conferindo valor contido em uma lista
    List Should Contain Value    ${MEU_ARQUIVO_JSON["pessoa"]["hobbies"]["games"]["PC"]}    Aika

    # ### Pegando o valor de uma determinada posição da lista
    # ${GAME}     Get From List    ${MEU_ARQUIVO_JSON["pessoa"]["hobbies"]["games"]["Xbox"]}    2
    # Log         Game da posição 2 da lista: ${GAME}

    # ### Conferindo se não há duplicidade de itens da lista
    # List Should Not Contain Duplicates    ${MEU_ARQUIVO_JSON["pessoa"]["hobbies"]["games"]["Xbox"]}

    # ### Percorrendo uma lista
    # @{LISTA_DE_LIVROS}   Get From Dictionary   ${MEU_ARQUIVO_JSON["pessoa"]["hobbies"]}   livros    default
    # FOR  ${LIVRO}   IN   @{LISTA_DE_LIVROS}
    #     Log   Título: ${LIVRO["titulo"]}\nAutor: ${LIVRO["autor"]}
    # END
