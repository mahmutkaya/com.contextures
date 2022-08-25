*** Settings ***
Documentation       Sample Data Table Tests
Resource            ../pages/SampleDataPage.robot

Test Setup          Sample Data Page Opened
Test Teardown       Default Teardown


*** Test Cases ***
#How many different items are there (binder/pencil etc.) ?
Check the amount of different items
    When I Get All Data Of Column                   Item
    Then Different Items Amount Should Be           5

#Is there an item with less than 5 units?
Check all items unit
    Given I Get All Table Data
    When I Filter Orders With Units In Range Of     0  5
    Then I Should See Orders With Size Of           3

#Is there a pencil with less than 5 units?
Check an item units
    Given I Get All Table Data
    When I Filter Orders With Item Name             Pencil
    And I Filter Orders With Units In Range Of      0  5
    Then I Should See Orders With Size Of           0

#What is the most expensive item on the list?
Check the most expensive item
    Given I Get All Table Data
    When I Sort Data Based On Column                    UnitCost
    Then I Should See That The Most Expensive Item Is   Desk

#Test that the excel download button works and downloads the file
Check Download File Feature
    When I Click To Download Sample Data Button
    Then I Should See The File Downloaded With Name  SampleData.zip
