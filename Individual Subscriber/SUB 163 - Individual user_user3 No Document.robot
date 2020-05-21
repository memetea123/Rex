*** Settings ***
Library           SeleniumLibrary
Resource          resource.robot
Resource          stepgroup.robot

*** Test Cases ***
Validate the placeholder for not track any document
    Open Chromium Browser    https://qa-compass.astm.org/login
    Web UI Click Element    username
    Web UI Input Text    username    user3
    Web UI Click Element    password
    Web UI Input Text    password    user
    Web UI Click Element    //button[@type='submit']
    Web UI Click Element    //span[text()='Tracker']
    Page Should Contain Element    //span[text()='You are not tracking any documents']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']/div/a/span[text()='Sign out']
