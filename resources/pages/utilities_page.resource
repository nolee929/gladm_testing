*** Settings ***
Documentation     Page Object for GLADM Utilities App (J48–J57):
...               Utilities Home (/protected/utilities), Utilities Requests (/protected/utilities/requests),
...               Ask for Utilities (/protected/utilities/requests/new), Utilities Operations
...               (/protected/utilities/operations), Utilities Board (/protected/utilities/board),
...               and Utilities Reports (/protected/reports/utilities-dispatchers, /protected/reports/utilities-licences).
Library           SeleniumLibrary
Resource          ../../variables/config.resource

*** Variables ***
${UTILITIES_HOME_URL}               ${BASE_URL}/protected/utilities
${UTILITIES_REQUESTS_URL}           ${BASE_URL}/protected/utilities/requests
${UTILITIES_REQUEST_NEW_URL}        ${BASE_URL}/protected/utilities/requests/new
${UTILITIES_OPERATIONS_URL}         ${BASE_URL}/protected/utilities/operations
${UTILITIES_BOARD_URL}              ${BASE_URL}/protected/utilities/board
${UTILITIES_DISPATCHERS_REPORT_URL}    ${BASE_URL}/protected/reports/utilities-dispatchers
${UTILITIES_LICENCES_REPORT_URL}    ${BASE_URL}/protected/reports/utilities-licences

# Locators
${UTILITIES_HEADING}                xpath=//h1[normalize-space()='Utilities']
${UTILITIES_REQUESTS_HEADING}       xpath=//h1[normalize-space()='Utilities requests']
${UTILITIES_OPERATIONS_HEADING}     xpath=//h1[normalize-space()='Utilities operations']
${UTILITIES_BOARD_HEADING}          xpath=//h1[normalize-space()='Utilities board']
${UTILITIES_BOARD_ROOT}             css=[data-testid='ut-board']
${UT_ADD_LOCATION_BTN}              css=[data-testid='ut-add-location']
${UT_ADD_SERVICE_BTN}               css=[data-testid='ut-add-service']
${UT_ASK_CONFIRM_BTN}               css=[data-testid='ut-ask-confirm']
${UT_DISPATCHERS_HEADING}           xpath=//h1[normalize-space()='Dispatcher activity']
${UT_LICENCES_HEADING}              xpath=//h1[normalize-space()='License coverage']

*** Keywords ***
Open Utilities Home Page
    [Documentation]    Navigates to Utilities Home (/protected/utilities).
    Go To    ${UTILITIES_HOME_URL}
    Wait Until Element Is Visible    ${UTILITIES_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open Utilities Requests Page
    [Documentation]    Navigates to Utilities requests (/protected/utilities/requests).
    Go To    ${UTILITIES_REQUESTS_URL}
    Wait Until Element Is Visible    ${UTILITIES_REQUESTS_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open Ask For Utilities Page
    [Documentation]    Navigates to the new Utilities request form (/protected/utilities/requests/new).
    Go To    ${UTILITIES_REQUEST_NEW_URL}
    Wait Until Page Contains         When and where    timeout=${SELENIUM_TIMEOUT}

Open Utilities Operations Page
    [Documentation]    Navigates to Utilities operations (/protected/utilities/operations).
    Go To    ${UTILITIES_OPERATIONS_URL}
    Wait Until Element Is Visible    ${UTILITIES_OPERATIONS_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open Utilities Board Page
    [Documentation]    Navigates to the Utilities board (/protected/utilities/board).
    Go To    ${UTILITIES_BOARD_URL}
    Wait Until Element Is Visible    ${UTILITIES_BOARD_HEADING}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${UTILITIES_BOARD_ROOT}       timeout=${SELENIUM_TIMEOUT}

Open Utilities Dispatcher Activity Report
    [Documentation]    Navigates to the Utilities Dispatcher activity report (/protected/reports/utilities-dispatchers).
    Go To    ${UTILITIES_DISPATCHERS_REPORT_URL}
    Wait Until Element Is Visible    ${UT_DISPATCHERS_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open Utilities License Coverage Report
    [Documentation]    Navigates to the Utilities License coverage report (/protected/reports/utilities-licences).
    Go To    ${UTILITIES_LICENCES_REPORT_URL}
    Wait Until Element Is Visible    ${UT_LICENCES_HEADING}    timeout=${SELENIUM_TIMEOUT}
