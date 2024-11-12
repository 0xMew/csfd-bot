*** Settings ***
Library    String
Library    Dialogs
Library    Collections
Library    OperatingSystem
Library    SeleniumLibrary
Library    DateTime


*** Variables ***
${file}   ./accs.txt
${password}    Kokot123


*** Test Cases ***
CSFD Rating - Bot to 200 rates
    ${time}    Get Time    %Y-%m-%d %H:%M:%S