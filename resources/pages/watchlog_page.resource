*** Settings ***
Documentation     Page Object for GLADM Watch Log, Activity Log, Help & Form Library (J15 / J24):
...               24-hour Watch Log (/protected/watchlog/view), Add Watch Log / MEDEVAC 9-line
...               (/protected/watchlog/create), Search Watch Log (/protected/watchlog/search),
...               Watch Log Summary (/protected/watchlog/summary), Activity Log (/protected/activityLog),
...               Help pages (What GLADM does /protected/help/capabilities, Glossary /protected/help/glossary),
...               and Form Library (/protected/files).
Library           SeleniumLibrary
Resource          ../../variables/config.resource

*** Variables ***
# URLs
${WATCHLOG_VIEW_URL}                ${BASE_URL}/protected/watchlog/view
${WATCHLOG_CREATE_URL}              ${BASE_URL}/protected/watchlog/create
${WATCHLOG_MEDEVAC_URL}             ${BASE_URL}/protected/watchlog/create/medevac
${WATCHLOG_SEARCH_URL}              ${BASE_URL}/protected/watchlog/search
${WATCHLOG_SUMMARY_URL}             ${BASE_URL}/protected/watchlog/summary
${ACTIVITY_LOG_URL}                 ${BASE_URL}/protected/activityLog
${AUDIT_LOG_URL}                    ${BASE_URL}/protected/admin/user/auditLog
${HELP_CAPABILITIES_URL}            ${BASE_URL}/protected/help/capabilities
${HELP_GLOSSARY_URL}                ${BASE_URL}/protected/help/glossary
${HELP_POLICIES_URL}                ${BASE_URL}/protected/help/policies
${HELP_CONTACT_URL}                 ${BASE_URL}/protected/help/contact
${FORM_LIBRARY_URL}                 ${BASE_URL}/protected/files

# Watch Log Locators
${WATCHLOG_HEADING}                 xpath=//h1[normalize-space()='24-hour watch log']
${WATCHLOG_SUMMARY_HEADING}         xpath=//h1[normalize-space()='Watch log summary']
${WATCHLOG_SEARCH_HEADING}          xpath=//h1[normalize-space()='Search the watch log']
${WATCHLOG_ADD_BTN}                 xpath=//a[contains(.,'Add to the log')]
${WATCHLOG_MEDEVAC_BTN}             xpath=//a[contains(.,'Log a MEDEVAC')]
${WATCHLOG_SEARCH_OLDER_BTN}        xpath=//a[contains(.,'Search older entries')]
${WATCHLOG_SHOW_MINE_BTN}           xpath=//button[normalize-space()='Entries you logged']
${WATCHLOG_SHOW_ALL_BTN}            xpath=//button[contains(.,"Everyone's entries")]

# Watch Log Create / MEDEVAC Locators
${WATCHLOG_PRIORITY_SELECT}         xpath=//label[normalize-space()='Priority']/following::select[1]
${WATCHLOG_SUBJECT_INPUT}           xpath=//label[normalize-space()='Subject']/following::input[1]
${WATCHLOG_WHAT_HAPPENED_INPUT}     xpath=//label[normalize-space()='What happened']/following::textarea[1]
${WATCHLOG_SUBMIT_BTN}              xpath=//button[@type='submit' and contains(.,'Add to the log')]
${MEDEVAC_LINE1_GRID_INPUT}         xpath=//label[contains(.,'Line 1. Pick-up site (grid)')]/following::input[1]
${MEDEVAC_LINE2_FREQ_INPUT}         xpath=//label[contains(.,'Line 2. Radio frequency')]/following::input[1]
${MEDEVAC_LINE4_EQUIP_SELECT}       xpath=//label[contains(.,'Line 4. Special equipment')]/following::select[1]
${MEDEVAC_LINE6_SECURITY_SELECT}    xpath=//label[contains(.,'Line 6. Security of the pick-up site')]/following::select[1]
${MEDEVAC_LINE7_MARKING_SELECT}     xpath=//label[contains(.,'Line 7. How the pick-up site is marked')]/following::select[1]

# Watch Log Search Locators
${WATCHLOG_KEYWORD_INPUT}           xpath=//label[normalize-space()='Keyword']/following::input[1]
${WATCHLOG_SEARCH_SUBMIT_BTN}       xpath=//form[@aria-label='Search the watch log']//button[@type='submit']

# Activity Log Locators
${ACTIVITY_LOG_HEADING}             xpath=//h1[normalize-space()='Activity Log']
${ACTIVITY_LOG_TOOLBAR}             css=[data-slot='logs-toolbar']
${ACTIVITY_LOG_SUMMARY}             css=[data-slot='logs-summary']
${ACTIVITY_LOG_CATEGORY_CHIPS}      css=[data-slot='category-chips']
${ACTIVITY_LOG_SEARCH_INPUT}        xpath=//input[@placeholder='Who, what or whom']
${ACTIVITY_LOG_PERSON_INPUT}        xpath=//input[@placeholder='Name or user name']

# Help & Form Library Locators
${CAPABILITIES_HEADING}             xpath=//h1[normalize-space()='What GLADM does']
${CAPABILITIES_TOTALS}              css=[data-slot='capability-totals']
${GLOSSARY_HEADING}                 xpath=//h1[normalize-space()='Glossary']
${GLOSSARY_SEARCH_INPUT}            xpath=//input[@placeholder='For example: TMR, convoy, 7-ton']
${GLOSSARY_AZ_BAR}                  css=[data-slot='glossary-az']
${GLOSSARY_COUNT}                   css=[data-slot='glossary-count']
${FORM_LIBRARY_HEADING}             xpath=//h1[normalize-space()='Form Library']
${FORM_LIBRARY_SEARCH_INPUT}        xpath=//input[@placeholder='Form name or number']

*** Keywords ***
Open 24 Hour Watch Log Page
    [Documentation]    Navigates directly to the 24-hour Watch Log (/protected/watchlog/view).
    Go To    ${WATCHLOG_VIEW_URL}
    Wait Until Element Is Visible    ${WATCHLOG_HEADING}    timeout=${SELENIUM_TIMEOUT}

Verify Watch Log Page Controls
    [Documentation]    Verifies the 24-hour watch log heading and action buttons (Add to the log, Log a MEDEVAC, Search older entries).
    Wait Until Element Is Visible    ${WATCHLOG_HEADING}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${WATCHLOG_ADD_BTN}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${WATCHLOG_MEDEVAC_BTN}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${WATCHLOG_SEARCH_OLDER_BTN}    timeout=${SELENIUM_TIMEOUT}

Open Add Watch Log Entry Page
    [Documentation]    Navigates to the Add watch log entry form (/protected/watchlog/create).
    Go To    ${WATCHLOG_CREATE_URL}
    Wait Until Element Is Visible    ${WATCHLOG_SUBJECT_INPUT}    timeout=${SELENIUM_TIMEOUT}

Verify Add Watch Log Entry Fields
    [Documentation]    Verifies When it happened, Priority, Subject, What happened, and Add to the log button.
    Page Should Contain    When it happened
    Wait Until Element Is Visible    ${WATCHLOG_PRIORITY_SELECT}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${WATCHLOG_SUBJECT_INPUT}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${WATCHLOG_WHAT_HAPPENED_INPUT}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${WATCHLOG_SUBMIT_BTN}    timeout=${SELENIUM_TIMEOUT}

Open MEDEVAC 9 Line Page
    [Documentation]    Navigates to the MEDEVAC 9-line form (/protected/watchlog/create/medevac).
    Go To    ${WATCHLOG_MEDEVAC_URL}
    Wait Until Element Is Visible    ${MEDEVAC_LINE1_GRID_INPUT}    timeout=${SELENIUM_TIMEOUT}

Verify MEDEVAC 9 Line Fields
    [Documentation]    Verifies all 9 lines of the MEDEVAC watch log form.
    Wait Until Element Is Visible    ${MEDEVAC_LINE1_GRID_INPUT}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${MEDEVAC_LINE2_FREQ_INPUT}    timeout=${SELENIUM_TIMEOUT}
    Page Should Contain    Urgent (life or limb within 2 hours)
    Wait Until Element Is Visible    ${MEDEVAC_LINE4_EQUIP_SELECT}    timeout=${SELENIUM_TIMEOUT}
    Page Should Contain    Litter
    Page Should Contain    Ambulatory
    Wait Until Element Is Visible    ${MEDEVAC_LINE6_SECURITY_SELECT}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${MEDEVAC_LINE7_MARKING_SELECT}    timeout=${SELENIUM_TIMEOUT}
    Page Should Contain    US military

Open Search Watch Log Page
    [Documentation]    Navigates to Search the watch log (/protected/watchlog/search).
    Go To    ${WATCHLOG_SEARCH_URL}
    Wait Until Element Is Visible    ${WATCHLOG_SEARCH_HEADING}    timeout=${SELENIUM_TIMEOUT}

Search Watch Log By Keyword
    [Documentation]    Searches older watch log entries by keyword.
    [Arguments]    ${keyword}
    Wait Until Element Is Visible    ${WATCHLOG_KEYWORD_INPUT}    timeout=${SELENIUM_TIMEOUT}
    Clear Element Text    ${WATCHLOG_KEYWORD_INPUT}
    Input Text    ${WATCHLOG_KEYWORD_INPUT}    ${keyword}
    Click Element    ${WATCHLOG_SEARCH_SUBMIT_BTN}

Open Watch Log Summary Page
    [Documentation]    Navigates to Watch log summary (/protected/watchlog/summary).
    Go To    ${WATCHLOG_SUMMARY_URL}
    Wait Until Element Is Visible    ${WATCHLOG_SUMMARY_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open Activity Log Page
    [Documentation]    Navigates to the unit Activity Log (/protected/activityLog).
    Go To    ${ACTIVITY_LOG_URL}
    Wait Until Element Is Visible    ${ACTIVITY_LOG_HEADING}    timeout=${SELENIUM_TIMEOUT}

Verify Activity Log Controls
    [Documentation]    Verifies the Activity Log toolbar, category chips, search input, and summary cards.
    Wait Until Element Is Visible    ${ACTIVITY_LOG_HEADING}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${ACTIVITY_LOG_TOOLBAR}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${ACTIVITY_LOG_CATEGORY_CHIPS}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${ACTIVITY_LOG_SEARCH_INPUT}    timeout=${SELENIUM_TIMEOUT}

Open What GLADM Does Page
    [Documentation]    Navigates to What GLADM does (/protected/help/capabilities).
    Go To    ${HELP_CAPABILITIES_URL}
    Wait Until Element Is Visible    ${CAPABILITIES_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open Glossary Page
    [Documentation]    Navigates to the GLADM Glossary (/protected/help/glossary).
    Go To    ${HELP_GLOSSARY_URL}
    Wait Until Element Is Visible    ${GLOSSARY_HEADING}    timeout=${SELENIUM_TIMEOUT}

Search Glossary Term
    [Documentation]    Searches the Glossary for a term and verifies matching entries appear.
    [Arguments]    ${term}
    Wait Until Element Is Visible    ${GLOSSARY_SEARCH_INPUT}    timeout=${SELENIUM_TIMEOUT}
    Clear Element Text    ${GLOSSARY_SEARCH_INPUT}
    Input Text    ${GLOSSARY_SEARCH_INPUT}    ${term}
    Wait Until Element Is Visible    css=[data-slot='glossary-entry']    timeout=${SELENIUM_TIMEOUT}

Open Form Library Page
    [Documentation]    Navigates to the Form Library (/protected/files).
    Go To    ${FORM_LIBRARY_URL}
    Wait Until Element Is Visible    ${FORM_LIBRARY_HEADING}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${FORM_LIBRARY_SEARCH_INPUT}    timeout=${SELENIUM_TIMEOUT}
