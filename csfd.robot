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
    Execute JavaScript    window.open("https://www.fantasynamegenerators.com/lamia-names.php", "_blank")
    ${handles}=    Get Window Handles
    Switch Window    ${handles}[-1]
    Sleep    3s
    Location Should Contain    fantasynamegenerators.com
    
    Wait Until Element Is Enabled    xpath:/html/body/div[3]/div/div/div[3]/div[1]/button[2]
    Click Element    xpath:/html/body/div[3]/div/div/div[3]/div[1]/button[2]
    Wait Until Element Is Visible     xpath://*[@id="result"]
    Click Element    xpath://*[@id="result"]
    Press Keys    None    CTRL+c
    Sleep    1s 
    Switch Window    ${handles}[0]
    Sleep    2s
    Click Element    xpath://*[@id="frm-registrationForm-nick"]
    Press Keys    xpath=//*[@id="frm-registrationForm-nick"]    CTRL+v
    
    Execute JavaScript    window.open("https://etempmail.net/10minutemail", "_blank")
    ${handles}=    Get Window Handles
    Switch Window    ${handles}[2]
    Wait Until Element Is Visible    xpath:/html/body/div[4]/div[2]/div[1]/div[2]/div[2]/button[1]/p
    Click Element    xpath:/html/body/div[4]/div[2]/div[1]/div[2]/div[2]/button[1]/p
    Sleep    10s
    Click Element    xpath=//*[@id="btn_copy"]
    Sleep    2s

    Switch Window    ${handles}[0]
    Location Should Contain    csfd.sk
    Click Element    xpath://*[@id="frm-registrationForm-email"]
    Press Keys    xpath=//*[@id="frm-registrationForm-email"]    CTRL+v
    Click Element    xpath://*[@id="frm-registrationForm-nick"]
    Click Element    xpath://*[@id="frm-registrationForm-password"]
    Input Text   xpath://*[@id="frm-registrationForm-password"]    Kokot123
    Click Element    xpath://*[@id="frm-registrationForm-password_check"]
    Input Text    xpath://*[@id="frm-registrationForm-password_check"]    Kokot123
    Click Element    xpath://*[@id="frm-registrationForm-terms_and_conditions"]
    Click Button    xpath:/html/body/div[2]/div[2]/div/form/div/div/div[1]/div[1]/section/div/div[3]/button

    Switch Window    ${handles}[2]
    Sleep    5s
    Click Element    xpath://*[@id="cookie_close"]
    Maximize Browser Window
    Execute JavaScript    window.scrollBy(0, 800)
    Sleep    5s
    Wait Until Element Is Visible    xpath:/html/body/div[1]/main/div/div[1]/div[2]/div/div/div[1]/div[2]/div/div[2]
    Click Element    xpath:/html/body/div[1]/main/div/div[1]/div[2]/div/div/div[1]/div[2]/div/div[2]
    Sleep    2s
    Select Frame    xpath:/html/body/div[1]/main/div[1]/div[1]/div[2]/div/div/div[2]/div[2]/div[3]/iframe
    Wait Until Element Is Visible    xpath:/html/body/table/tbody/tr/td/table/tbody/tr[2]/td/table/tbody/tr/td/table/tbody/tr[1]/td/table/tbody/tr/td/p[3]/a
    
    #Click Element    xpath:/html/body/table/tbody/tr/td/table/tbody/tr[2]/td/table/tbody/tr/td/table/tbody/tr[1]/td/table/tbody/tr/td/p[3]/a


