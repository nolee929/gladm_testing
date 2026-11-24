*** Settings ***
Documentation     Page Object for GLADM Lift Planning & Move Planning (J29, J33, J64):
...               Plan moves (/protected/plans/new), Recent plans (/protected/plans),
...               Solver comparisons (/protected/plans/comparisons), and Plan the move
...               (/protected/plans/move, /protected/plans/move/new).
Library           SeleniumLibrary
Resource          ../../variables/config.resource

*** Variables ***
${RECENT_PLANS_URL}                 ${BASE_URL}/protected/plans
${PLAN_NEW_URL}                     ${BASE_URL}/protected/plans/new
${SOLVER_COMPARISONS_URL}           ${BASE_URL}/protected/plans/comparisons
${PLAN_THE_MOVE_LIST_URL}           ${BASE_URL}/protected/plans/move
${PLAN_THE_MOVE_NEW_URL}            ${BASE_URL}/protected/plans/move/new

# Plan Moves & Recent Plans (J29 / J33)
${RECENT_PLANS_HEADING}             xpath=//h1[normalize-space()='Recent plans']
${SOLVER_COMPARISONS_HEADING}       xpath=//h1[normalize-space()='Solver comparisons']
${PLAN_MOVES_SECTION}               id=plan-moves
${PLAN_VEHICLES_SECTION}            id=plan-vehicles
${PLAN_DRIVERS_SECTION}             id=plan-drivers
${PLAN_A_DRIVER_CHECK}              id=a-driver
${PLAN_WEATHER_SECTION}             id=plan-weather
${PLAN_SUBMIT_BTN}                  xpath=//button[normalize-space()='Plan']

# Plan The Move (J64)
${MOVE_PLANS_HEADING}               xpath=//h1[normalize-space()='Plans']
${PLAN_THE_MOVE_BTN}                css=[data-slot='plan-the-move']
${MOVE_PLANS_TABLE}                 css=[data-slot='move-plans']
${MOVE_FIND_PLAN_INPUT}             xpath=//input[@placeholder='Find a plan']
${MOVE_STEPS_BAR}                   css=[data-slot='move-steps']
${MOVE_NOT_ON_SITE_BANNER}          css=[data-slot='move-not-on-site']

*** Keywords ***
Open Recent Plans Page
    [Documentation]    Navigates to Recent plans (/protected/plans).
    Go To    ${RECENT_PLANS_URL}
    Wait Until Element Is Visible    ${RECENT_PLANS_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open Plan Moves Page
    [Documentation]    Navigates to the Plan moves builder (/protected/plans/new).
    Go To    ${PLAN_NEW_URL}
    Wait Until Element Is Visible    ${PLAN_MOVES_SECTION}    timeout=${SELENIUM_TIMEOUT}

Verify Plan Moves Builder Sections
    [Documentation]    Verifies Moves to plan, Vehicles, Drivers, Driver only checkbox, and Weather sections.
    Wait Until Element Is Visible    ${PLAN_MOVES_SECTION}       timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${PLAN_VEHICLES_SECTION}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${PLAN_DRIVERS_SECTION}     timeout=${SELENIUM_TIMEOUT}
    Page Should Contain              Driver only (no A-driver)

Open Solver Comparisons Page
    [Documentation]    Navigates to Solver comparisons (/protected/plans/comparisons).
    Go To    ${SOLVER_COMPARISONS_URL}
    Wait Until Element Is Visible    ${SOLVER_COMPARISONS_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open Plan The Move List Page
    [Documentation]    Navigates to Plan the move Plans list (/protected/plans/move).
    Go To    ${PLAN_THE_MOVE_LIST_URL}
    Wait Until Element Is Visible    ${MOVE_PLANS_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open Plan The Move Builder Page
    [Documentation]    Navigates to the Plan the move builder (/protected/plans/move/new).
    Go To    ${PLAN_THE_MOVE_NEW_URL}
    Wait Until Element Is Visible    xpath=//h1[contains(.,'Plan the move') or contains(.,'Build')] | //*[@data-slot='move-steps' or @data-slot='move-not-on-site']    timeout=${SELENIUM_TIMEOUT}
