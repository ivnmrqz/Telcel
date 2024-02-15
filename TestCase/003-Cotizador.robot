*** Settings ***
Resource    ../Resources/Keywords.robot
Resource    ../Keywords/homeKeywords.robot
Resource    ../Keywords/CotizadorHome.robot


*** Test Cases ***

Validar cotizador de planes
    [Documentation]    oopoppipo
    [Tags]    cotizador
    Realizo carga de tc     1
    Cuando el usuario abre el navegador
    Entonces inicio sesion como cotizador





