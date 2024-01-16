*** Settings ***
Resource            ../resources/pages/cart.robot
Resource            ../resources/pages/home.robot
Resource            ../resources/main-functions.robot
Test Setup          Abrir navegador
Test Teardown       Fechar navegador


# *** Test Case ***
# CT001: Remover Produtos do Carrinho com Page Object Model
#     home.Acessar a página home do site
#     home.Digitar o primeiro nome no campo "First name"
#     home.Digitar o sobrenome no campo "Last name""
