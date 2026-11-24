*** Settings ***
Documentation     Admin, System Tools, Bulk Imports, Feedback, Data Feeds, Sessions, Time in GLADM,
...               Practice Units, Test a Guide & Site Announcements Test Suite
...               (Journeys J12, J13, J17, J22, J23, J25, J27, J58, J59, J60, and J65).
Resource          ../resources/common.resource
Resource          ../resources/pages/login_page.resource
Resource          ../resources/pages/navigation_page.resource
Resource          ../resources/pages/admin_testing_page.resource
Suite Setup       Open Authenticated Admin Session
Suite Teardown    Close Test Browser

*** Keywords ***
Open Authenticated Admin Session
    [Documentation]    Opens the browser, logs in once, and dismisses post-login popups.
    Open Test Browser
    Sign In To GLADM With Env Credentials
    Dismiss Post Login Popups If Present

*** Test Cases ***
J12-01 And J25-01 Verify Unit Settings Unit Users And Account Management Pages
    [Documentation]    Switches to Unit supervisor (S-4) to verify Unit settings (/protected/records/unit/settings)
    ...                and Unit users (/protected/records/unit/users), and checks Admin Users, Role requests,
    ...                Account requests, and Forgot password pages (J12, J25).
    [Tags]    j12    j25    admin    units    accounts    requires_login
    Start Test As Position    Unit supervisor (S-4)
    Open Unit Settings Page
    Open Unit Users Page
    Stop Test As Position
    Open Admin Or System Page And Verify Access Or Refusal    ${ADMIN_USERS_URL}               Users
    Open Admin Or System Page And Verify Access Or Refusal    ${ADMIN_ROLE_REQUESTS_URL}       Role requests
    Open Admin Or System Page And Verify Access Or Refusal    ${ADMIN_ACCOUNT_REQUESTS_URL}    Account requests
    Open Admin Or System Page And Verify Access Or Refusal    ${ADMIN_FORGOT_PASSWORD_URL}     Forgot password

J13-01 Verify System Health Tools Settings Data Browser And Exercises Pages
    [Documentation]    Navigates to System health, System tools, System settings, Test data, Data browser,
    ...                Retired records, and Exercises pages and verifies either System Support access or
    ...                the expected role refusal view (J13).
    [Tags]    j13    admin    system_tools    exercises    requires_login
    Open Admin Or System Page And Verify Access Or Refusal    ${SYSTEM_HEALTH_URL}       System health
    Open Admin Or System Page And Verify Access Or Refusal    ${SYSTEM_TOOLS_URL}        System tools
    Open Admin Or System Page And Verify Access Or Refusal    ${SYSTEM_SETTINGS_URL}     System settings
    Open Admin Or System Page And Verify Access Or Refusal    ${TEST_DATA_URL}           Test data
    Open Admin Or System Page And Verify Access Or Refusal    ${DATA_BROWSER_URL}        Data browser
    Open Admin Or System Page And Verify Access Or Refusal    ${RETIRED_RECORDS_URL}     Retired records
    Open Admin Or System Page And Verify Access Or Refusal    ${EXERCISES_URL}           Exercises

J17-01 And J27-01 Verify Bulk Imports My Feedback And Data Feeds Pages
    [Documentation]    Verifies the spreadsheet Import page (/protected/records/import?kind=personnel),
    ...                My feedback (/protected/feedback/mine), and Data feeds (/protected/admin/feeds) (J17, J27).
    [Tags]    j17    j27    imports    feedback    data_feeds    requires_login
    Start Test As Position    Unit supervisor (S-4)
    Open Records Import Page
    Stop Test As Position
    Open My Feedback Page
    Open Admin Or System Page And Verify Access Or Refusal    ${DATA_FEEDS_URL}    Data feeds

J22-01 And J23-01 Verify Active Sessions And Time In GLADM Pages
    [Documentation]    Verifies Active sessions (/protected/admin/sessions) and Time in GLADM
    ...                (/protected/admin/time-in-gladm) (J22, J23).
    [Tags]    j22    j23    sessions    time_in_gladm    requires_login
    Open Admin Or System Page And Verify Access Or Refusal    ${ACTIVE_SESSIONS_URL}    Active sessions
    Open Admin Or System Page And Verify Access Or Refusal    ${TIME_IN_GLADM_URL}      Time in GLADM

J58-01 And J59-01 And J60-01 Verify Test As Position Practice Units And My Testing Pages
    [Documentation]    Verifies Test as a position switching (J58), Practice units & Test sessions (J59),
    ...                and My testing & Test lead dashboard (J60).
    [Tags]    j58    j59    j60    testing    practice_units    requires_login
    Start Test As Position    Dispatcher
    Stop Test As Position
    Open My Testing Page
    Open Admin Or System Page And Verify Access Or Refusal    ${PRACTICE_UNITS_URL}    Practice units
    Open Admin Or System Page And Verify Access Or Refusal    ${TEST_SESSIONS_URL}     Test sessions

J65-01 Verify System Notices And Site Announcements Page Loads
    [Documentation]    Navigates to System notices (/protected/notifications/system) and verifies the
    ...                notices and site announcements page loads (J65).
    [Tags]    j65    site_announcements    notifications    requires_login
    Open System Notices Page
