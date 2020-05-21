*** Settings ***
Library           SeleniumLibrary
Resource          resource.robot
Resource          stepgroup.robot

*** Variables ***
${account menu}    //ul[@id="header-tabs"]//li[@id="account-menu"]
${tab_recently accessed}    //*[@id="app-view-container"]/div/div/div[1]/div/p[1]
${tab_tracker}    //*[@id="app-view-container"]/div/div/div[1]/div/p[2]
${tab_subscriptions}    //*[@id="app-view-container"]/div/div/div[1]/div/p[4]
${tab_favorites}    //*[@id="app-view-container"]/div/div/div[1]/div/p[3]
${URL}            https://qa-compass.astm.org/login

*** Test Cases ***
Validate individual user is able to login the Compass
    Open Chromium Browser    ${URL}
    Web UI Click Element    username
    Web UI Input Text    username    user2
    Web UI Click Element    password
    Web UI Input Text    password    user
    Click Button    //*[@id="login-page"]/div/form/div[3]/button[2]
    Web UI Click Element    ${account menu}
    Web UI Click Element    //ul[@id="header-tabs"]//li[@id="account-menu"]//a[@href="/logout"]
    Web UI Click Element    username
    Web UI Input Text    username    user1
    Web UI Click Element    password
    Web UI Input Text    password    user
    Click Button    //*[@id="login-page"]/div/form/div[3]/button[2]

Validate Recently accessed tab should be displayed in the homepage
    Web UI Click Element    ${tab_recently accessed}
    Element should contain    //*[@id="app-view-container"]/div/div/h2    Welcome Back, Jin Xiu(User1)
    Element should contain    ${tab_recently accessed}    Recently Accessed

Validate Tracker tab should be displayed in the homepage
    Web UI Click Element    ${tab_tracker}
    Element should contain    ${tab_tracker}    Tracker
    Element should contain    ${tab_favorites}    Favorites

Validate Subscrptions should be displayed in the homepage
    Web UI Click Element    ${tab_subscriptions}

Validate there will be 2 options displayed under Help menu in the header
    Web UI Click Element    help-menu
    Element should contain    support    Support and FAQs
    Element should contain    training    User Training Videos

Validate there will be 5 options displayed under username menu in the header
    Web UI Click Element    ${account menu}
    Element should contain    //ul[@id='header-tabs']//a[@id="my-account"]    My Account
    Element should contain    //ul[@id='header-tabs']//a[@id="shared-with-me"]    Standards Shared With Me
    Element should contain    //ul[@id='header-tabs']//a[@id="publications-shared"]    Publications Shared With Me
    Element should contain    //ul[@id='header-tabs']//a[@id="my-astm"]    MyASTM
    Element should contain    //ul[@id="header-tabs"]//li[@id="account-menu"]//a[@href="/logout"]    Sign out

Validate user is able to click the Standards shared with me option
    Web UI Click Element    //ul[@id='header-tabs']//a[@id="shared-with-me"]
    Element should contain    //*[@id="app-view-container"]/div/div/h2    My Shared Standards
    Element should contain    //*[@id="app-view-container"]/div/div/p    Standards Shared with Me lists standards that have been shared with you by other registered users

Validate user is able to click the Publications shared with me option
    Web UI Click Element    ${account menu}
    Web UI Click Element    //ul[@id='header-tabs']//a[@id="publications-shared"]
    Element should contain    //*[@id="app-view-container"]/div/div/h2    My Shared Publications
    Element should contain    //*[@id="app-view-container"]/div/div/p    Publications Shared with Me lists documents that have been shared with you by other registered users
    Element should contain    //*[@id="app-view-container"]/div/div/div/table/thead/tr/th[1]    Document
    Element should contain    //*[@id="app-view-container"]/div/div/div/table/thead/tr/th[2]    Shared By

Validate user is able to search the documents by click the magnifying icon in the header
    Web UI Click Element    //*[@id="app-header"]/nav[1]/div[1]/a
    Element should contain    //*[@id="app-view-container"]/div/div/h2    Welcome Back, Jin Xiu(User1)
    Web UI Click Element    //div[@class="nav-row row"]//*[@id="types"]
    Web UI Input Text    //*[@id="app-header"]/nav[2]/div/div[2]/span/input    Test
    Web UI Click Element    //*[@id="app-header"]/nav[2]/div/div[2]/span/button

Validate user is able to click the links under ASTM community section in homepage
    Open Chromium Browser    ${URL}
    Web UI Click Element    username
    Web UI Input Text    username    user1
    Web UI Click Element    password
    Web UI Input Text    password    user
    Click Button    //*[@id="login-page"]/div/form/div[3]/button[2]
    Web UI Click link    //*[@id="app-view-container"]/div/div/div[3]/div[2]/div[2]/div/div/a[1]
    switch window    url=https://www.astm.org/COMMIT/newcommit.html
    location should be    https://www.astm.org/COMMIT/newcommit.html
    switch window    url=https://qa-compass.astm.org/
    Web UI Click link    //*[@id="app-view-container"]/div/div/div[3]/div[2]/div[2]/div/div/a[2]
    switch window    url=https://www.astm.org/MEMBERSHIP/index.html
    location should be    https://www.astm.org/MEMBERSHIP/index.html
    switch window    url=https://qa-compass.astm.org/
    Web UI Click link    //*[@id="app-view-container"]/div/div/div[3]/div[2]/div[2]/div/div/a[3]
    switch window    url=https://myastm.astm.org/CUSTOMERS/welcome.cgi
    location should be    https://myastm.astm.org/CUSTOMERS/welcome.cgi
    switch window    url=https://qa-compass.astm.org/
    Web UI Click link    //*[@id="app-view-container"]/div/div/div[3]/div[2]/div[2]/div/div/a[4]
    switch window    url=https://www.astm.org/MEETINGS/index.html
    location should be    https://www.astm.org/MEETINGS/index.html
    switch window    url=https://qa-compass.astm.org/
    Web UI Click link    //*[@id="app-view-container"]/div/div/div[3]/div[2]/div[2]/div/div/a[5]
    switch window    url=https://www.astm.org/PUBLISH/
    location should be    https://www.astm.org/PUBLISH/
    switch window    url=https://qa-compass.astm.org/
    close window

Validate user should be able to see the static text message if there is no document under Standards shared with me/Publications shared with me page
    Open Chromium Browser    ${URL}
    Web UI Click Element    username
    Web UI Input Text    username    user2
    Web UI Click Element    password
    Web UI Input Text    password    user
    Click Button    //*[@id="login-page"]/div/form/div[3]/button[2]
    Web UI Click Element    ${account menu}
    Web UI Click Element    //ul[@id='header-tabs']//a[@id="shared-with-me"]
    Element should contain    //*[@id="app-view-container"]/div/div/div/p    You currently do not have any shared standards
    Web UI Click Element    ${account menu}
    Web UI Click Element    //ul[@id='header-tabs']//a[@id="publications-shared"]
    Element should contain    //*[@id="app-view-container"]/div/div/div/p    You currently do not have any shared publications
    close window

Validate correct copyright should be displayed in the footer
    Open Chromium Browser    ${URL}
    Web UI Click Element    username
    Web UI Input Text    username    user1
    Web UI Click Element    password
    Web UI Input Text    password    user
    Click Button    //*[@id="login-page"]/div/form/div[3]/button[2]
    Element should contain    //*[@id="root"]/div/div/div[4]/div/div/div[3]/p    Copyright © 1996 - 2020 ASTM. All Rights Reserved. ASTM International, 100 Barr Harbor Drive, PO Box C700, West Conshohocken, PA, 19428-2959 USA

Validate the links should work as expected and correct URL should be navigated
    Element should contain    //*[@id="root"]/div/div/div[4]/div/div/div[4]/ul/li[1]/a    Home
    Web UI Click link    //*[@id="root"]/div/div/div[4]/div/div/div[4]/ul/li[1]/a
    Element should contain    //*[@id="root"]/div/div/div[4]/div/div/div[4]/ul/li[2]/a    About ASTM
    Web UI Click link    //*[@id="root"]/div/div/div[4]/div/div/div[4]/ul/li[2]/a
    sleep    2s
    switch window    url=https://www.astm.org/ABOUT/overview.html
    location should be    https://www.astm.org/ABOUT/overview.html
    switch window    url=https://qa-compass.astm.org/home/0
    sleep    2s
    Element should contain    //*[@id="root"]/div/div/div[4]/div/div/div[4]/ul/li[3]/a    Support
    Web UI Click link    //*[@id="root"]/div/div/div[4]/div/div/div[4]/ul/li[3]/a
    sleep    2s
    switch window    url=https://compass.astm.org/fedlogin.php
    location should be    https://compass.astm.org/fedlogin.php
    switch window    url=https://qa-compass.astm.org/home/0
    sleep    2s
    Element should contain    //*[@id="root"]/div/div/div[4]/div/div/div[4]/ul/li[4]/a    Contact
    Web UI Click link    //*[@id="root"]/div/div/div[4]/div/div/div[4]/ul/li[4]/a
    sleep    2s
    switch window    url=https://www.astm.org/CONTACT/index.html
    location should be    https://www.astm.org/CONTACT/index.html
    switch window    url=https://qa-compass.astm.org/home/0
    sleep    2s
    Element should contain    //*[@id="root"]/div/div/div[4]/div/div/div[4]/ul/li[5]/a    Privacy Policy
    Web UI Click link    //*[@id="root"]/div/div/div[4]/div/div/div[4]/ul/li[5]/a
    sleep    2s
    switch window    url=https://www.astm.org/POLICY/privacy_policy.html
    location should be    https://www.astm.org/POLICY/privacy_policy.html
    switch window    url=https://qa-compass.astm.org/home/0
    sleep    2s
    Element should contain    //*[@id="root"]/div/div/div[4]/div/div/div[4]/ul/li[6]/a    Policies
    Web UI Click link    //*[@id="root"]/div/div/div[4]/div/div/div[4]/ul/li[6]/a
    sleep    2s
    switch window    url=https://www.astm.org/prpolicy.html
    location should be    https://www.astm.org/prpolicy.html
    switch window    url=https://qa-compass.astm.org/home/0
    sleep    2s
    Element should contain    //*[@id="root"]/div/div/div[4]/div/div/div[4]/ul/li[7]/a    Copyright/Permissions
    Web UI Click link    //*[@id="root"]/div/div/div[4]/div/div/div[4]/ul/li[7]/a
    sleep    2s
    switch window    url=https://www.astm.org/COPYRIGHT/index.html
    location should be    https://www.astm.org/COPYRIGHT/index.html
    close window

Validate all publishers should be displayed under Subscriptions tab
    Open Chromium Browser    ${URL}
    Web UI Click Element    username
    Web UI Input Text    username    user1
    Web UI Click Element    password
    Web UI Input Text    password    user
    Click Button    //*[@id="login-page"]/div/form/div[3]/button[2]
    Web UI Click Element    ${tab_subscriptions}
    Element should contain    //*[@id="app-view-container"]/div/div/div[2]/div[2]/div/div/div[2]/p    ASTM International
    Element should contain    //*[@id="app-view-container"]/div/div/div[2]/div[3]/div/div/div[2]/p    American Association of State Highway Transportation Officials
    Element should contain    //*[@id="app-view-container"]/div/div/div[2]/div[4]/div/div/div[2]/p    American Association of Textile Chemists and Colorists
    Element should contain    //*[@id="app-view-container"]/div/div/div[2]/div[5]/div/div/div[2]/p    American Concrete Institute
    Element should contain    //*[@id="app-view-container"]/div/div/div[2]/div[6]/div/div/div[2]/p    American Water Works Association
    Element should contain    //*[@id="app-view-container"]/div/div/div[2]/div[7]/div/div/div[2]/p    American Weiding Society
    Element should contain    //*[@id="app-view-container"]/div/div/div[2]/div[9]/div/div/div[2]/p    Code of Federal Regulations
    Element should contain    //*[@id="app-view-container"]/div/div/div[2]/div[10]/div/div/div[2]/p    Compressed Gas Association
    Element should contain    //*[@id="app-view-container"]/div/div/div[2]/div[11]/div/div/div[2]/p    Illuminating Engineering Society
    Element should contain    //*[@id="app-view-container"]/div/div/div[2]/div[12]/div/div/div[2]/p    Qatar Construction Specifications
    Element should contain    //*[@id="app-view-container"]/div/div/div[2]/div[13]/div/div/div[2]/p    The International Organization for Standardization
    Element should contain    //*[@id="app-view-container"]/div/div/div[2]/div[14]/div/div/div[2]/p    Unified Numbering System
    Element should contain    //*[@id="app-view-container"]/div/div/div[2]/div[15]/div/div/div[2]/p    United State Of Department Of Defense
    Element should contain    //*[@id="app-view-container"]/div/div/div[2]/div[16]/div/div/div[2]/p    Universal Oil Products
    close window

Validate Subscriptions Marketplace should not be displayed if user subscribe all the publishers
    Open Chromium Browser    ${URL}
    Web UI Click Element    username
    Web UI Input Text    username    user3
    Web UI Click Element    password
    Web UI Input Text    password    user
    Click Button    //*[@id="login-page"]/div/form/div[3]/button[2]
    Web UI Click Element    ${tab_subscriptions}
    Element should not contain    //*[@id="app-view-container"]/div/div/div[2]    Subscriptions Marketplace
    close window

Validate the text "A catalog of other publishers available within ASTM Compass" shows under 'Subscriptions Marketplace.' if there is one or any publishers which user does not subscribe
    Open Chromium Browser    ${URL}
    Web UI Click Element    username
    Web UI Input Text    username    user1
    Web UI Click Element    password
    Web UI Input Text    password    user
    Click Button    //*[@id="login-page"]/div/form/div[3]/button[2]
    Web UI Click Element    ${tab_subscriptions}
    Wait Until Page Contains Element    //*[@id="app-view-container"]/div/div/div[2]/div[8]/p[2]
    close window

Validate ASTM Sales contact info will persist beneath "Subscriptions Marketplace" section:To add to your subscription, contact ASTM Inside Sales and Support:1-877-909-2786 (USA and Canada) | 001-610-832-9585 (International) | sales@astm.org
    Open Chromium Browser    ${URL}
    Web UI Click Element    username
    Web UI Input Text    username    user1
    Web UI Click Element    password
    Web UI Input Text    password    user
    Click Button    //*[@id="login-page"]/div/form/div[3]/button[2]
    Web UI Click Element    ${tab_subscriptions}
    Wait Until Page Contains Element    //*[@id="app-view-container"]/div/div/div[2]/div[17]/p[1]
    Wait Until Page Contains Element    //*[@id="app-view-container"]/div/div/div[2]/div[17]/p[2]
    close window
