*** Settings ***
Library    String
Library    Dialogs
Library    Collections
Library    OperatingSystem
Library    SeleniumLibrary
Library    DateTime
Library    BuiltIn


*** Variables ***
${URL}=    https://poe.ninja/builds/settlers/
${file}=    ./future_accs.txt
${validation_regex}    ^[A-Za-z0-9_]+$
${no_underscore_start}    ^[^_]
${cookie_confirmation}    xpath:/html/body/div[8]/div[2]/div[2]/div[2]/div[2]/button[1]


*** Test Cases ***
CSFD - Poe name parser from the archive
    #Tento parser funguje iba z archivu, z live poe ninja je iny xpath, na ktory treba spravit zvlast verziu toho scriptu
    Open Browser    ${URL}    Firefox
    Wait Until Element Is Visible    ${cookie_confirmation}
    Click Element    ${cookie_confirmation}
    Sleep    10s
    FOR    ${counter}    IN RANGE    1    101
       ${poe_nick}    Get Text    xpath:/html/body/div[5]/div/div[2]/div[2]/main/div/div/div/table/tbody/tr[${counter}]/td[1]/a/span
       ${poe_nick_length}    Get Length    ${poe_nick}
       ${valid_rest}=    Run Keyword And Return Status    Should Match Regexp    ${poe_nick}    ${validation_regex}
       ${valid_start}=    Run Keyword And Return Status    Should Match Regexp    ${poe_nick}    ${no_underscore_start}
       
       IF    ${poe_nick_length} < 3 or ${poe_nick_length} > 12
            Continue For Loop
       END
       IF    not ${valid_rest}
            Continue For Loop
       END
       IF    not ${valid_start}
            Continue For Loop
       END
        Append To File    ${file}    ${poe_nick}\n 
    END
    Close Browser
    