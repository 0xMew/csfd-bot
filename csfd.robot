*** Settings ***
Library    String
Library    Dialogs
Library    Collections
Library    OperatingSystem
Library    SeleniumLibrary


*** Variables ***
${URL}=    https://www.csfd.sk/
${cookies_confirmation}=    xpath=//*[@id="didomi-notice-agree-button"]
${csfd_confirmation}=    xpath=/html/body/div[2]/div[2]/div/div/div/span/div/footer/span/a

*** Test Cases ***
CSFD - The return of the king
    Open Browser    ${URL}    Firefox
    Wait Until Element Is Visible    ${cookies_confirmation}
    Click Button    ${cookies_confirmation}
    Click Element    ${csfd_confirmation}
    Go To    https://www.csfd.sk/registracia/
    Go To    https://temp-mail.org/en/
    Sleep    10s
    Click Element    xpath=/html/body/div[1]/div/div/div[2]/div[1]/form/div[2]/button
    Sleep    2s 
    Go To    https://www.csfd.sk/registracia/
    Click Element    xpath://*[@id="frm-registrationForm-email"]
    Press Keys    xpath=//*[@id="frm-registrationForm-email"]    CTRL+v
    
