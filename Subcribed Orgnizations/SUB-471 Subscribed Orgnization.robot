*** Settings ***
Library           SeleniumLibrary
Resource          resource.robot
Resource          stepgroup.robot

*** Test Cases ***
Validate subscribed publishers should be displayed after user click the Subscriptions from the nav bar
    Open Chromium Browser    https://qa-compass.astm.org/home/
    Web UI Click Element    username
    Web UI Input Text    username    user2
    Web UI Click Element    password
    Web UI Input Text    password    user
    Click Button    //*[@id="login-page"]/div/form/div[3]/button[2]
    Web UI Click Element    //*[@id="app-header"]/nav[1]/a/label
    Web UI Click Element    //*[@id="sidebar"]/div[2]/p
    Element should contain    //*[@id="sidebar"]/div[2]/p[2]    ASTM International
    Element should contain    //*[@id="sidebar"]/div[2]/p[3]    AASHTO
    Element should contain    //*[@id="sidebar"]/div[2]/p[4]    AATCC
    Element should contain    //*[@id="sidebar"]/div[2]/p[5]    ACI
    Element should contain    //*[@id="sidebar"]/div[2]/p[6]    AWWA
    Element should contain    //*[@id="sidebar"]/div[2]/p[7]    AWS
