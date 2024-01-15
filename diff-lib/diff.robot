*** Settings ***
Library    DiffLibrary

*** Test Cases ***
CT001: Compare Strings
    Comparando as strings
    
*** Keywords ***
Comparando as strings
    ${file01}=    Set Variable    ./lorem01.txt
    ${file02}=    Set Variable    ./lorem02.txt
    
    ${differences}=    Diff Files    ${file01}    ${file02}
    
    Log    Differences: ${differences}
