*** Settings ***
Library           SeleniumLibrary
Resource          resource.robot
Resource          stepgroup.robot

*** Test Cases ***
Validate user is able to click the Notes link from the Nav bar and Notes page will be navigated
    Open Chromium Browser    https://qa-compass.astm.org/
    Web UI Click Element    username
    Input Text    username    user1
    Web UI Click Element    password
    Input Text    password    user
    Web UI Click Element    //*[@id="login-page"]/div/form/div[3]/button[2]
    Web UI Click Element    //*[@id="app-view-container"]/div/div/div[1]/div/p[1]
    Web UI Click Element    //*[@id="app-header"]/nav[1]/a/label
    Web UI Click Element    //*[@id="sidebar"]/div[5]/p/a
    location should be    https://qa-compass.astm.org/notes

Validate static text My Notes is displayed as a heading the Notes page
    Element should contain    //*[@id="app-view-container"]/div/div/h2/span    My Notes

Validate static text 'My Notes is a list of standards that you have annotated with your own notes or comments. The note feature is available at the top of each document From this list, you can Delete each individual annotation entirely.' is displayed below the My Favorites heading
    Element should contain    //*[@id="app-view-container"]/div/div/p    My Notes is a list of standards that you have annotated with your own notes or comments. The note feature is available at the top of each document From this list, you can Delete each individual annotation entirely.

Validate user is able to click the document link and document page will be navigated
    Web UI Click Element    //*[@id="app-view-container"]/div/div/div/table/tbody/tr[1]/td[1]/a
    Element should contain    //*[@id="app-view-container"]/div/div/p/span[3]/span/span    Download

Validate user is able to click Delete link and confirmation window will be displayed
    Web UI Click Element    //*[@id="app-view-container"]/div/div/div/table/tbody/tr[1]/td[2]/a
    Element should contain    //*[@id="exampleModalLabel"]    Confirm delete operation
    Web UI Click Element    /html/body/div[2]/div/div[1]/div/div/div[3]/button[2]

Validate if user never add a note to document , once user navigate to the My Notes page , static text 'There are no records to display' will be displayed
    Open Chromium Browser    https://qa-compass.astm.org/
    Web UI Click Element    username
    Input Text    username    user3
    Web UI Click Element    password
    Input Text    password    user
    Web UI Click Element    //*[@id="login-page"]/div/form/div[3]/button[2]
    Web UI Click Element    //*[@id="app-view-container"]/div/div/div[1]/div/p[1]
    Web UI Click Element    //*[@id="app-header"]/nav[1]/a/label
    Click Element    //*[@id="sidebar"]/div[4]/p/a
    Element should contain    //*[@id="app-view-container"]/div/div/div/p    There are no records to display.
