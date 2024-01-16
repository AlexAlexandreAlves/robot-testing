*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
${BROWSER}      headlesschrome
${URL}          http://automationpractice.com

*** Keywords ***
#### Setup e Teardown
Abrir navegador
    Open Browser        about:blank   ${BROWSER}

Fechar navegador
    Capture Page Screenshot
    Close Browser
