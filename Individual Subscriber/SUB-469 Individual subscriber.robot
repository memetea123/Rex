*** Settings ***
Library           SeleniumLibrary
Resource          resource.robot
Resource          stepgroup.robot

*** Variables ***
${Recently Accessed tab}    //*[@id="app-view-container"]/div/div/div[1]/div/p[1]
${URL}            https://qa-compass.astm.org/home/

*** Test Cases ***
Validate Individual subscriber is able to click the hamburger icon
    Open Chromium Browser    ${URL}
    Web UI Click Element    username
    Web UI Input Text    username    user1
    Web UI Click Element    password
    Web UI Input Text    password    user
    Click Button    //*[@id="login-page"]/div/form/div[3]/button[2]
    Web UI Click Element    ${Recently Accessed tab}
    Web UI Click Element    //*[@id="app-header"]/nav[1]/a/label

Validate 9 options should be displayed after Subscribed Orgnization click the hamburger icon
    Open Chromium Browser    ${URL}
    Web UI Click Element    username
    Web UI Input Text    username    user1
    Web UI Click Element    password
    Web UI Input Text    password    user
    Click Button    //*[@id="login-page"]/div/form/div[3]/button[2]
    Web UI Click Element    //*[@id="app-header"]/nav[1]/a/label
    Element should contain    //*[@id="sidebar"]/div[1]/p/a    Home
    Element should contain    //*[@id="sidebar"]/div[2]/p/a    Subscriptions
    Element should contain    //*[@id="sidebar"]/div[3]/p/a    Tracker
    Element should contain    //*[@id="sidebar"]/div[4]/p/a    Favorites
    Element should contain    //*[@id="sidebar"]/div[5]/p/a    Notes
    Element should contain    //*[@id="sidebar"]/p[3]    Technical Committees
    Element should contain    //*[@id="sidebar"]/p[4]    Membership
    Element should contain    //*[@id="sidebar"]/p[5]    Meetings & Symposia
    Element should contain    //*[@id="sidebar"]/p[6]    Publish with ASTM

Validate if user has the access to E-Learning , it will also display in the hamburger menu , while if not , it will not display
    Element should contain    //*[@id="sidebar"]/p[7]/a    eLearning

Validate if user has a subcription to SpecBuilder, it will appear in the hamburger menu , while if not , it will not display in the menu
    Element should contain    //*[@id="sidebar"]/p[8]    Spec Builder

Validate if user has the access to Subcription Usage , it will also display in the hamburger menu , while if not , it will not display
    Element should contain    //*[@id="sidebar"]/p[2]    Subscription Usage

Validate user is able to click the X Close link from the Nav bar and the Nav bar will be closed
    Web UI Click Element    //*[@id="sidebar"]/p[1]
    Element should contain    //*[@id="app-view-container"]/div/div/div[1]/div/p[1]    Recently Accessed

Validate user is able to click the Home link from the Nav bar and the homepage will be navigated
    Web UI Click Element    //*[@id="app-header"]/nav[1]/a/label
    Web UI Click Element    //*[@id="sidebar"]/div[1]/p
    location should be    ${URL}
