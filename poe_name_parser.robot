*** Settings ***
Library    String
Library    Dialogs
Library    Collections
Library    OperatingSystem
Library    SeleniumLibrary
Library    DateTime
Library    BuiltIn


*** Variables ***
${URL}=    https://web.archive.org/web/20240717141222/https://poe.ninja/builds/necropolis?type=depthsolo
${file}=    ./poe_accs.txt


*** Test Cases ***
CSFD - Poe name parser from the archive
    Open Browser    ${URL}    headlessfirefox
    Sleep    10s
    FOR    ${counter}    IN RANGE    1    101
       ${poe_nick}    Get Text    xpath:/html/body/div[5]/div/div[2]/div[2]/main/div/div/div/table/tbody/tr[${counter}]/td[1]/a/span
       Append To File    ${file}    ${poe_nick}\n
    END
    Close Browser
    