
*** Settings ***
Resource    ../Resources/Resource.robot
Resource    ../Resources/Keywords.robot

*** Keywords ***
Entonces realizo la busqueda de un numero
    assert input text    ${Inumero}


numero de filas
    [Documentation]    leyendo el numero de filas
    ${res}=     Numero_filas    numeros
    [Return]    ${res}

obteniendo valor columnas
    [Documentation]    obteniendo el valor de las columnas
    [Arguments]    ${hoja}   ${fila}     ${col}
    ${res}=     Dato_columna    ${hoja}   ${fila}     ${col}
    [Return]    ${res}

valida texto
    [Arguments]    ${numero}
    ${filas}=    numero de filas
    ${i}=   convert to integer    0
    ${repeticion}=  convert to integer    5
    FOR  ${result}  IN  ${repeticion}
       Input text          ${inumero}   ${numero}
       sleep    1
       ${inserted_text} =  get element attribute    ${inumero}      value
       ${num}=  convert to string       ${numero}
       ${inserted_text}=    convert to string    ${inserted_text}
       log to console   texto insertado${inserted_text}
       log to console    numero${numero}
       IF    ${inserted_text}==${numero}    BREAK

    END

Entonces Registro resultado
    ${filas}=   numero de filas
    FOR    ${i}     IN RANGE    2   ${filas}+1
    ${numero}=  obteniendo valor columnas       numeros     ${i}    1
     wait until element is enabled    ${inumero}    25
     sleep    1
     valida texto   ${numero}
     #input text    ${inumero}    ${numero}
     sleep    1
     wait until element is enabled    ${btnbuscar}      30      Error: kmkk
     click element      ${btnbuscar}
     wait until element is not visible    ${divModal}       80
     ${posicion}=   convert to string    ${i}
     ${imprime resultado}     run keyword and return status    wait until element is visible    ${lblResultado}       60      Error:No se visualizo el resultado
     log to console    no se muestra resultado${imprime resultado}
     run keyword if    ${imprime resultado}   escribir resultado     ${posicion}
     ...    ELSE     ingresa de nuevo al modulo renovacion


    END


escribir resultado
    [Arguments]    ${posicion}
     sleep    1

     ${resultado}=  get text    ${lblresultado}
     log to console    resultadooooo${resultado}
     ${resultado}=   convert to string    ${resultado}
     escribe_mensaje    ${posicion}    ${resultado}
     ${flag}     run keyword and return status    element should be enabled  ${btnContinuar}
     log to console    bandera continuar${flag}
     run keyword if    ${flag}   validar datos de renovacion     ${posicion}
     ...    ELSE     ingresa de nuevo al modulo renovacion

validar datos de renovacion
    [Arguments]    ${i}
    wait until element is not visible    ${divModal}       80
    sleep    2
    click element    ${btnContinuar}
    sleep    2
    ${flag}     run keyword and return status     wait until element is visible    ${lbldiasrestantes}      30      Error:No se visualizo los dias restantes
     log to console    no se muestra dias restantes${flag}
     run keyword if    ${flag}   Escribir datos de renovacion     ${i}
     ...    ELSE     ingresa de nuevo al modulo renovacion
Escribir datos de renovacion
    [Arguments]    ${i}
    sleep    1
    wait until element is visible    ${lbldiasrestantes}        30      Error:No se visualizo los dias restantes
    ${equipo}=   get text           ${lblequipo}
    ${financiamiento}=  get text    ${lblfinanciamiento}
    ${plazoactual}=     get text    ${lblplazoactual}
    ${plazorestante}=   get text    ${lblplazorestante}
    ${diasrestantes}=   get text    ${lbldiasrestantes}
    ${equipo}=          convert to string    ${equipo}
    ${financiamiento}=  convert to string    ${financiamiento}
    ${plazoactual}=     convert to string    ${plazoactual}
    ${plazorestante}=   convert to string    ${plazorestante}
    ${diasrestantes}=   convert to string    ${diasrestantes}
    escribe_resultado   ${i}    ${equipo}   ${financiamiento}      ${plazoactual}   ${plazorestante}    ${diasrestantes}
    ${Diasrestint}=         convert to integer    ${diasrestantes}
    log to console    dias restantes int${Diasrestint}
    ${numero}=  convert to integer    90
    #${flag}     run keyword and return status    element should be enabled    ${btnContinuar2}
    #run keyword if    ${flag}   Obtener datos para renovacion   ${i}
    run keyword if    ${Diasrestint}<=${numero}     Obtener datos para renovacion   ${i}
    ...    ELSE     ingresa de nuevo al modulo renovacion

ingresa de nuevo al modulo renovacion
    reload page
    assert click element     ${btntramites}      5       Error:No se pudo acceder al módulo de Tramites en línea
    assert click element     ${hrefrenovacion}   5       Error:No se pudo acceder al servicio de renovaciones
    assert to element        ${lblRenovacion}    5       Error: No se visualiza el módulo de renovaciones


Obtener datos para renovacion
    [Arguments]    ${i}
    assert click element    ${btnContinuar2}        25       Error:No se pudo obtener los datos de renovacion
    ${Appaterno}=   get element attribute       ${lblAppaterno}        value
    ${Apmaterno}=   get element attribute       ${lblApmaterno}        value
    ${Nombre}=      get element attribute       ${lblNombre}           value
    ${Rfc}=         get element attribute       ${lblRfc}              value
    scroll element into view    ${lblmail}
    ${Email}=       get element attribute       ${lblmail}             value
    scroll element into view    ${lbltcalle}
    ${TCalle}=      get text                   ${lbltcalle}
    scroll element into view    ${lblcalle}
    ${Calle}=       get element attribute       ${lblcalle}            value
    scroll element into view    ${lblnumext}
    ${NumExt}=      get element attribute       ${lblnumext}           value
    scroll element into view    ${lblnumint}
    ${NumInt}=      get element attribute       ${lblnumint}           value
    scroll element into view    ${lblcp}
    ${Cp}=          get element attribute       ${lblcp}               value
    scroll element into view    ${lblmunicipio}
    ${Municipio}=   get element attribute       ${lblmunicipio}        value
    scroll element into view    ${lblestado}
    ${Estado}=      get element attribute       ${lblestado}           value
    scroll element into view    ${lblciudad}
    ${Ciudad}=      get element attribute       ${lblciudad}           value
    scroll element into view    ${lblcolonia}
    ${Colonia}=     get element attribute       ${lblcolonia}          value
    scroll element into view    ${lblmetodopago}
    ${MetodoPago}=      get text                ${lblmetodopago}
    scroll element into view    ${lbloferta}
    ${Oferta}=          get text                ${lbloferta}
    ${Appaterno}=       convert to string    ${Appaterno}
    ${Apmaterno}=       convert to string    ${Apmaterno}
    ${Nombre}=          convert to string    ${Nombre}
    ${Rfc}=             convert to string    ${Rfc}
    ${Email}=           convert to string    ${Email}
    ${TCalle}=          convert to string    ${TCalle}
    ${Calle}=           convert to string    ${Calle}
    ${NumExt}=          convert to string    ${NumExt}
    ${NumInt}=          convert to string    ${NumInt}
    ${Cp}=              convert to string    ${Cp}
    ${Municipio}=       convert to string    ${Municipio}
    ${Estado}=          convert to string    ${Estado}
    ${Ciudad}=          convert to string    ${Ciudad}
    ${Colonia}=         convert to string    ${Colonia}
    ${MetodoPago}=      convert to string    ${MetodoPago}
    ${Oferta}=          convert to string    ${Oferta}
    escribe_datos_renovacion    ${i}    ${Appaterno}    ${Apmaterno}    ${Nombre}   ${Rfc}  ${Email}        ${TCalle}   ${Calle}    ${NumExt}   ${NumInt}   ${Cp}   ${Municipio}    ${Estado}   ${Ciudad}   ${Colonia}  ${MetodoPago}   ${Oferta}
    reload page
    assert click element     ${btntramites}      5       Error:No se pudo acceder al módulo de Tramites en línea
    assert click element     ${hrefrenovacion}   5       Error:No se pudo acceder al servicio de renovaciones
    assert to element        ${lblRenovacion}    5       Error: No se visualiza el módulo de renovaciones



