*** Settings ***
Documentation     Utilities App Test Suite (Journeys J48–J57):
...               Verifies Utilities Home (J48), Ask for Utilities (J49), Handle & Plan Requests (J50–J52),
...               Utilities Operations — Dispatch, Log Today & Bring In (J53–J55),
...               Utilities Board (J56), and Utilities Reports (J57).
Resource          ../resources/common.resource
Resource          ../resources/pages/login_page.resource
Resource          ../resources/pages/navigation_page.resource
Resource          ../resources/pages/utilities_page.resource
Suite Setup       Open Authenticated Utilities Session
Suite Teardown    Close Test Browser

*** Keywords ***
Open Authenticated Utilities Session
    [Documentation]    Opens the browser, logs in once, and dismisses post-login popups.
    Open Test Browser
    Sign In To GLADM With Env Credentials
    Dismiss Post Login Popups If Present

*** Test Cases ***
J48-01 Verify Utilities Home Page Loads
    [Documentation]    Navigates to Utilities Home (/protected/utilities) and verifies the Utilities heading.
    [Tags]    j48    utilities    smoke    requires_login
    Open Utilities Home Page

J49-01 Verify Ask For Utilities New Request Form Loads
    [Documentation]    Navigates to the Ask for utilities form (/protected/utilities/requests/new)
    ...                and verifies the location and service controls.
    [Tags]    j49    utilities    requests    requires_login
    Open Ask For Utilities Page
    Wait Until Element Is Visible    ${UT_ADD_LOCATION_BTN}    timeout=${SELENIUM_TIMEOUT}

J50-01 Verify Utilities Requests Queue Loads
    [Documentation]    Navigates to Utilities requests (/protected/utilities/requests) for handling,
    ...                planning, and locking utilities requests (J50–J52).
    [Tags]    j50    j51    j52    utilities    requests    requires_login
    Open Utilities Requests Page

J53-01 Verify Utilities Operations Page Loads
    [Documentation]    Navigates to Utilities operations (/protected/utilities/operations) for dispatching,
    ...                logging daily hours/readings, and bringing equipment back in (J53–J55).
    [Tags]    j53    j54    j55    utilities    operations    requires_login
    Open Utilities Operations Page

J56-01 Verify Utilities Board Loads
    [Documentation]    Navigates to the Utilities board (/protected/utilities/board) and verifies
    ...                the board root element.
    [Tags]    j56    utilities    board    requires_login
    Open Utilities Board Page

J57-01 Verify Utilities Dispatcher Activity And License Coverage Reports Load
    [Documentation]    Navigates to the Utilities Dispatcher activity and License coverage reports
    ...                and verifies both report headings.
    [Tags]    j57    utilities    reports    requires_login
    Open Utilities Dispatcher Activity Report
    Open Utilities License Coverage Report
