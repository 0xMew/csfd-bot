*** Settings ***
Library    String
Library    Dialogs
Library    Collections
Library    OperatingSystem
Library    SeleniumLibrary
Library    DateTime


*** Variables ***
${file}   ./accs.txt
${username}    Getoshi
${password}    Kokot123
${URL}    https://www.csfd.sk/prihlasenie/
${cookies_confirmation}    xpath=//*[@id="didomi-notice-agree-button"]
${csfd_confirmation}    xpath=/html/body/div[2]/div[2]/div/div/div/span/div/footer/span/a   
${csfd_login_element}    xpath://*[@id="frm-loginForm-username"]
${csfd_password_element}    xpath://*[@id="frm-loginForm-password"]
${csfd_login_confirmation}    xpath:/html/body/div[3]/div[2]/div/div[2]/div/div/div[1]/section/div/form/div[2]/button

*** Test Cases ***
CSFD Rating - Bot to 200 rates
    Open Browser    ${URL}    Firefox
    Wait Until Element Is Visible    ${cookies_confirmation}
    Click Button    ${cookies_confirmation}
    Click Element    ${csfd_confirmation}
    Input Text    ${csfd_login_element}    ${username}
    Input Text    ${csfd_password_element}    ${password}
    Click Element    ${csfd_login_confirmation}
    Sleep    1s

    
    FOR    ${counter}    IN RANGE    1    230
        ${csfd_movie_id}    Evaluate    random.randint(1, 10000)    modules=random
        ${csfd_rating_randomizer}    Evaluate    random.randint(1, 6)    modules=random
        ${csfd_rating}    Set Variable    xpath:/html/body/div[2]/div[2]/div/div[1]/aside/div/div[1]/div[2]/span/a[${csfd_rating_randomizer}]   
        Go To    https://www.csfd.sk/film/${csfd_movie_id}
        ${element_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${csfd_rating}    timeout=1s
        Run Keyword If    ${element_visible}    Click Element    ${csfd_rating} 
        Sleep    1s
    END
    Close Browser
