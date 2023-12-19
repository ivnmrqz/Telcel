*** Settings ***
Resource    ../Resources/Keywords.robot
Resource    ../Keywords/LoginKeywords.robot
Resource    ../Keywords/homeKeywords.robot
Resource    ../Keywords/RenovacionesKeywords.robot


*** Test Cases ***
Validar renovacion de planes
    [Documentation]    Validar el tiempo que tienen los números teléfonicos para renovar su plan tarifario
    [Tags]    Renovacion
    Realizo carga de tc     1
    Cuando el usuario abre el navegador
    Entonces inicio sesión
    Y valido el inicio de sesión
    Cuando accedo al modulo distribuidor
    Entonces inicio sesion como distribuidor
    y valido si inicie sesión
    Cuando accedo al modulo de renovaciones
    Entonces Registro resultado




