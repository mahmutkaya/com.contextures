*** Settings ***
Library     ../utilities/SeleniumUtils.py

Resource    ../resources/variables.robot
Resource    ../resources/keywords.robot


*** Variables ***
${cookiesIframe}        //iframe[@role]
${acceptAllButton}      //button[span="Accept All"]

*** Keywords ***
Cookies are accepted
    ${present}=       Run Keyword And Return Status    Wait Until Element Is Visible   ${cookiesIframe}  13s
    Run Keyword If    ${present}                       Accept Cookies

Accept Cookies
    Wait Until Element Is Visible   ${cookiesIframe}
    Select Frame                    ${cookiesIframe}
    Wait Until Element Is Visible   ${acceptAllButton}
    Click Element                   ${acceptAllButton}