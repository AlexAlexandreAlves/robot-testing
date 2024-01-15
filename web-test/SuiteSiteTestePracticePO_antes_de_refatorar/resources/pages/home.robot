*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
# ${BROWSER}      chrome
${URL}          http://automationpractice.com

*** Keywords ***

#### Ações

Adicionar o produto "${PRODUTO}" no carrinho
    Digitar o nome do produto "${PRODUTO}" no campo de pesquisa
    Clicar no botão pesquisar
    Clicar no botão "Add to Cart" do produto
    Clicar no botão "Proceed to checkout"


Acessar a página home do site
    Go To               ${URL}
    Wait Until Element Is Visible    xpath=//*[@id="block_top_menu"]/ul
    Title Should Be     My Store

Digitar o nome do produto "${PRODUTO}" no campo de pesquisa
    Input Text          name=search_query    ${PRODUTO}

Clicar no botão pesquisar
    Click Element       name=submit_search

Clicar no botão "Add to Cart" do produto
    Wait Until Element Is Visible   xpath=//*[@id="center_column"]//img[@alt="Faded Short Sleeve T-shirts"]
    Click Element                   xpath=//*[@id="center_column"]//img[@alt="Faded Short Sleeve T-shirts"]
    Wait Until Element Is Visible   xpath=//*[@id="add_to_cart"]/button
    Click Button                    xpath=//*[@id="add_to_cart"]/button

Clicar no botão "Proceed to checkout"
    Wait Until Element Is Visible   xpath=//*[@id="layer_cart"]//a[@title="Proceed to checkout"]
    Click Element                   xpath=//*[@id="layer_cart"]//a[@title="Proceed to checkout"]

