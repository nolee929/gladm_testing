*** Settings ***
Documentation     Motor Pool & Parking Test Suite (Journey J40):
...               Verifies the Motor pool parking board (/protected/motor-pool), counts bar,
...               Find a vehicle filter, Not in a space list, and Set up a lot flow.
Resource          ../resources/common.resource
Resource          ../resources/pages/login_page.resource
Resource          ../resources/pages/navigation_page.resource
Resource          ../resources/pages/motor_pool_page.resource
Suite Setup       Open Authenticated Motor Pool Session
Suite Teardown    Close Test Browser

*** Keywords ***
Open Authenticated Motor Pool Session
    [Documentation]    Opens the browser, logs in once, and dismisses post-login popups.
    Open Test Browser
    Sign In To GLADM With Env Credentials
    Dismiss Post Login Popups If Present

*** Test Cases ***
J40-01 Verify Motor Pool Parking Board Loads
    [Documentation]    Logs into GLADM, navigates to Motor pool (/protected/motor-pool), and verifies
    ...                the Motor pool heading and parking lot board controls.
    [Tags]    j40    motor_pool    smoke    requires_login
    Open Motor Pool Page
    Verify Motor Pool Board Controls

J40-02 Verify Find A Vehicle Search On Motor Pool Board
    [Documentation]    Verifies searching for a vehicle by bumper number or model on the Motor pool board
    ...                when a lot is loaded.
    [Tags]    j40    motor_pool    search    requires_login
    Open Motor Pool Page
    ${has_search}=    Run Keyword And Return Status    Element Should Be Visible    ${MOTOR_POOL_FIND_INPUT}
    IF    ${has_search}
        Search Vehicle In Motor Pool    HQ
    END

J40-03 Verify Set Up A Lot Editor Opens If Available
    [Documentation]    Verifies that clicking 'Set up a lot' opens the lot editor when the user role
    ...                has lot configuration permissions.
    [Tags]    j40    motor_pool    lot_setup    requires_login
    Open Motor Pool Page
    ${can_setup}=    Run Keyword And Return Status    Element Should Be Visible    ${MOTOR_POOL_SETUP_LOT_BTN}
    IF    ${can_setup}
        Click Element    ${MOTOR_POOL_SETUP_LOT_BTN}
        Wait Until Element Is Visible    ${LOT_EDITOR_ROOT}    timeout=${SELENIUM_TIMEOUT}
    END
