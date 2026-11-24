*** Settings ***
Documentation     User Settings Test Suite (Journeys J32 and J47):
...               Verifies Display settings (/protected/settings/display) including Grid format,
...               Distances, Speeds, and Second time zone (J32), and Notification settings
...               (/protected/settings/notifications) including Waiting on you switches and Daily e-mail (J47).
Resource          ../resources/common.resource
Resource          ../resources/pages/login_page.resource
Resource          ../resources/pages/navigation_page.resource
Resource          ../resources/pages/settings_page.resource
Suite Setup       Open Authenticated Settings Session
Suite Teardown    Close Test Browser

*** Keywords ***
Open Authenticated Settings Session
    [Documentation]    Opens the browser, logs in once, and dismisses post-login popups.
    Open Test Browser
    Sign In To GLADM With Env Credentials
    Dismiss Post Login Popups If Present

*** Test Cases ***
J32-01 Verify Display Settings Page And Controls Load
    [Documentation]    Navigates to Display settings (/protected/settings/display) and verifies Grid format,
    ...                Distances, Speeds, Second time zone, and Reset to defaults.
    [Tags]    j32    settings    display_settings    requires_login
    Open Display Settings Page
    Verify Display Settings Sections

J47-01 Verify Notification Settings Page And Controls Load
    [Documentation]    Navigates to Notification settings (/protected/settings/notifications) and verifies
    ...                Waiting on you task switches, Daily e-mail summary, and Reset to defaults.
    [Tags]    j47    settings    notification_settings    requires_login
    Open Notification Settings Page
    Verify Notification Settings Sections
