*** Keywords ***
Login_Commerce_Next
    [Arguments]        ${email}=fu.li+demomerge@pwc.com    ${password}=pwcwelcome8
    Open Chrome Browser    https://merge-pwcb2bcommerce.cs27.force.com/CommerceStore/ccrz__CCSiteLogin    
    Web UI Input Text    emailField    ${email}
    Web UI Input Password    passwordField    ${password}
    Web UI Click Element    send2Dsk
