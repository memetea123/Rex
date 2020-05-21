*** Settings ***
Library           SeleniumLibrary
Resource          resource.robot
Resource          stepgroup.robot

*** Test Cases ***
Validate Subscribed Orgnazation is able to click the hamburger icon
    Open Chromium Browser    https://qa-compass.astm.org/home/
    Web UI Click Element    username
    Web UI Input Text    username    user2
    Web UI Click Element    password
    Web UI Input Text    password    user
    Click Button    //*[@id="login-page"]/div/form/div[3]/button[2]
    Web UI Click Element    //*[@id="app-header"]/nav[1]/a/label

Validate 2 options should be displayed after Subscribed Orgnization click the hamburger icon
    Open Chromium Browser    https://qa-compass.astm.org/home/
    Web UI Click Element    username
    Web UI Input Text    username    user2
    Web UI Click Element    password
    Web UI Input Text    password    user
    Click Button    //*[@id="login-page"]/div/form/div[3]/button[2]
    Web UI Click Element    //*[@id="app-header"]/nav[1]/a/label
    Element should contain    //*[@id="sidebar"]/div[1]/p    Home
    Element should contain    //*[@id="sidebar"]/div[2]/p    Subscriptions
    Element should contain    //*[@id="sidebar"]/p[3]    Technical Committees
    Element should contain    //*[@id="sidebar"]/p[4]    Membership
    Element should contain    //*[@id="sidebar"]/p[5]    Meetings & Symposia
    Element should contain    //*[@id="sidebar"]/p[6]    Publish with ASTM

Validate if user has the access to Subcription Usage , it will also display in the hamburger menu , while if not , it will not display
    Element should contain    //*[@id="sidebar"]/p[2]    Subscription Usage

Validate user is able to click the X Close link from the Nav bar and the Nav bar will be closed
    Web UI Click Element    //*[@id="sidebar"]/p[1]
    Element should contain    //*[@id="app-view-container"]/div/div/div[1]/div/p[1]    Recently Updated

Validate user is able to click the Home link from the Nav bar and the homepage will be navigated
    Web UI Click Element    //*[@id="sidebar"]/div[1]/p
    location should be    https://qa-compass.astm.org/home/
