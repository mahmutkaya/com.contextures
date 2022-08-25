*** Keywords ***
Open Url
    [Arguments]             ${url}
    Register Keyword To Run On Failure      NONE
    Maximize Browser Window
    Go To                   ${url}
    Wait For Condition      return !!document.body

Open Url With Chrome
    [Arguments]     ${url}
    # create a folder for downloads
    ${download directory}    Join Path   ${OUTPUT DIR}  downloads
    Create Directory         ${download directory}
    Set Suite Variable       \${download directory}
    ${chrome options}=       Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${prefs}=                Create Dictionary    download.default_directory=${download directory}
    Call Method              ${chrome options}    add_experimental_option    prefs    ${prefs}
    Create Webdriver         Chrome    chrome_options=${chrome options}

    Open Url                 ${url}

Open Url With Firefox
    [Arguments]             ${url}
    Create Webdriver        Firefox
    Open Url                ${url}

Scroll to Element
    [Arguments]  ${element}
    Run Keyword and Ignore Error  Scroll Element Into View  ${element}

Default Teardown
    Run Keyword If Test Failed    Capture Page Screenshot
    Close Browser
