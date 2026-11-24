*** Settings ***
Documentation     Page Object for GLADM Admin, System Tools, Bulk Imports, Feedback, Data Feeds,
...               Sessions, Time in GLADM, Practice Units, Test a Guide, and Site Announcements
...               (Journeys J12, J13, J17, J22, J23, J25, J27, J59, J60, J65).
Library           SeleniumLibrary
Resource          ../../variables/config.resource

*** Variables ***
# Admin & Unit Management URLs (J12, J25)
${ADMIN_HOME_URL}                   ${BASE_URL}/protected/admin
${ADMIN_USERS_URL}                  ${BASE_URL}/protected/admin/users
${ADMIN_ROLE_REQUESTS_URL}          ${BASE_URL}/protected/admin/access-requests
${ADMIN_ACCOUNT_REQUESTS_URL}       ${BASE_URL}/protected/admin/account-requests
${ADMIN_FORGOT_PASSWORD_URL}        ${BASE_URL}/protected/admin/password-resets
${ADMIN_UNITS_URL}                  ${BASE_URL}/protected/admin/units
${UNIT_SETTINGS_URL}                ${BASE_URL}/protected/records/unit/settings
${UNIT_USERS_URL}                   ${BASE_URL}/protected/records/unit/users

# System Tools, Health, Settings, Test Data, Data Browser & Exercises URLs (J13)
${SYSTEM_HEALTH_URL}                ${BASE_URL}/protected/admin/system/health
${SYSTEM_TOOLS_URL}                 ${BASE_URL}/protected/admin/system/systemTools
${SYSTEM_INSTANCES_URL}             ${BASE_URL}/protected/admin/system/systemInstances
${SYSTEM_SETTINGS_URL}              ${BASE_URL}/protected/admin/system/settings
${TEST_DATA_URL}                    ${BASE_URL}/protected/admin/system/testData
${DATA_BROWSER_URL}                 ${BASE_URL}/protected/admin/data-browser
${RETIRED_RECORDS_URL}              ${BASE_URL}/protected/admin/retired-records
${EXERCISES_URL}                    ${BASE_URL}/protected/admin/exercises

# Bulk Imports, Feedback & Data Feeds URLs (J17, J27)
${RECORDS_IMPORT_URL}               ${BASE_URL}/protected/records/import?kind=personnel
${MY_FEEDBACK_URL}                  ${BASE_URL}/protected/feedback/mine
${ADMIN_FEEDBACK_URL}               ${BASE_URL}/protected/admin/feedback
${DATA_FEEDS_URL}                   ${BASE_URL}/protected/admin/feeds

# Active Sessions & Time in GLADM URLs (J22, J23)
${ACTIVE_SESSIONS_URL}              ${BASE_URL}/protected/admin/sessions
${TIME_IN_GLADM_URL}                ${BASE_URL}/protected/admin/time-in-gladm

# Practice Units, Test Sessions, My Testing & Site Announcements URLs (J59, J60, J65)
${PRACTICE_UNITS_URL}               ${BASE_URL}/protected/admin/testing/practice-units
${TEST_SESSIONS_URL}                ${BASE_URL}/protected/admin/testing/sessions
${MY_TESTING_URL}                   ${BASE_URL}/protected/testing
${TESTING_LEAD_URL}                 ${BASE_URL}/protected/testing/lead
${SYSTEM_NOTICES_URL}               ${BASE_URL}/protected/notifications/system

# Common Locators
${UNIT_SETTINGS_HEADING}            xpath=//h1[normalize-space()='Unit settings']
${UNIT_USERS_HEADING}               xpath=//h1[normalize-space()='Unit users']
${MY_FEEDBACK_HEADING}              xpath=//h1[normalize-space()='My feedback']
${IMPORT_DROP_ZONE}                 css=[data-testid='import-drop']
${SYSTEM_NOTICES_HEADING}           xpath=//h1[contains(.,'System notices') or contains(.,'Site announcements')]
${MY_TESTING_HEADING}               xpath=//h1[contains(.,'Testing') or contains(.,'My testing')]

*** Keywords ***
Open Unit Settings Page
    [Documentation]    Navigates to Unit settings (/protected/records/unit/settings).
    Go To    ${UNIT_SETTINGS_URL}
    Wait Until Element Is Visible    ${UNIT_SETTINGS_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open Unit Users Page
    [Documentation]    Navigates to Unit users (/protected/records/unit/users).
    Go To    ${UNIT_USERS_URL}
    Wait Until Element Is Visible    ${UNIT_USERS_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open Records Import Page
    [Documentation]    Navigates to the spreadsheet Import page (/protected/records/import?kind=personnel).
    Go To    ${RECORDS_IMPORT_URL}
    Wait Until Element Is Visible    xpath=//h1[contains(.,'Import')]    timeout=${SELENIUM_TIMEOUT}

Open My Feedback Page
    [Documentation]    Navigates to My feedback (/protected/feedback/mine).
    Go To    ${MY_FEEDBACK_URL}
    Wait Until Element Is Visible    ${MY_FEEDBACK_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open System Notices Page
    [Documentation]    Navigates to System notices & Site announcements (/protected/notifications/system).
    Go To    ${SYSTEM_NOTICES_URL}
    Wait Until Element Is Visible    ${SYSTEM_NOTICES_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open My Testing Page
    [Documentation]    Navigates to Help > Testing (/protected/testing).
    Go To    ${MY_TESTING_URL}
    Wait Until Element Is Visible    xpath=//h1    timeout=${SELENIUM_TIMEOUT}

Open Admin Or System Page And Verify Access Or Refusal
    [Documentation]    Navigates to an Admin/System Support page and verifies that either the page heading
    ...                loads (for System Support) or the expected access refusal / Request access view renders.
    [Arguments]    ${url}    ${expected_heading}
    Go To    ${url}
    Wait Until Element Is Visible    xpath=//h1[contains(.,'${expected_heading}') or contains(.,'not available') or contains(.,'Access')] | //button[contains(.,'Request access')]    timeout=${SELENIUM_TIMEOUT}
