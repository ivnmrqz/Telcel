*** Settings ***
Resource    ../Resources/Resource.robot


*** Variables ***
${User}
${Password}
${UserDis}
${PasswordDis}

*** Keywords ***
Realizo carga de tc
    [Documentation]
    ...                Se realiza la carga de un archivo de excel que contiene los datos del cliente
    [Arguments]   ${TC}

    ${TC} =     convert to number    ${TC}
    ${Counter} =  Evaluate     ${TC} + 1
        Run Keyword If     ${Counter} == 2     Open Excel Document    ${CSV}      ${Hoja}
    ${User} =                 Read Excel Cell    row_num=${Counter}      col_num=1
        set global variable     ${User}
        log to console            UserId: ${User}
    ${Password} =             Read Excel Cell    row_num=${Counter}      col_num=2
        set global variable     ${Password}
        log to console            UserId: ${Password}
   ${UserDis} =                 Read Excel Cell    row_num=${Counter}      col_num=3
        set global variable     ${UserDis}
        log to console            UserId: ${UserDis}
    ${PasswordDis} =             Read Excel Cell    row_num=${Counter}      col_num=4
        set global variable     ${PasswordDis}
        log to console            UserId: ${PasswordDis}
Assert to element
    [Arguments]    ${Element}   ${Timeout}      ${MsError}
    wait until element is visible   ${Element}  ${Timeout}      ${MsError}


assert click element
    [Arguments]    ${Element}   ${Timeout}      ${MsError}
    wait until element is visible   ${Element}  ${Timeout}  ${MsError}
    wait until element is enabled   ${Element}  ${Timeout}
    click element    ${Element}

assert input text
    [Arguments]    ${Element}  ${Text}  ${Timeout}
    wait until element is visible   ${Element}  ${Timeout}
    wait until element is enabled   ${Element}  ${Timeout}
    clear element text    ${Element}
    input text    ${Element}    ${Text}

Scroll to element
    [Arguments]    ${scroll_to_element}
    ${x} =    Get Horizontal Position    ${scroll_to_element}
    ${y} =    Get Vertical Position      ${scroll_to_element}
    Execute Javascript    window.scrollTo(${x}, ${y})

Scroll down until you find element
    [Arguments]    ${locator}
    FOR    ${index}    IN RANGE    1    10
        Sleep    0.5s
        ${isElementVisible} =    Run Keyword and Return Status    Click Element    ${locator}
        Run Keyword If    '${isElementVisible}'!='True'    Wait Until Keyword Succeeds    6s    2s    Scroll to element   ${locator}
        Log    ${isElementVisible}
        Exit For Loop If    '${isElementVisible}'=='True'
    END
    Wait Until Element is Visible    ${locator}


Compare text from an xpath
    [Arguments]    ${Xpath}     ${Text}     ${Separator}
    ${Xpathtext}=    get text    ${xpath}
    ${Xpathtext}=    split string    ${Xpathtext}     ${Separator}
    ${Xpathtext}=    convert to string    ${Xpathtext}[1]
    should be equal    ${Xpathtext}     ${Text}




