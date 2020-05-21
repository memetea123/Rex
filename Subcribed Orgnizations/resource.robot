*** Settings ***
Library           OperatingSystem

*** Variables ***
${browser}        Chrome
${download_dir}    C:\\Users\\lzhu061\\Downloads\\
${chromium_bin}    C:\\Users\\jzhang555\\Desktop\\Selenium\\Chromium\\chrome-win\\chrome.exe

*** Keywords ***
Click Element Until Added To Page
    [Arguments]    ${locator}    ${locator_added}    ${max_retry}=30
    # Retry 30 times by default
    FOR    ${retry}    IN RANGE    1    ${max_retry}
        Run Keyword And Ignore Error    Wait Until Page Contains Element    ${locator}
        Run Keyword And Ignore Error    Click Element    ${locator}
        Sleep    1s
        ${result}    ${returnvalue}    Run Keyword And Ignore Error    Page Should Contain Element    ${locator_added}
        Exit For Loop If    '${result}'=='PASS'
    END

Click Element Until Deleted From Page
    [Arguments]    ${locator}    ${max_retry}=30
    # Wait 30 times for existing before click
    FOR    ${retry}    IN RANGE    1    ${max_retry}
        Run Keyword And Ignore Error    Wait Until Element Is Visible    ${locator}    timeout=1s
        ${result}    ${returnvalue}    Run Keyword And Ignore Error    Element Should Be Visible    ${locator}
        Exit For Loop If    '${result}'=='PASS'
    END
    Sleep    1s
    # Retry 30 times by default
    FOR    ${retry}    IN RANGE    1    ${max_retry}
        Run Keyword And Ignore Error    Click Element    ${locator}
        Sleep    1s
        ${result}    ${returnvalue}    Run Keyword And Ignore Error    Page Should Not Contain Element    ${locator}
        Exit For Loop If    '${result}'=='PASS'
    END

Format Name
    [Arguments]    ${name}
    FOR    ${c}    IN    ${SPACE}    -    (    )    .    ,    /    \\    ;    =    +    #    :
        ${name}    Replace String    ${name}    ${c}    _
    END
    ${name}    Get Substring    ${name}    0    60
    [Return]    ${name}

Open Chrome Browser
    [Arguments]    ${URL}    ${width}=1600    ${height}=900
    #Launch headless browser if in CICD linux VM
    ${system}=    Evaluate    platform.system()    platform
    Run Keyword If    '${system}'=='Linux'    Open Chrome Headless    ${URL}
    Run Keyword If    '${system}'=='Linux'    Pass Execution    Launch Headless in CICD Linux VM.
    #Set Chrome Options to avoid error: (unknown error: DevToolsActivePort file doesn't exist)
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    modules=sys
    Call Method    ${options}    add_argument    disable-infobars
    Call Method    ${options}    add_argument    start-maximized
    Call Method    ${options}    add_argument    --disable-extensions
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --no-sandbox
    Create Webdriver    Chrome    my_alias    chrome_options=${options}
    Go To    ${URL}
    # Wait for page redirection
    FOR    ${retry}    IN RANGE    1    10
        ${CURRENT_URL_1} =    Get Location
        Sleep    5s
        ${CURRENT_URL_2} =    Get Location
        Exit For Loop If    '${CURRENT_URL_1}'=='${CURRENT_URL_2}'
    END

Open Chrome Headless
    [Arguments]    ${URL}    ${width}=1600    ${height}=900
    #Set Chrome Options to avoid error: (unknown error: DevToolsActivePort file doesn't exist)
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    modules=sys
    Call Method    ${options}    add_argument    disable-infobars
    Call Method    ${options}    add_argument    start-maximized
    Call Method    ${options}    add_argument    --disable-extensions
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    headless
    Create Webdriver    Chrome    my_alias    chrome_options=${options}
    Set Window Size    ${width}    ${height}
    Go To    ${URL}
    # Wait for page redirection
    FOR    ${retry}    IN RANGE    1    10
        ${CURRENT_URL_1} =    Get Location
        Sleep    5s
        ${CURRENT_URL_2} =    Get Location
        Exit For Loop If    '${CURRENT_URL_1}'=='${CURRENT_URL_2}'
    END

Open Chromium Browser
    [Arguments]    ${URL}    ${width}=1600    ${height}=900
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    modules=sys
    ${options.binary_location}    Set Variable    ${chromium_bin}
    Create Webdriver    Chrome    my_alias    chrome_options=${options}
    Go To    ${URL}
    # Wait for page redirection
    FOR    ${retry}    IN RANGE    1    10
        ${CURRENT_URL_1} =    Get Location
        Sleep    5s
        ${CURRENT_URL_2} =    Get Location
        Exit For Loop If    '${CURRENT_URL_1}'=='${CURRENT_URL_2}'
    END

Open Chromium Headless
    [Arguments]    ${URL}    ${width}=1600    ${height}=900
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    modules=sys
    ${options.binary_location}    Set Variable    ${chromium_bin}
    Call Method    ${options}    add_argument    headless
    Create Webdriver    Chrome    my_alias    chrome_options=${options}
    Go To    ${URL}
    # Wait for page redirection
    FOR    ${retry}    IN RANGE    1    10
        ${CURRENT_URL_1} =    Get Location
        Sleep    5s
        ${CURRENT_URL_2} =    Get Location
        Exit For Loop If    '${CURRENT_URL_1}'=='${CURRENT_URL_2}'
    END

Scroll Element Into View
    [Arguments]    ${element}
    Execute Javascript    var elmnt = document.evaluate("${element}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; elmnt.scrollIntoView();

Scroll To Element
    [Arguments]    ${locator}
    ${x}=    Get Horizontal Position    ${locator}
    ${y}=    Get Vertical Position    ${locator}
    Execute Javascript    window.scrollBy(${x}, ${y});

Web UI Click Element
    [Arguments]    ${locator}
    # Wait and frontend loading exception handling
    Wait Until Page Contains Element    ${locator}
    #Wait Until Element Is Visible    ${locator}
    FOR    ${retry}    IN RANGE    1    6
        Sleep    0.5s
        ${result}    ${returnvalue}    Run Keyword And Ignore Error    Click Element    ${locator}
        Continue For Loop If    """StaleElementReferenceException""" in """${returnvalue}"""
        Continue For Loop If    """ElementNotVisibleException""" in """${returnvalue}"""
        Exit For Loop If    '${result}'=='PASS'
        Should Not Be Equal As Integers    ${retry}    5
    END

Web UI Click Link
    [Arguments]    ${locator}
    # Wait and frontend loading exception handling
    Wait Until Page Contains Element    ${locator}
    #Wait Until Element Is Visible    ${locator}
    FOR    ${retry}    IN RANGE    1    6
        Sleep    0.5s
        ${result}    ${returnvalue}    Run Keyword And Ignore Error    Click Element    ${locator}
        Continue For Loop If    """StaleElementReferenceException""" in """${returnvalue}"""
        Continue For Loop If    """ElementNotVisibleException""" in """${returnvalue}"""
        Exit For Loop If    '${result}'=='PASS'
        Should Not Be Equal As Integers    ${retry}    5
    END

Web UI Input Text
    [Arguments]    ${locator}    ${text}
    # Wait and frontend loading exception handling
    Wait Until Page Contains Element    ${locator}
    FOR    ${retry}    IN RANGE    1    6
        Sleep    0.5s
        ${result}    ${returnvalue}    Run Keyword And Ignore Error    Input Text    ${locator}    ${text}
        Continue For Loop If    """StaleElementReferenceException""" in """${returnvalue}"""
        Continue For Loop If    """ElementNotVisibleException""" in """${returnvalue}"""
        Exit For Loop If    '${result}'=='PASS'
        Should Not Be Equal As Integers    ${retry}    5
    END

Web UI Input Password
    [Arguments]    ${locator}    ${text}
    # Wait and frontend loading exception handling
    Wait Until Page Contains Element    ${locator}
    FOR    ${retry}    IN RANGE    1    6
        Sleep    0.5s
        ${result}    ${returnvalue}    Run Keyword And Ignore Error    Input Password    ${locator}    ${text}
        Continue For Loop If    """StaleElementReferenceException""" in """${returnvalue}"""
        Continue For Loop If    """ElementNotVisibleException""" in """${returnvalue}"""
        Exit For Loop If    '${result}'=='PASS'
        Should Not Be Equal As Integers    ${retry}    5
    END

Web UI Select Checkbox
    [Arguments]    ${locator}
    # Wait and frontend loading exception handling
    Wait Until Page Contains Element    ${locator}
    #Wait Until Element Is Visible    ${locator}
    FOR    ${retry}    IN RANGE    1    6
        Sleep    0.5s
        ${result}    ${returnvalue}    Run Keyword And Ignore Error    Select Checkbox    ${locator}
        Continue For Loop If    """StaleElementReferenceException""" in """${returnvalue}"""
        Continue For Loop If    """ElementNotVisibleException""" in """${returnvalue}"""
        Exit For Loop If    '${result}'=='PASS'
        Should Not Be Equal As Integers    ${retry}    5
    END

Web UI Select From List
    [Arguments]    ${locator}    ${value}
    # Wait and frontend loading exception handling
    Wait Until Page Contains Element    ${locator}
    #Wait Until Element Is Visible    ${locator}
    FOR    ${retry}    IN RANGE    1    6
        Sleep    0.5s
        ${result}    ${returnvalue}    Run Keyword And Ignore Error    Select From List By Label    ${locator}    ${value}
        Continue For Loop If    """StaleElementReferenceException""" in """${returnvalue}"""
        Continue For Loop If    """ElementNotVisibleException""" in """${returnvalue}"""
        Exit For Loop If    '${result}'=='PASS'
        Should Not Be Equal As Integers    ${retry}    5
    END

Web UI Unselect Checkbox
    [Arguments]    ${locator}
    # Wait and frontend loading exception handling
    Wait Until Page Contains Element    ${locator}
    #Wait Until Element Is Visible    ${locator}
    FOR    ${retry}    IN RANGE    1    6
        Sleep    0.5s
        ${result}    ${returnvalue}    Run Keyword And Ignore Error    Unselect Checkbox    ${locator}
        Continue For Loop If    """StaleElementReferenceException""" in """${returnvalue}"""
        Continue For Loop If    """ElementNotVisibleException""" in """${returnvalue}"""
        Exit For Loop If    '${result}'=='PASS'
        Should Not Be Equal As Integers    ${retry}    5
    END

Wait Until File Download Complete
    [Arguments]    ${path}    ${filename}    ${timeout}=30
    FOR    ${retry}    IN RANGE    1    ${timeout}
        Sleep    1s
        ${result}    ${returnvalue}    Run Keyword And Ignore Error    File Should Exist    ${path}${/}${filename}
        Exit For Loop If    '${result}'=='PASS'
    END

Verify Page Should Contain Text
    [Arguments]    ${text}
    FOR    ${retry}    IN RANGE    1    7
        Sleep    5s
        ${result}    ${returnvalue}    Run Keyword And Ignore Error    Page Should Contain    ${text}
        Exit For Loop If    '${result}'=='PASS'
        Should Not Be Equal As Integers    ${retry}    6
    END

Verify Page Should Contain Element
    [Arguments]    ${locator}
    FOR    ${retry}    IN RANGE    1    7
        Sleep    5s
        ${result}    ${returnvalue}    Run Keyword And Ignore Error    Page Should Contain Element    ${locator}
        Exit For Loop If    '${result}'=='PASS'
        Should Not Be Equal As Integers    ${retry}    6
    END

JS Input Text
    [Arguments]    ${locator}    ${text}
    ${locator}=    Replace String    ${locator}    "    '
    # Wait and frontend loading exception handling
    Wait Until Page Contains Element    ${locator}
    FOR    ${retry}    IN RANGE    1    6
        Sleep    0.5s
        ${result}    ${returnvalue}    Run Keyword And Ignore Error    Clear Text    ${locator}
        ${result}    ${returnvalue}    Run Keyword And Ignore Error    Execute JavaScript    document.evaluate("${locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.value='${text}'
        ${result}    ${returnvalue}    Run Keyword And Ignore Error    Click Element    ${locator}
        Continue For Loop If    """StaleElementReferenceException""" in """${returnvalue}"""
        Continue For Loop If    """ElementNotVisibleException""" in """${returnvalue}"""
        Exit For Loop If    '${result}'=='PASS'
        Should Not Be Equal As Integers    ${retry}    5
    END
