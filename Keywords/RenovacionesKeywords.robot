
*** Settings ***
Resource    ../Resources/Resource.robot
Resource    ../Resources/Keywords.robot

*** Keywords ***
Entonces realizo la busqueda de un numero
    assert input text    ${Inumero}


numero de filas
    [Documentation]    leyendo el numero de filas
    [Arguments]     ${nombreDoc}
    ${res}=     Numero_filas    ${nombreDoc}    numeros
    [Return]    ${res}

obteniendo valor columnas
    [Documentation]    obteniendo el valor de las columnas
    [Arguments]   ${nombreDoc}  ${hoja}   ${fila}     ${col}
    ${res}=     Dato_columna    ${nombreDoc}    ${hoja}   ${fila}     ${col}
    [Return]    ${res}



Entonces Registro resultado
    [Arguments]   ${nombreDoc}
    ${filas}=   numero de filas     ${nombreDoc}
    FOR    ${i}     IN RANGE    2   ${filas}+1
    ${numero}=  obteniendo valor columnas  ${nombreDoc}     numeros     ${i}    1
     wait until element is enabled    ${inumero}    25
     sleep    1
     valida texto   ${numero}   ${nombreDoc}
     sleep    1
     wait until element is enabled    ${btnbuscar}      30      Error: kmkk
     click element      ${btnbuscar}
     wait until element is not visible    ${divModal}       80
     ${posicion}=   convert to string    ${i}
     ${imprime resultado}     run keyword and return status    wait until element is visible    ${lblResultado}       60      Error:No se visualizo el resultado
     log to console    no se muestra resultado${imprime resultado}
     run keyword if    ${imprime resultado}   escribir resultado     ${posicion}    ${nombreDoc}    ${numero}
     ...    ELSE     ingresa de nuevo al modulo renovacion


    END
valida texto
    [Arguments]    ${numero}    ${nombreDoc}
    ${filas}=    numero de filas    ${nombreDoc}

    FOR    ${Result}    IN RANGE    5
       Input text          ${inumero}   ${numero}
       sleep    1
       ${inserted_text} =  get element attribute    ${inumero}      value
       ${num}=  convert to string       ${numero}
       ${inserted_text}=  replace string     ${inserted_text}   _       0
       log to console   texto insertado${inserted_text}
       log to console    numero${numero}
       ${Result}=   evaluate    ${inserted_text}==${num}
       log to console    result${result}
       IF    ${Result}== True    BREAK

    END


escribir resultado
    [Arguments]    ${posicion}  ${nombreDoc}    ${telefono}
     sleep    1

     ${resultado}=  get text    ${lblresultado}
     log to console    resultadooooo${resultado}
     ${resultado}=   convert to string    ${resultado}
     escribe_mensaje    ${posicion}    ${resultado}     ${nombreDoc}
     ${flag}     run keyword and return status    element should be enabled  ${btnContinuar}
     log to console    bandera continuar${flag}
     run keyword if    ${flag}   validar datos de renovacion     ${posicion}    ${nombreDoc}    ${telefono}
     ...    ELSE     ingresa de nuevo al modulo renovacion

validar datos de renovacion
    [Arguments]    ${i}   ${nombreDoc}  ${telefono}
    wait until element is not visible    ${divModal}       80
    sleep    2
    click element    ${btnContinuar}
    sleep    2
    ${flag}     run keyword and return status     wait until element is visible    ${lbldiasrestantes}      30      Error:No se visualizo los dias restantes
     log to console    no se muestra dias restantes${flag}
     run keyword if    ${flag}   Escribir datos de renovacion     ${i}  ${nombreDoc}    ${telefono}
     ...    ELSE     ingresa de nuevo al modulo renovacion
Escribir datos de renovacion
    [Arguments]    ${i}     ${nombreDoc}    ${telefono}
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
    escribe_resultado   ${i}    ${equipo}   ${financiamiento}      ${plazoactual}   ${plazorestante}    ${diasrestantes}    ${nombreDoc}
    ${Diasrestint}=         convert to integer    ${diasrestantes}
    log to console    dias restantes int${Diasrestint}
    ${numero}=  convert to integer    90
    #${flag}     run keyword and return status    element should be enabled    ${btnContinuar2}
    #run keyword if    ${flag}   Obtener datos para renovacion   ${i}
    run keyword if    ${Diasrestint}<=${numero}     Obtener datos para renovacion   ${i}   ${nombreDoc}
    #...    ELSE     ingresa de nuevo al modulo renovacion
    ...    ELSE     Ingresamos al modulo de oferta primaria     ${telefono}       ${i}        ${nombreDoc}


Ingresamos al modulo de oferta primaria
    [Arguments]     ${numero}   ${i}     ${nombreDoc}
    reload page
    sleep    2
    assert click element     ${btntramites}      5       Error:No se pudo acceder al módulo de Tramites en línea
    assert click element    ${lblOfertaPrimaria}    5       Error:No se pudo acceder al módulo de oferta primaria
    log to console    numero oferta primaria${numero}
    valida texto   ${numero}   ${nombreDoc}
     sleep    1
     wait until element is enabled    ${btnbuscar}      30      Error: No esta disponible el botón de busqueda
     click element      ${btnbuscar}
     wait until element is not visible    ${divModal}       80
     click element    ${btncontinuar}
     assert to element       ${lblcambio_de_oferta_primaria}    25  Error:No se visualiza el cambio de oferta primaria
     assert to element       ${lblPlan}         25      Error:No se visualiza plan
     ${posicion}=   convert to string    ${i}
     ${imprime resultado}     run keyword and return status    wait until element is visible    ${lblplan}       60      Error:No se visualizo el plan
     log to console    no se muestra el plan${imprime resultado}
     run keyword if    ${imprime resultado}   obten plan        ${posicion}    ${nombreDoc}     ${numero}
     ...    ELSE     ingresa de nuevo al modulo renovacion


obten plan
     [Arguments]    ${posicion}  ${nombreDoc}   ${numero}
    assert to element       ${lblcambio_de_oferta_primaria}     35      Error: no se visualiza el cambio de oferta primaria
    assert to element       ${lblPlan}              35      Error: no se visualiza el plan
     sleep    2
     ${resultado}=  get text    ${lblplan}
     log to console    plan${resultado}
     ${resultado}=   convert to string    ${resultado}
     escribe_mensaje    ${posicion}    ${resultado}     ${nombreDoc}
     sleep    1
     Ingresa al modulo de activaciones
     ingresar numero de activacion  ${numero}        ${nombreDoc}       ${posicion}
ingresar numero de activacion
     [Arguments]    ${numero}        ${nombreDoc}   ${i}
     valida texto   ${numero}   ${nombreDoc}
     sleep    1
     click element      ${btnbuscarACT}
     wait until element is enabled    ${btnnewRegistro}      30      Error: No esta disponible el botón de nuevo registro
     wait until element is not visible    ${divModal}       80
     assert click element       ${btnnewRegistro}       5       Error: No esta disponible el botón de nuevo registro
     sleep   2
    Obtener datos para activacion   ${i}     ${nombreDoc}


Ingresa al modulo de activaciones
    reload page
    assert click element     ${btntramites}      5       Error:No se pudo acceder al módulo de Tramites en línea
    assert click element     ${BtnActivacion}   5       Error:No se pudo acceder al servicio de Activaciones


ingresa de nuevo al modulo renovacion
    reload page
    assert click element     ${btntramites}      5       Error:No se pudo acceder al módulo de Tramites en línea
    assert click element     ${hrefrenovacion}   5       Error:No se pudo acceder al servicio de renovaciones
    assert to element        ${lblRenovacion}    5       Error: No se visualiza el módulo de renovaciones


Obtener datos para renovacion
    [Arguments]    ${i}     ${nombreDoc}
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
    escribe_datos_renovacion    ${i}    ${Appaterno}    ${Apmaterno}    ${Nombre}   ${Rfc}  ${Email}        ${TCalle}   ${Calle}    ${NumExt}   ${NumInt}   ${Cp}   ${Municipio}    ${Estado}   ${Ciudad}   ${Colonia}  ${MetodoPago}   ${Oferta}       ${nombreDoc}
    reload page
    assert click element     ${btntramites}      5       Error:No se pudo acceder al módulo de Tramites en línea
    assert click element     ${hrefrenovacion}   5       Error:No se pudo acceder al servicio de renovaciones
    assert to element        ${lblRenovacion}    5       Error: No se visualiza el módulo de renovaciones



Obtener datos para activacion
    [Arguments]    ${i}     ${nombreDoc}
    wait until element is visible    ${lblappaterno}        30
    ${Appaterno}=   get element attribute       ${lblAppaterno}        value
    ${Apmaterno}=   get element attribute       ${lblApmaterno}        value
    ${Nombre}=      get element attribute       ${lblNombre}           value
    ${Rfc}=         get element attribute       ${lblRfc}              value
    scroll element into view    ${lblmail}
    ${Email}=       get element attribute       ${lblmail}             value
    ${TelCasa}=         get element attribute    ${lblTelCasa}           Value
    ${Teloficina}=      get element attribute    ${lblTelOficina}       value
    execute javascript          window.scrollTo(0,450)
    scroll element into view    ${lbltcalleA}
    ${TCalle}=      get element attribute       ${lbltcalleA}    value
    ${Calle}=       get element attribute       ${lblcalleA}            value
    scroll element into view    ${lblnumextA}
    ${NumExt}=      get element attribute       ${lblnumextA}           value
    scroll element into view    ${lblnumintA}
    ${NumInt}=      get element attribute       ${lblnumintA}           value
    scroll element into view    ${lblcpA}
    ${Cp}=          get element attribute       ${lblcpA}               value
    scroll element into view    ${lblmunicipioA}
    ${Municipio}=   get element attribute       ${lblmunicipioA}        value
    scroll element into view    ${lblestadoA}
    ${Estado}=      get element attribute       ${lblestadoA}           value
    scroll element into view    ${lblciudadA}
    ${Ciudad}=      get element attribute       ${lblciudadA}           value
    scroll element into view    ${lblcoloniaA}
    ${Colonia}=     get element attribute       ${lblcoloniaA}          value
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
    ${TelCasa}=      convert to string    ${lblTelCasa}
    ${Teloficina}=          convert to string    ${Teloficina}
    escribe_datos_renovacion        ${i}        ${Appaterno}        ${Apmaterno}        ${Nombre}       ${Rfc}      ${Email}        ${TCalle}       ${Calle}        ${NumExt}       ${NumInt}       ${Cp}       ${Municipio}        ${Estado}       ${Ciudad}       ${Colonia}      ${TelCasa}      ${Teloficina}       ${nombreDoc}
    reload page
    assert click element     ${btntramites}      5       Error:No se pudo acceder al módulo de Tramites en línea
    assert click element     ${hrefrenovacion}   5       Error:No se pudo acceder al servicio de renovaciones
    assert to element        ${lblRenovacion}    5       Error: No se visualiza el módulo de renovaciones
