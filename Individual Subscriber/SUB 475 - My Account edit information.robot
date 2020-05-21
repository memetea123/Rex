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
    Close Window

Validate when click on MyAccount in the option list of the name, it will generate the page of MyAccount
    Open Chromium Browser    https://qa-compass.astm.org/login
    Web UI Click Element    username
    Web UI Input Text    username    user1
    Web UI Click Element    password
    Web UI Input Text    password    user
    Web UI Click Element    //button[@type='submit']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']/div/a/span[text()='My Account']
    Location Should Be    https://qa-compass.astm.org/myAccount
    Execute Javascript    window.location.href="/compass/myAccount"
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']/div/a/span[text()='Sign out']
    Close Window

Vaidate the My Account page contains these informations of the account:Name, E-Mail, Address, Phone
    Open Chromium Browser    https://qa-compass.astm.org/login
    Web UI Click Element    username
    Web UI Input Text    username    user1
    Web UI Click Element    password
    Web UI Input Text    password    user
    Web UI Click Element    //button[@type='submit']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']/div/a/span[text()='My Account'] \
    Execute Javascript    window.location.href="/compass/myAccount"
    Wait Until Page Contains Element    //span[text()='Name']
    Page Should Contain Element    //span[text()='E-mail']
    Page Should Contain Element    //span[text()='Address']
    Page Should Contain Element    //span[text()='Phone']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']/div/a/span[text()='Sign out']
    Close Window
