*** Settings ***
Documentation     Page Object for GLADM LogC2 App (J61, J62, J63):
...               Ground troops (/protected/logc2/ground-troops), Orders (/protected/logc2/orders),
...               Receive higher's order (/protected/logc2/orders/receive), and Task organization
...               (/protected/logc2/task-org).
Library           SeleniumLibrary
Resource          ../../variables/config.resource

*** Variables ***
${GROUND_TROOPS_URL}                ${BASE_URL}/protected/logc2/ground-troops
${ORDERS_URL}                       ${BASE_URL}/protected/logc2/orders
${ORDERS_RECEIVE_URL}               ${BASE_URL}/protected/logc2/orders/receive
${TASK_ORG_URL}                     ${BASE_URL}/protected/logc2/task-org

# Ground Troops Locators (J61)
${GROUND_TROOPS_HEADING}            xpath=//h1[normalize-space()='Ground troops']
${GROUND_TROOPS_ROOT}               css=[data-slot='ground-troops']
${GROUND_TROOPS_SUMMARY}            css=[data-slot='gt-summary']
${GROUND_TROOPS_EMPTY}              css=[data-slot='gt-empty']
${GROUND_TROOPS_CONTACT_SUPPORT}    css=[data-slot='gt-contact-support']
${GROUND_TROOPS_UNIT_CARD}          css=[data-slot='unit-card']

# Orders Locators (J62)
${ORDERS_HEADING}                   xpath=//h1[normalize-space()='Orders']
${ORDERS_PAGE_SLOT}                 css=[data-slot='orders-page']
${ORDERS_EMPTY_SLOT}                css=[data-slot='orders-empty']
${ORDERS_RECEIVE_HIGHER_BTN}        css=[data-slot='receive-higher']
${ORDER_INTAKE_SLOT}                css=[data-slot='order-intake']
${ORDER_SOURCE_TEXT}                css=[data-slot='order-source-text']
${ORDER_ASK_GUNNY_BTN}              css=[data-slot='ask-gunny']
${ORDER_RECEIVE_BTN}                css=[data-slot='receive-order']

# Task Organization Locators (J63)
${TASK_ORG_HEADING}                 xpath=//h1[normalize-space()='Task organization']
${TASK_ORG_ROOT}                    css=[data-slot='task-org']
${TASK_ORG_PHASE_PICKER}            css=[data-slot='phase-picker']
${TASK_ORG_CHANGES}                 id=to-changes
${TASK_ORG_ADD_LINE_BTN}            css=[data-slot='add-line']

*** Keywords ***
Open Ground Troops Page
    [Documentation]    Navigates directly to Ground troops (/protected/logc2/ground-troops).
    Go To    ${GROUND_TROOPS_URL}
    Wait Until Element Is Visible    ${GROUND_TROOPS_HEADING}    timeout=${SELENIUM_TIMEOUT}

Verify Ground Troops View Or Empty Operation State
    [Documentation]    Verifies either the Ground troops summary/cards or the No operation yet state.
    Wait Until Element Is Visible    ${GROUND_TROOPS_HEADING}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    xpath=//*[@data-slot='ground-troops' or @data-slot='gt-summary' or @data-slot='gt-empty']    timeout=${SELENIUM_TIMEOUT}

Open Orders Page
    [Documentation]    Navigates directly to Orders (/protected/logc2/orders).
    Go To    ${ORDERS_URL}
    Wait Until Element Is Visible    ${ORDERS_HEADING}    timeout=${SELENIUM_TIMEOUT}

Verify Orders View Or Empty Operation State
    [Documentation]    Verifies either the Orders list or the No operation yet / not on this site state.
    Wait Until Element Is Visible    ${ORDERS_HEADING}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    xpath=//*[@data-slot='orders-page' or @data-slot='orders-empty' or @data-slot='orders-not-here']    timeout=${SELENIUM_TIMEOUT}

Open Receive Higher Order Page
    [Documentation]    Navigates to Receive higher's order (/protected/logc2/orders/receive).
    Go To    ${ORDERS_RECEIVE_URL}
    Wait Until Element Is Visible    xpath=//*[@data-slot='order-intake' or @data-slot='orders-empty' or @data-slot='orders-not-here'] | //h1    timeout=${SELENIUM_TIMEOUT}

Open Task Organization Page
    [Documentation]    Navigates directly to Task organization (/protected/logc2/task-org).
    Go To    ${TASK_ORG_URL}
    Wait Until Element Is Visible    ${TASK_ORG_HEADING}    timeout=${SELENIUM_TIMEOUT}

Verify Task Organization Board Or Empty Operation State
    [Documentation]    Verifies either the Task organization phase picker/board or the empty operation state.
    Wait Until Element Is Visible    ${TASK_ORG_HEADING}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    xpath=//*[@data-slot='task-org' or @data-slot='phase-picker' or @data-slot='board-empty' or @data-slot='task-org-contact-support']    timeout=${SELENIUM_TIMEOUT}
