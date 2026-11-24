*** Settings ***
Documentation     J15 & J24: Watch Log, Activity Log, Help & Form Library — 24-hour Watch Log, MEDEVAC 9-line, Activity Log, Glossary, and Forms.
...               Covers R145, R148, R149, R168, R169, R170, R171, R172, R173, R177, R346, R347, R348.
Resource          ../resources/common.resource
Resource          ../resources/pages/login_page.resource
Resource          ../resources/pages/navigation_page.resource
Resource          ../resources/pages/watchlog_page.resource

Suite Setup       Open Authenticated Watchlog Session
Suite Teardown    Close Test Browser

*** Keywords ***
Open Authenticated Watchlog Session
    [Documentation]    Opens the browser, logs in once, dismisses popups, and switches to Unit supervisor (S-4).
    Open Test Browser
    Sign In To GLADM With Env Credentials
    Dismiss Post Login Popups If Present
    Start Test As Position           Unit supervisor (S-4)

*** Test Cases ***
Step 1 To 3: 24 Hour Watch Log And Add Entry Form Render
    [Documentation]    J15 Steps 1-3 (R169, R170, R346): Open 24-hour watch log (/protected/watchlog/view), verify
    ...                action buttons, and open Add watch log entry form (/protected/watchlog/create).
    [Tags]    J15    R169    R170    R346    watchlog    requires_login
    Open 24 Hour Watch Log Page
    Verify Watch Log Page Controls
    Open Add Watch Log Entry Page
    Verify Add Watch Log Entry Fields

Step 4: MEDEVAC 9 Line Watch Log Form Renders
    [Documentation]    J15 Step 4 (R170, R347): Open MEDEVAC 9-line form (/protected/watchlog/create/medevac)
    ...                and verify Lines 1 through 9 render properly.
    [Tags]    J15    R170    R347    watchlog    medevac    requires_login
    Open MEDEVAC 9 Line Page
    Verify MEDEVAC 9 Line Fields

Step 8 To 9 And 21: Watch Log Summary And Search Older Entries Work
    [Documentation]    J15 Steps 8-9 & 21 (R145, R173, R348): Open Watch log summary (/protected/watchlog/summary)
    ...                and Search the watch log (/protected/watchlog/search) and search by keyword.
    [Tags]    J15    R145    R173    R348    watchlog    search    requires_login
    Open Watch Log Summary Page
    Page Should Contain    Watch log summary
    Open Search Watch Log Page
    Search Watch Log By Keyword    Mission

Step 10 To 15: Activity Log Toolbar Category Chips And Search Render
    [Documentation]    J15 Steps 10-15 & J24: Open Activity Log (/protected/activityLog) and verify the toolbar,
    ...                category chips, search input, and summary cards.
    [Tags]    J15    J24    activity_log    requires_login
    Open Activity Log Page
    Verify Activity Log Controls

Step 16 To 18: Help Capabilities Glossary And Form Library Render
    [Documentation]    J15 Steps 16-18 (R148, R149, R177): Open What GLADM does (/protected/help/capabilities),
    ...                Glossary (/protected/help/glossary), and Form Library (/protected/files).
    [Tags]    J15    R148    R149    R177    help    glossary    forms    requires_login
    Open What GLADM Does Page
    Wait Until Element Is Visible    ${CAPABILITIES_TOTALS}    timeout=${SELENIUM_TIMEOUT}
    Open Glossary Page
    Wait Until Element Is Visible    ${GLOSSARY_AZ_BAR}    timeout=${SELENIUM_TIMEOUT}
    Search Glossary Term             TMR
    Open Form Library Page
    Page Should Contain              Transportation
