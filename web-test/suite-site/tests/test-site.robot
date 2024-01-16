*** Settings ***
Resource            ../resources/pages/cart.robot
Resource            ../resources/pages/home.robot
Resource            ../resources/main-functions.robot
Test Setup          Abrir navegador
Test Teardown       Fechar navegador

*** Test Case ***
Caso de Teste com PO 01: Remover Produtos do Carrinho
    home.Acessar a página home do site
    home.Digitar o primeiro nome "${TEXT_FIRST_NAME}" no "First Name"
    home.Digitar o ultimo nome "${TEXT_LAST_NAME}" no "Last Name"
