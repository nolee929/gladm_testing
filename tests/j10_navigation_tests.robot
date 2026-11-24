*** Settings ***
Documentation     J10: GLADM Navigation, Today Brief, Menu Rail, and Search Tests.
...               Requires an authenticated session.
Resource          ../resources/common.resource
Resource          ../resources/pages/login_page.resource
Resource          ../resources/pages/navigation_page.resource

Suite Setup       Open Authenticated Test Session
Suite Teardown    Close Test Browser

*** Keywords ***
Open Authenticated Test Session
    [Documentation]    Starts the browser, logs in once, and dismisses initial popups.
    Open Test Browser
    Sign In To GLADM With Env Credentials
    Dismiss Post Login Popups If Present

*** Test Cases ***
Step 1: Land On Today And Verify Shell Layout
    [Documentation]    J10 Step 1 (R163, R164): Verify user lands on Today with left rail, top bar, and bottom bar.
    [Tags]    J10    R163    R164    navigation    requires_login
    Wait Until Element Is Visible    ${LEFT_RAIL}
    Wait Until Page Contains Element    xpath://*[@data-slot="bottom-bar"]
    Page Should Contain              Today

Step 4 To 5: Sidebar Toggle And Group Expansion
    [Documentation]    J10 Steps 4-5 (R163, R167): Verify expanding rail groups and opening the persistent sidebar.
    [Tags]    J10    R163    R167    navigation    requires_login
    Wait Until Element Is Visible    ${SIDEBAR_BUTTON}
    Click Element                    ${SIDEBAR_BUTTON}
    Wait Until Element Is Visible    xpath://*[@data-slot="sidebar"]
    # Toggle sidebar back closed
    Click Element                    ${SIDEBAR_BUTTON}
    Wait Until Element Is Not Visible    xpath://*[@data-slot="sidebar"]

Step 11: Open Notices Bell
    [Documentation]    J10 Step 11 (R449, R393): Verify clicking the notifications bell opens the notifications panel.
    [Tags]    J10    R449    R393    navigation    requires_login
    Open Notifications Bell
    Page Should Contain              System notices

Step 27: Open Display Settings From Account Menu
    [Documentation]    J10 Step 27: Verify opening Display settings from the account menu opens the side drawer.
    [Tags]    J10    navigation    settings    requires_login
    Open Display Settings
    Page Should Contain              Grid format
    # Close quick settings drawer
    Click Element                    xpath://*[@data-slot="quick-settings"]//button[contains(@aria-label, 'Close') or contains(., 'Close')]

Step 58: Test As Position Switching
    [Documentation]    J58 Steps 1-5: Verify tester can initiate 'Test as...' and observe the persistent testing banner.
    [Tags]    J58    navigation    roles    requires_login
    Start Test As Position           Dispatcher
    Page Should Contain              Testing as Dispatcher
    Stop Test As Position
    Page Should Not Contain          Testing as Dispatcher
