*** Settings ***
Documentation     LogC2 App Test Suite (Journeys J61, J62, and J63):
...               Verifies Ground troops (/protected/logc2/ground-troops), Orders (/protected/logc2/orders),
...               Receive higher's order (/protected/logc2/orders/receive), and Task organization
...               (/protected/logc2/task-org).
Resource          ../resources/common.resource
Resource          ../resources/pages/login_page.resource
Resource          ../resources/pages/navigation_page.resource
Resource          ../resources/pages/logc2_page.resource
Suite Setup       Open Authenticated LogC2 Session
Suite Teardown    Close Test Browser

*** Keywords ***
Open Authenticated LogC2 Session
    [Documentation]    Opens the browser, logs in once, and dismisses post-login popups.
    Open Test Browser
    Sign In To GLADM With Env Credentials
    Dismiss Post Login Popups If Present

*** Test Cases ***
J61-01 Verify Ground Troops Page And Operation Status Load
    [Documentation]    Navigates to Ground troops (/protected/logc2/ground-troops) and verifies either
    ...                the operation summary and unit cards or the empty operation state.
    [Tags]    j61    logc2    ground_troops    requires_login
    Open Ground Troops Page
    Verify Ground Troops View Or Empty Operation State

J62-01 Verify Orders List And Receive Higher Order Pages Load
    [Documentation]    Navigates to Orders (/protected/logc2/orders) and Receive higher's order
    ...                (/protected/logc2/orders/receive) and verifies the Orders views.
    [Tags]    j62    logc2    orders    requires_login
    Open Orders Page
    Verify Orders View Or Empty Operation State
    Open Receive Higher Order Page

J63-01 Verify Task Organization Page And Phase Board Load
    [Documentation]    Navigates to Task organization (/protected/logc2/task-org) and verifies either
    ...                the phase picker and task organization board or the empty operation state.
    [Tags]    j63    logc2    task_org    requires_login
    Open Task Organization Page
    Verify Task Organization Board Or Empty Operation State
