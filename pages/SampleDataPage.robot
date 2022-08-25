*** Settings ***
Library     ../utilities/SeleniumUtils.py
Library     OperatingSystem

Resource    BasePage.robot
Resource    ../resources/variables.robot
Resource    ../resources/keywords.robot

*** Variables ***
${SampleDataHeaderText}             //h4[text()='Sample Data']
${SampleDataTable}                  //table[@bordercolor='#6666FF']
${SampleDataTableHeaders}           ${SampleDataTable}//tr[@bgcolor='#9999FF']//td/p/b
${SampleDataTableBodyRows}          ${SampleDataTable}//tr[not(@bgcolor='#9999FF')]
# @Todo: Why Python string format doesn't work for below approch?
${SampleDataTableBodyData}          ${SampleDataTableBodyRows}/td[{index}]/p
${SampleDataTableHeaderColumn}      //td[p[.='{column}']]/parent::tr
${downloadSampleDataButton}         (//a[@href='SampleData.zip'])[1]

*** Keywords ***
Sample Data Page Opened
    Open Url With Chrome            ${SampleData01Url}
    Cookies are accepted
    Wait Until Element Is Visible   ${SampleDataHeaderText}

I Get All Data Of Column
    [Arguments]                   ${column}
    Scroll to Element             ${SampleDataTableHeaderColumn}.format(column = ${column})
    ${columnIndex} =              Get Element Index                   ${SampleDataTableHeaders}   ${column}
    Set Suite Variable            \${columnIndex}
    ${columnData} =               Get List Of Elements Text           ${SampleDataTableBodyRows}/td[${columnIndex}+1]/p
    Set Suite Variable            \${columnData}

Different Items Amount Should Be
    [Arguments]          ${expectedAmount}
    ${expectedAmount} =  Convert To Number   ${expectedAmount}
    ${actualAmount} =    Get Length          ${columnData}
    Should Be Equal      ${actualAmount}     ${expectedAmount}

I Get All Table Data
    Scroll to Element       ${SampleDataTable}
    ${actualTableData}=     Get All Table Data      ${SampleDataTableHeaders}  ${SampleDataTableBodyRows}
    Set Suite Variable      \${actualTableData}

I Filter Orders With Item Name
    [Arguments]     ${item_name}
    ${actualTableData} =    Get Orders With Item Name   ${actualTableData}  ${item_name}
    Set Suite Variable      \${actualTableData}

I Filter Orders With Units In Range Of
    [Arguments]             ${start}  ${end}
    ${range}=               Create List             ${start}  ${end}
    ${dataInRange}=         Get Units In Range Of   ${actualTableData}  ${range}
    Set Suite Variable      \${dataInRange}

I Sort Data Based On Column
    [Arguments]     ${column}
    ${actualTableData} =    Sort Table Data By Column       ${actualTableData}  ${column}
    Set Suite Variable      \${actualTableData}

I Should See Orders With Size Of
    [Arguments]     ${expectedOrdersSize}
    ${expectedSize} =  Convert To Number   ${expectedOrdersSize}
    ${actualSize} =    Get Length          ${dataInRange}
    Should Be Equal    ${actualSize}       ${expectedSize}

I Should See That The Most Expensive Item Is
    [Arguments]        ${expectedItem}
    ${args}=           Create Dictionary             data_list=${actualTableData}  index=-1  key=Item
    ${actualItem}=     get_value_from_list_of_dict   ${args}
    Should Be Equal    ${actualItem}                 ${expectedItem}

I Click To Download Sample Data Button
    Scroll to Element   ${downloadSampleDataButton}
    Click Element       ${downloadSampleDataButton}

I Should See The File Downloaded With Name
    [Arguments]         ${expectedFileName}
    # wait for download to finish
    ${file}         Wait Until Keyword Succeeds    1 min    2 sec    Download should be done    ${download directory}
    Should Be Equal     ${actualFileName}  ${expectedFileName}

Download should be done
    [Arguments]                 ${directory}
    ${files}    List Files In Directory    ${directory}
    Length Should Be            ${files}    1    Should be only one file in the download folder
    Should Not Match Regexp     ${files[0]}    (?i).*\\.tmp    Chrome is still downloading a file
    Set Suite Variable          ${actualFileName}  ${files[0]}

    ${file}    Join Path        ${directory}    ${actualFileName}
    Log        File was successfully downloaded to ${file}
    [Return]   ${file}
