*** Settings ***
Resource    ../Resources/Resource.robot
Resource    ../Resources/Keywords.robot
*** Keywords ***
Cuando el usuario abre el navegador
    open browser    ${url}      ${Browser}
        maximize browser window
            set selenium implicit wait    10
                Set Selenium Speed        .1s

Entonces inicio sesión
    assert input text   ${TxtUser}  ${User}     5
    assert input text   ${TxtPass}  ${Password}     5
    select from list by index   cmbRegiones       9
    assert click element    ${BtnLogin}    5        Error:No se pudo dar clic en el botón de inicio de sesión

Y valido el inicio de sesión
    assert to element       ${Lblhome}      10       Error:No se pudo iniciar sesión de manera correcta
