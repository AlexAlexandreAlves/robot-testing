*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
${HOME_URL}                 https://phptravels.com/demo/
${HOME_TITLE}               Book Your Free Demo Now - Phptravels
${FIRST_NAME_INPUT}         input.first_name.form-control
${LAST_NAME_INPUT}          input.last_name.form-control
${TEXT_FIRST_NAME}          Zéca
${TEXT_LAST_NAME}           Pagodinho

*** Keywords ***
#### Ações
Adicionar o nome e sobrenome nos campos
    Digitar o primeiro nome no campo "First name"
    Digitar o sobrenome no campo "Last name"


Acessar a página home do site
    Go To               ${HOME_URL}
    Title Should Be     ${HOME_TITLE}

Digitar o primeiro nome no campo "${FIRST_NAME_INPUT}"
    Input Text          ${FIRST_NAME_INPUT}    ${TEXT_FIRST_NAME}

Digitar o sobrenome no campo "${LAST_NAME_INPUT}"
    Input Text          ${LAST_NAME_INPUT}    ${TEXT_LAST_NAME}

