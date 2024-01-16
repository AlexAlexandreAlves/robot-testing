*** Settings ***
Resource            ../resources/pages/cart.robot
Resource            ../resources/pages/home.robot
Resource            ../resources/main-functions.robot
Test Setup          Abrir navegador
Test Teardown       Fechar navegador

*** Test Case ***
Caso de Teste com PO 01: Remover Produtos do Carrinho
    Home.Acessar a página home do site
    Home.Digitar o primeiro nome "${TEXT_FIRST_NAME}" no "First Name"
    Home.Digitar o ultimo nome "${TEXT_LAST_NAME}" no "Last Name"
