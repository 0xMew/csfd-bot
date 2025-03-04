*** Settings ***
Library    String
Library    Dialogs
Library    Collections
Library    OperatingSystem
Library    SeleniumLibrary
Library    DateTime
Library    BuiltIn


*** Variables ***
${URL}=    https://www.csfd.sk/ 
${cookies_confirmation}=    xpath=//*[@id="didomi-notice-agree-button"]
${csfd_confirmation}=    xpath=/html/body/div[2]/div[2]/div/div/div/span/div/footer/span/a
${file_done_accounts}   ./accs.txt
${file_future_account}    ./future_accs.txt
${password}    Kokot123
${email_copy_button}    xpath:/html/body/main/div/div[2]/section/div[1]/div/div/div[1]/button[2]
${email_service_url}    "https://minmail.app/10-minute-mail"
${email_location}    xpath:/html/body/main/div/div[2]/section/div[2]/div/div/div/div/div/div/div/div/div[2]/div[1]/h2
${index}=    0

*** Test Cases ***
CSFD - The return of the king
    FOR    ${counter}    IN RANGE    1    11
    #Momentalne trva zaregistrovat jeden ucet 42 sekund
    Open Browser    ${URL}    headlessfirefox

    Wait Until Element Is Visible    ${cookies_confirmation}
    Click Button    ${cookies_confirmation}
    Click Element    ${csfd_confirmation}
    Go To    https://www.csfd.sk/registracia/

    ${file_content}    Get File    ${file_future_account}
    @{user_list}    Split To Lines    ${file_content} 
    ${user}    Set Variable    ${user_list}[${index}]
    Click Element    xpath://*[@id="frm-registrationForm-nick"]
    Input Text    xpath://*[@id="frm-registrationForm-nick"]    ${user}


    Execute JavaScript    window.open(${email_service_url}, "_blank")
    ${handles}=    Get Window Handles
    Switch Window    ${handles}[-1]
    Sleep    6s
    Click Element    xpath:/html/body/div/div[2]/div[2]/div[2]/div[2]/button[1]
    Click Element    ${email_copy_button}
    Sleep    2s

    Switch Window    ${handles}[0]
    Location Should Contain    csfd.sk
    Click Element    xpath://*[@id="frm-registrationForm-email"]
    Press Keys    xpath=//*[@id="frm-registrationForm-email"]    CTRL+v
    Click Element    xpath://*[@id="frm-registrationForm-password"]
    Input Text   xpath://*[@id="frm-registrationForm-password"]    Kokot123
    Click Element    xpath://*[@id="frm-registrationForm-password_check"]
    Input Text    xpath://*[@id="frm-registrationForm-password_check"]    Kokot123
    Click Element    xpath://*[@id="frm-registrationForm-terms_and_conditions"]
    Click Button    xpath:/html/body/div[2]/div[2]/div/form/div/div/div[1]/div[1]/section/div/div[3]/button

    Switch Window    ${handles}[1]
    Maximize Browser Window
    Execute JavaScript    window.scrollBy(0, 300)
    Sleep    5s
    Wait Until Element Is Visible    ${email_location}
    Click Element    ${email_location}
    Execute JavaScript    document.querySelector("[class*='h-[400px]'][class*='overflow-auto']").scrollTop += 800;
    Click Element    xpath:/html/body/main/div/div[2]/section/div[2]/div/div/div/div/div/div[2]/div/table/tbody/tr/td/table/tbody/tr[2]/td/table/tbody/tr/td/table/tbody/tr[1]/td/table/tbody/tr/td/p[3]
    ${time}    Get Time    %Y-%m-%d %H:%M:%S
    Append To File    ${file_done_accounts}    ${user}:${password} - ${time}\n
    Remove From List    ${user_list}    ${index}
    ${updated_content}    Evaluate    '\\n'.join(${user_list})
    Create File    ${file_future_account}    ${updated_content}
    Close All Browsers
    END


