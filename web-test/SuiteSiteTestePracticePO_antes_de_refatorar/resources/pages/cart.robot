*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Excluir o produto do carrinho
    Click Element    xpath=//*[@class="cart_quantity_delete"]


Conferir se o carrinho fica vazio
    Wait Until Element Is Visible   xpath=//*[@id="center_column"]/p[@class='alert alert-warning']
    Element Text Should Be          xpath=//*[@id="center_column"]/p[@class='alert alert-warning']    Your shopping cart is empty.
