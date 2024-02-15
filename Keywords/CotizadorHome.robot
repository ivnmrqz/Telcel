*** Settings ***
Resource    ../Resources/Resource.robot
Resource    ../Resources/Keywords.robot
*** Keywords ***
Cuando el usuario abre el navegador
    open browser    ${urlCot}      ${Browser}
        maximize browser window
            set selenium implicit wait    10
                Set Selenium Speed        .1s

Entonces inicio sesion como cotizador
    sleep    10
    #assert click element    ${BtnEntendidoCot}          30      Error:No se visualiza mensaje de Entendido

    assert click element    ${BtnRegion}            30          Error:No se pudo visualizar la región
    assert click element    ${Btn9}         30          Error:No se pudo seleccionar la region
    assert click element    ${BtnAplicar}       30          Error:No se pudo dar click en Aplicar
    assert input text   ${TxtUserCot}  ${UserCotizador}     25
    assert input text   ${TxtPassCot}  ${PasswordDis}           25
    #assert click element    ${BtnEntendidoCot}      30      Error:No se pudo dar click en el botón entendido
    sleep   5


    #assert click element    ${BtnLoginDis}    5        Error:No se pudo dar clic en el botón de inicio de sesión
