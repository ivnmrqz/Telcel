
*** Settings ***
Resource    ../Resources/Resource.robot
Resource    ../Resources/Keywords.robot

*** Keywords ***
Cuando accedo al modulo distribuidor
    assert click element    ${btnActivaciones}      5       Error:No se pudo dar clic en el botón Activaciones
    assert click element    ${btntransforma}        5       Error:No se pudo dar clic en el botón Transforma
    Switch Window    NEW


Entonces inicio sesion como distribuidor
    assert input text   ${TxtUserDis}  ${UserDis}     5
    assert input text   ${TxtPassDis}  ${PasswordDis}     5
    assert click element    ${BtnLoginDis}    5        Error:No se pudo dar clic en el botón de inicio de sesión


y valido si inicie sesión
    ${bandera}     run keyword and return status    wait until element is visible    ${lblR9}   10
    log to console   banderaaa ${bandera}
    sleep    3
    run keyword if    ${bandera}!=True    Entonces inicio sesion como distribuidor


Cuando accedo al modulo de renovaciones
   assert click element     ${btntramites}      20       Error:No se pudo acceder al módulo de Tramites en línea
   assert click element     ${hrefrenovacion}   20       Error:No se pudo acceder al servicio de renovaciones
   assert to element        ${lblRenovacion}    20       Error: No se visualiza el módulo de renovaciones