*** Settings ***
Library           SeleniumLibrary
Resource          resource.robot
Resource          stepgroup.robot

*** Test Cases ***
Validate subscribed publishers should be displayed after user click the Subscriptions from the nav bar
    Open Chromium Browser    https://qa-compass.astm.org/home/
    Web UI Click Element    username
    Web UI Input Text    username    user3
    Web UI Click Element    password
    Web UI Input Text    password    user
    Click Button    //*[@id="login-page"]/div/form/div[3]/button[2]
    Web UI Click Element    //*[@id="app-header"]/nav[1]/a/label
    Web UI Click Element    //*[@id="sidebar"]/div[2]/p[1]
    Element should contain    //*[@id="sidebar"]/div[2]/p[2]    ASTM International
    Element should contain    //*[@id="sidebar"]/div[2]/p[3]    AASHTO
    Element should contain    //*[@id="sidebar"]/div[2]/p[4]    AATCC
    Element should contain    //*[@id="sidebar"]/div[2]/p[5]    ACI
    Element should contain    //*[@id="sidebar"]/div[2]/p[6]    AWWA
    Element should contain    //*[@id="sidebar"]/div[2]/p[7]    AWS
    Element should contain    //*[@id="sidebar"]/div[2]/p[8]    Code of Federal Regulations
    Element should contain    //*[@id="sidebar"]/div[2]/p[9]    CGA
    Element should contain    //*[@id="sidebar"]/div[2]/p[10]    IES
    Element should contain    //*[@id="sidebar"]/div[2]/p[11]    Qatar Construction Specifications
    Element should contain    //*[@id="sidebar"]/div[2]/p[12]    ISO
    Element should contain    //*[@id="sidebar"]/div[2]/p[13]    UNS
    Element should contain    //*[@id="sidebar"]/div[2]/p[14]    United State Of Department Of Defense
    Element should contain    //*[@id="sidebar"]/div[2]/p[15]    Universal Oil Products
