*** Settings ***
Library           SeleniumLibrary
Resource          resource.robot
Resource          stepgroup.robot

*** Test Cases ***
Validate user is able to click the Notes link from the Nav bar and Notes page will be navigated
    Open Chromium Browser    https://qa-compass.astm.org/
    Click Element    username
    Input Text    username    user3
    Click Element    password
    Input Text    password    user
    Click Element    //*[@id="login-page"]/div/form/div[3]/button[2]
    Click Element    //*[@id="app-view-container"]/div/div/div[1]/div/p[1]
    Click Element    //*[@id="app-header"]/nav[1]/a/label
    Click Element    //*[@id="sidebar"]/div[5]/p/a
    location should be    https://qa-compass.astm.org/favorites

Validate static text My Notes is displayed as a heading the Notes page
    Element should contain    //*[@id="app-view-container"]/div/div/h2    My Notes

Validate static text 'My Notes is a list of standards that you have annotated with your own notes or comments. The note feature is available at the top of each document From this list, you can Delete each individual annotation entirely.' is displayed below the My Favorites heading
    Element should contain    //*[@id="app-view-container"]/div/div/p    My Notes is a list of standards that you have annotated with your own notes or comments. The note feature is available at the top of each document From this list, you can Delete each individual annotation entirely.
