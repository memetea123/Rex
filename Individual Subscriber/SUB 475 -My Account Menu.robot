*** Settings ***
Library           SeleniumLibrary
Resource          resource.robot
Resource          stepgroup.robot

*** Test Cases ***
Validate there is edit option on the address
    Open Chromium Browser    https://qa-compass.astm.org/login
    Web UI Click Element    username
    Web UI Input Text    username    user1
    Web UI Click Element    password
    Web UI Input Text    password    user
    Web UI Click Element    //button[@type='submit']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']/div/a/span[text()='My Account']
    Execute Javascript    window.location.href="/compass/myAccount"
    Page Should Contain Element    //span[text()='edit']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']/div/a/span[text()='Sign out']
    Close Window

Validate when user click on the edit option on the phone no, it popup the My Account window
    Open Chromium Browser    https://qa-compass.astm.org/login
    Web UI Click Element    username
    Web UI Input Text    username    user1
    Web UI Click Element    password
    Web UI Input Text    password    user
    Web UI Click Element    //button[@type='submit']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']/div/a/span[text()='My Account']
    Execute Javascript    window.location.href="/compass/myAccount"
    Click Element    //span[text()='edit']
    Page Should Contain Element    //form[@class='av-valid']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']/div/a/span[text()='Sign out']
    Close Window

Validate user can edit the Address(ASTM International/Address 2)
    Open Chromium Browser    https://qa-compass.astm.org/login
    Web UI Click Element    username
    Web UI Input Text    username    user1
    Web UI Click Element    password
    Web UI Input Text    password    user
    Web UI Click Element    //button[@type='submit']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']/div/a/span[text()='My Account']
    Execute Javascript    window.location.href="/compass/myAccount"
    Verify Page Should Contain Element    //span[text()='edit']
    Click Element    //span[text()='edit']
    Web UI Input Text    //input[@id='my-account-address1']    address1_test
    Web UI Input Text    //input[@id='my-account-address2']    address2_test
    Web UI Input Text    //input[@id='my-account-city']    city_test
    Web UI Click Element    //div[@class='form-group'][4]
    Web UI Click Element    //option[text()='Colorado']
    Web UI Input Text    //input[@id='my-account-postalCode']    234234
    Web UI Click Element    //div[@class='form-group'][6]
    Web UI Click Element    //option[text()='United States']
    Web UI Input Text    //input[@id='my-account-phone']    12334325543
    Web UI Click Element    //button[@id='save-entity-1']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']
    Web UI Click Element    //ul[@id='header-tabs']/li[@id='account-menu']/div/a/span[text()='Sign out']
    Close Window
