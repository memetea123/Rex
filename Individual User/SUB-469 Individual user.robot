*** Settings ***
Library           SeleniumLibrary
Resource          resource.robot
Resource          stepgroup.robot

*** Variables ***
${URL}            https://qa-compass.astm.org/home/

*** Test Cases ***
Validate Individual user is able to click the hamburger icon
    Open Chromium Browser    ${URL}
    Web UI Click Element    username
    Web UI Input Text    username    user3
    Web UI Click Element    password
    Web UI Input Text    password    user
    Click Button    //*[@id="login-page"]/div/form/div[3]/button[2]
    Web UI Click Element    //*[@id="app-header"]/nav[1]/a/label

Validate 9 options should be displayed after Subscribed Orgnization click the hamburger icon
    Open Chromium Browser    https://qa-compass.astm.org/home/
    Web UI Click Element    username
    Web UI Input Text    username    user3
    Web UI Click Element    password
    Web UI Input Text    password    user
    Click Button    //*[@id="login-page"]/div/form/div[3]/button[2]
    Web UI Click Element    //*[@id="app-header"]/nav[1]/a/label
    Element should contain    //*[@id="sidebar"]/div[1]/p    Home
    Element should contain    //*[@id="sidebar"]/div[2]/p    Subscriptions
    Element should contain    //*[@id="sidebar"]/div[3]/p    Tracker
    Element should contain    //*[@id="sidebar"]/div[4]/p    Favorites
    Element should contain    //*[@id="sidebar"]/div[5]/p    Notes
    Element should contain    //*[@id="sidebar"]/p[2]    Technical Committees
    Element should contain    //*[@id="sidebar"]/p[3]    Membership
    Element should contain    //*[@id="sidebar"]/p[4]    Meetings & Symposia
    Element should contain    //*[@id="sidebar"]/p[5]    Publish with ASTM

Validate if user has the access to Subcription Usage , it will also display in the hamburger menu , while if not , it will not display
    Element should not contain    //*[@id="sidebar"]/p[2]    Subscription Usage

Validate if user has the access to E-Learning , it will also display in the hamburger menu , while if not , it will not display
    Element should not contain    //*[@id="sidebar"]/p[7]    E-learning

Validate if user has a subcription to SpecBuilder, it will appear in the hamburger menu , while if not , it will not display in the menu
    Element should contain    //*[@id="sidebar"]/p[6]    SpecBuilder

Validate user is able to click the X Close link from the Nav bar and the Nav bar will be closed
    Web UI Click Element    //*[@id="sidebar"]/p[1]
    Element should contain    //*[@id="app-view-container"]/div/div/div[1]/p[1]    Recently Accessed

Validate user is able to click the Home link from the Nav bar and the homepage will be navigated
    Web UI Click Element    //*[@id="sidebar"]/div[1]/p
    location should be    https://qa-compass.astm.org/home/
