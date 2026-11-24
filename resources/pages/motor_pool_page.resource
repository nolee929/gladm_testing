*** Settings ***
Documentation     Page Object for GLADM Motor Pool & Parking (J40):
...               Motor pool parking board (/protected/motor-pool), counts bar, Find a vehicle,
...               Not in a space list, and Set up a lot editor.
Library           SeleniumLibrary
Resource          ../../variables/config.resource

*** Variables ***
${MOTOR_POOL_URL}                   ${BASE_URL}/protected/motor-pool
${MOTOR_POOL_HEADING}               xpath=//h1[normalize-space()='Motor pool']
${MOTOR_POOL_COUNTS}                css=[data-slot='motorpool-counts']
${MOTOR_POOL_FIND_INPUT}            xpath=//input[@placeholder='Bumper number, serial or model']
${MOTOR_POOL_NOT_IN_SPACE}          id=motorpool-not-in-space
${MOTOR_POOL_DRAWER}                css=[data-slot='motorpool-drawer']
${MOTOR_POOL_SETUP_LOT_BTN}         xpath=//a[contains(.,'Set up a lot') or contains(.,'Set up lot')] | //button[contains(.,'Set up a lot') or contains(.,'Set up lot')]
${LOT_EDITOR_ROOT}                  css=[data-slot='lot-editor']

*** Keywords ***
Open Motor Pool Page
    [Documentation]    Navigates directly to the Motor Pool page (/protected/motor-pool).
    Go To    ${MOTOR_POOL_URL}
    Wait Until Element Is Visible    ${MOTOR_POOL_HEADING}    timeout=${SELENIUM_TIMEOUT}

Verify Motor Pool Board Controls
    [Documentation]    Verifies the Motor Pool heading, counts strip or empty lot state, and Find a vehicle search box.
    Wait Until Element Is Visible    ${MOTOR_POOL_HEADING}    timeout=${SELENIUM_TIMEOUT}
    ${has_counts}=    Run Keyword And Return Status    Element Should Be Visible    ${MOTOR_POOL_COUNTS}
    IF    ${has_counts}
        Element Should Be Visible    ${MOTOR_POOL_FIND_INPUT}
    ELSE
        Page Should Contain    Motor pool
    END

Search Vehicle In Motor Pool
    [Documentation]    Types a query into 'Find a vehicle' on the Motor Pool board.
    [Arguments]    ${query}
    Wait Until Element Is Visible    ${MOTOR_POOL_FIND_INPUT}    timeout=${SELENIUM_TIMEOUT}
    Clear Element Text    ${MOTOR_POOL_FIND_INPUT}
    Input Text    ${MOTOR_POOL_FIND_INPUT}    ${query}
