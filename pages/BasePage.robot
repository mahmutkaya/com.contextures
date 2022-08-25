*** Settings ***
Library     ../utilities/SeleniumUtils.py

Resource    ../resources/variables.robot
Resource    ../resources/keywords.robot


*** Variables ***
${cookiesIframe}        //iframe[@role]
${acceptAllButton}      //button[span="Accept All"]

*** Keywords ***
Cookies are accepted
    Wait Until Element Is Visible   ${cookiesIframe}
    Select Frame                    ${cookiesIframe}
    Wait Until Element Is Visible   ${acceptAllButton}
    Click Element                   ${acceptAllButton}