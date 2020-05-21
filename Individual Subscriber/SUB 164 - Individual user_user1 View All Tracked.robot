*** Settings ***
Library           SeleniumLibrary
Resource          resource.robot
Resource          stepgroup.robot

*** Test Cases ***
Validate the View All Tracked link in the Tracker tab
    Open Chromium Browser    https://qa-compass.astm.org/login
    Web UI Click Element    username
    Web UI Input Text    username    user1
    Web UI Click Element    password
    Web UI Input Text    password    user
    Web UI Click Element    //button[@type='submit']
    Web UI Click Element    //span[text()='Tracker']
    elEMENT SHOULD CONTAIN    //*[@id="app-view-container"]/div/div/div[2]/div[7]/h6/a    VIEW ALL TRACKED
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']/div/a/span[text()='Sign out']
    Close window
