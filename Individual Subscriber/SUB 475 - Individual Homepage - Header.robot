*** Settings ***
Library           SeleniumLibrary
Resource          resource.robot
Resource          stepgroup.robot

*** Test Cases ***
Validate when individual user logged in, when click on the name in the Header, it contains the option MyAccount
    Open Chromium Browser    https://qa-compass.astm.org/login
    Web UI Click Element    username
    Web UI Input Text    username    user1
    Web UI Click Element    password
    Web UI Input Text    password    user
    Web UI Click Element    //button[@type='submit']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']
    Page Should Contain Element    //ul[@id='header-tabs']/li[@id='account-menu']/div/a/span[text()='My Account']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']/div/a/span[text()='Sign out']
    Close window
