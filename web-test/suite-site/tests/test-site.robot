*** Settings ***
Resource            ../resources/pages/cart.robot
Resource            ../resources/pages/home.robot
Resource            ../resources/main-functions.robot
Test Setup          Abrir navegador
Test Teardown       Fechar navegador

*** Test Case ***
Caso de Teste com PO 01: Remover Produtos do Carrinho
    home.Acessar a página home do site
    home.Digitar o primeiro nome no campo "First Name"
    home.Digitar o sobrenome no campo"Last Name"
