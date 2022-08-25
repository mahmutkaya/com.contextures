*** Settings ***
Library     ../utilities/SeleniumUtils.py

Resource    BasePage.robot
Resource    ../resources/variables.robot
Resource    ../resources/keywords.robot


*** Variables ***
${homeLink}             //a[text()='Home']

*** Keywords ***
Home Page Opened
    Open Url With Chrome            ${baseUrl}
    Cookies are accepted
    Wait Until Element Is Visible   ${homeLink}
