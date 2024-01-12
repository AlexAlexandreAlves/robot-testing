*** Settings ***
Documentation       Fazendo o uso do for para iterar entre todos os personagens da variavel CHARACTER.


*** Variables ***
@{CHARACTERS}=      Luke    Leia    Yoda    Obiwan


*** Tasks ***
Loop over a list of items and log each of them
    FOR    ${robot}    IN    @{CHARACTERS}
        Log    ${robot}
    END