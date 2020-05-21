*** Settings ***
Library           SeleniumLibrary
Resource          resource.robot
Resource          stepgroup.robot

*** Test Cases ***
Validate individual user is able to click the username dropdown in the header and MyASTM option will be in the list
    Open Chromium Browser    https://qa-compass.astm.org/login
    Web UI Click Element    username
    Web UI Input Text    username    user1
    Web UI Click Element    password
    Web UI Input Text    password    user
    Web UI Click Element    //button[@type='submit']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']
    Page Should Contain Element    //ul[@id='header-tabs']/li[@id='account-menu']/div/a[@id='my-astm']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']/div/a/span[text()='Sign out']
    Close Window

Validate after compass user click the MyASTM option in the username dropdown list , https://myastm.astm.org/CUSTOMERS/welcome.cgi will be navigated
    Open Chromium Browser    https://qa-compass.astm.org/login
    Web UI Click Element    username
    Web UI Input Text    username    user1
    Web UI Click Element    password
    Web UI Input Text    password    user
    Web UI Click Element    //button[@type='submit']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']/div/a[@id='my-astm']
    Get Locations
    Switch Window    url=https://myastm.astm.org/CUSTOMERS/welcome.cgi
    Location Should Be    https://myastm.astm.org/CUSTOMERS/welcome.cgi
    Switch Window    url=https://qa-compass.astm.org/home/
    Location Should Be    https://qa-compass.astm.org/home/
    Execute Javascript    window.location.href="/compass"
    Click Element    //ul[@id='header-tabs']/li[@id='account-menu']
    Click Element    //ul[@id='header-tabs']/li[@id='account-menu']/div/a/span[text()='Sign out']
    Close Window
