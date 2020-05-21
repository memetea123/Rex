*** Settings ***
Library           SeleniumLibrary
Resource          resource.robot
Resource          stepgroup.robot

*** Test Cases ***
Validate user is able to click the Favorites link from the Nav bar and Favorites page will be navigated
    Open Chromium Browser    https://qa-compass.astm.org/
    Web UI Click Element    username
    Input Text    username    user1
    Web UI Click Element    password
    Input Text    password    user
    Web UI Click Element    //*[@id="login-page"]/div/form/div[3]/button[2]
    Web UI Click Element    //*[@id="app-view-container"]/div/div/div[1]/div/p[1]
    Web UI Click Element    //*[@id="app-header"]/nav[1]/a/label
    Web UI Click Element    //*[@id="sidebar"]/div[4]/p/a
    location should be    https://qa-compass.astm.org/favorites

Validate static text My Favorites is displayed as a heading the Favorites page
    Element should contain    //*[@id="app-view-container"]/div/div/h2    My Favorites

Validate static text 'My Favorites lists your favorite standards and technical papers, making it easy to get back to the exact document you are researching. You can create a Favorite by clicking on the Favorite link at the top of each standard or technical document page. From this list page, you can Delete a Favorite' is displayed below the My Favorites heading
    Element should contain    //*[@id="app-view-container"]/div/div/p    My Favorites lists your favorite standards and technical papers, making it easy to get back to the exact document you are researching. You can create a Favorite by clicking on the Favorite link at the top of each standard or technical document page. From this list page, you can Delete a Favorite.

Validate user is able to click the document link and document page will be navigated
    Web UI Click Element    //*[@id="app-view-container"]/div/div/div/table/tbody/tr[1]/td[1]/a
    Element should contain    //*[@id="app-view-container"]/div/div/p/span[3]/span/span    Download

Validate user is able to click Delete link and confirmation window will be displayed
    Web UI Click Element    //*[@id="app-view-container"]/div/div/div/table/tbody/tr[1]/td[2]/a
    Element should contain    //*[@id="exampleModalLabel"]    Confirm delete operation
    Web UI Click Element    /html/body/div[2]/div/div[1]/div/div/div[3]/button[2]

Validate if user never bookmark a document , once user navigate to the My Favorites page , static text 'There are no records to display' will be displayed
    Open Chromium Browser    https://qa-compass.astm.org/
    Web UI Click Element    username
    Input Text    username    user3
    Web UI Click Element    password
    Input Text    password    user
    Web UI Click Element    //*[@id="login-page"]/div/form/div[3]/button[2]
    Web UI Click Element    //*[@id="app-view-container"]/div/div/div[1]/div/p[1]
    Web UI Click Element    //*[@id="app-header"]/nav[1]/a/label
    Web UI Click Element    //*[@id="sidebar"]/div[4]/p/a
    Element should contain    //*[@id="app-view-container"]/div/div/div/p    There are no records to display.
