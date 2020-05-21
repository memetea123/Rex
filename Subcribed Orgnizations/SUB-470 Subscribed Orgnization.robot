*** Settings ***
Library           SeleniumLibrary
Resource          resource.robot
Resource          stepgroup.robot

*** Test Cases ***
Validate user is able to click the Technical Committees link from Nav bar and outbound correct page will be navigated(https://www.astm.org/COMMIT/newcommit.html)
    Open Chromium Browser    https://qa-compass.astm.org/home/
    Web UI Click Element    username
    Web UI Input Text    username    user2
    Web UI Click Element    password
    Web UI Input Text    password    user
    Click Button    //*[@id="login-page"]/div/form/div[3]/button[2]
    Web UI Click Element    //*[@id="app-header"]/nav[1]/a/label
    Web UI Click Element    //*[@id="sidebar"]/p[3]
    switch window    url=https://www.astm.org/COMMIT/newcommit.html
    location should be    https://www.astm.org/COMMIT/newcommit.html
    switch window    url=https://qa-compass.astm.org/home/

Validate user is able to click the Membership link from Nav bar and outbound correct page will be navigated(https://www.astm.org/MEMBERSHIP/index.html)
    Web UI Click Element    //*[@id="app-header"]/nav[1]/a/label
    Web UI Click Element    //*[@id="sidebar"]/p[4]
    switch window    url=https://www.astm.org/MEMBERSHIP/index.html
    location should be    https://www.astm.org/MEMBERSHIP/index.html
    switch window    url=https://qa-compass.astm.org/home/

Validate user is able to click the Meetings and Symposia link from Nav bar and outbound correct page will be navigated(https://www.astm.org/MEETINGS/index.html)
    Web UI Click Element    //*[@id="app-header"]/nav[1]/a/label
    Web UI Click Element    //*[@id="sidebar"]/p[5]
    switch window    url=https://www.astm.org/MEETINGS/index.html
    location should be    https://www.astm.org/MEETINGS/index.html
    switch window    url=https://qa-compass.astm.org/home/

Validate user is able to click the Publish with ASTM link from Nav bar and outbound correct page will be navigated(https://www.astm.org/PUBLISH/)
    Web UI Click Element    //*[@id="app-header"]/nav[1]/a/label
    Web UI Click Element    //*[@id="sidebar"]/p[6]
    switch window    url=https://www.astm.org/PUBLISH/
    location should be    https://www.astm.org/PUBLISH/
    switch window    url=https://qa-compass.astm.org/home/
