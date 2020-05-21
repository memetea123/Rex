*** Settings ***
Library           SeleniumLibrary
Resource          resource.robot
Resource          stepgroup.robot

*** Test Cases ***
Validate user is able to click the Favorites link from the Nav bar and Favorites page will be navigated
    Open Chromium Browser    https://qa-compass.astm.org/
    Click Element    username
    Input Text    username    user3
    Click Element    password
    Input Text    password    user
    Click Element    //*[@id="login-page"]/div/form/div[3]/button[2]
    Click Element    //*[@id="app-view-container"]/div/div/div[1]/div/p[1]
    Click Element    //*[@id="app-header"]/nav[1]/a/label
    Click Element    //*[@id="sidebar"]/div[4]/p
    location should be    https://qa-compass.astm.org/favorites

Validate static text My Favorites is displayed as a heading the Favorites page
    Element should contain    //*[@id="app-view-container"]/div/div/h2    My Favorites

Validate static text 'My Favorites lists your favorite standards and technical papers, making it easy to get back to the exact document you are researching. You can create a Favorite by clicking on the Favorite link at the top of each standard or technical document page. From this list page, you can Delete a Favorite' is displayed below the My Favorites heading
    Element should contain    //*[@id="app-view-container"]/div/div/p    My Favorites lists your favorite standards and technical papers, making it easy to get back to the exact document you are researching. You can create a Favorite by clicking on the Favorite link at the top of each standard or technical document page. From this list page, you can Delete a Favorite.

Validate if user never bookmark a document , once user navigate to the My Favorites page , static text 'There are no records to display' will be displayed
    Open Chromium Browser    https://qa-compass.astm.org/
    Click Element    username
    Input Text    username    user3
    Click Element    password
    Input Text    password    user
    Click Element    //*[@id="login-page"]/div/form/div[3]/button[2]
    Click Element    //*[@id="app-view-container"]/div/div/div[1]/div/p[1]
    Click Element    //*[@id="app-header"]/nav[1]/a/label
    Click Element    //*[@id="sidebar"]/div[4]/p
    Element should contain    //*[@id="app-view-container"]/div/div/div/p    There are no records to display.
