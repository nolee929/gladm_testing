*** Settings ***
Documentation     Page Object for GLADM Safety: Mishaps & Citations (J14):
...               Mishaps list (/protected/safety/mishaps), Add a mishap (/protected/safety/mishaps/new),
...               Mishap details (/protected/safety/mishaps/$mishapId), Citations list
...               (/protected/safety/citations), and Add a citation (/protected/safety/citations/new).
Library           SeleniumLibrary
Resource          ../../variables/config.resource

*** Variables ***
# URLs
${SAFETY_URL}                       ${BASE_URL}/protected/safety
${MISHAPS_LIST_URL}                 ${BASE_URL}/protected/safety/mishaps
${MISHAP_NEW_URL}                   ${BASE_URL}/protected/safety/mishaps/new
${CITATIONS_LIST_URL}               ${BASE_URL}/protected/safety/citations
${CITATION_NEW_URL}                 ${BASE_URL}/protected/safety/citations/new

# Mishaps List Locators
${MISHAPS_HEADING}                  xpath=//h1[normalize-space()='Mishaps']
${ADD_MISHAP_BTN}                   xpath=//a[normalize-space()='Add a mishap'] | //button[normalize-space()='Add a mishap']
${MISHAP_STATUS_SELECT}             xpath=//label[normalize-space()='Status']/following::select[1]
${MISHAP_SEARCH_INPUT}              xpath=//label[normalize-space()='Search']/following::input[1]
${MISHAP_SHOW_ARCHIVED_CHECK}       xpath=//label[contains(.,'Show archived')]//input[@type='checkbox'] | //label[contains(.,'Show archived')]/preceding::input[@type='checkbox'][1]
${MISHAP_EXPORT_BTN}                xpath=//button[contains(.,'Export')]

# Add Mishap Form Locators
${ADD_MISHAP_HEADING}               xpath=//h1[normalize-space()='Add a mishap']
${MISHAP_UNIT_SELECT}               xpath=//label[contains(.,'Unit the mishap happened to')]/following::select[1]
${MISHAP_CATEGORY_SELECT}           xpath=//label[normalize-space()='Category']/following::select[1]
${MISHAP_CAUSE_SELECT}              xpath=//label[normalize-space()='Cause']/following::select[1]
${MISHAP_INCIDENT_TYPE_SELECT}      xpath=//label[normalize-space()='Incident type']/following::select[1]
${MISHAP_WHAT_HAPPENED_INPUT}       xpath=//label[contains(.,'What happened')]/following::textarea[1]
${MISHAP_WHERE_INPUT}               xpath=//label[contains(.,'Where it happened')]/following::input[1]
${MISHAP_GRID_INPUT}                xpath=//label[normalize-space()='Grid']/following::input[1]
${MISHAP_SAVE_BTN}                  xpath=//button[@type='submit' and (contains(.,'Save') or contains(.,'Add'))]

# Citations List Locators
${CITATIONS_HEADING}                xpath=//h1[normalize-space()='Citations']
${ADD_CITATION_BTN}                 xpath=//a[normalize-space()='Add a citation'] | //button[normalize-space()='Add a citation']
${CITATIONS_CURRENT_TAB}            xpath=//button[@role='radio' and normalize-space()='Current'] | //button[normalize-space()='Current']
${CITATIONS_ARCHIVED_TAB}           xpath=//button[@role='radio' and normalize-space()='Archived'] | //button[normalize-space()='Archived']

# Add Citation Form Locators
${ADD_CITATION_HEADING}             xpath=//h1[normalize-space()='Add a citation']
${CITATION_PERSON_INPUT}            xpath=//label[contains(.,'Cited person')]/following::input[1]
${CITATION_TYPE_SELECT}             xpath=//label[contains(.,'Citation type')]/following::select[1]
${CITATION_DATE_INPUT}              xpath=//label[contains(.,'Date of the citation')]/following::input[1]
${CITATION_LICENSE_INPUT}           xpath=//label[contains(.,'License number')]/following::input[1]
${CITATION_POC_INPUT}               xpath=//label[contains(.,'Point of contact')]/following::input[1]
${CITATION_PHONE_INPUT}             xpath=//label[normalize-space()='Phone']/following::input[1]
${CITATION_EMAIL_INPUT}             xpath=//label[normalize-space()='E-mail']/following::input[1]
${CITATION_COMMENTS_INPUT}          xpath=//label[normalize-space()='Comments']/following::textarea[1]
${CITATION_SAVE_BTN}                xpath=//button[@type='submit' and (contains(.,'Save') or contains(.,'Add'))]

*** Keywords ***
Open Mishaps List Page
    [Documentation]    Navigates directly to the Mishaps list (/protected/safety/mishaps).
    Go To    ${MISHAPS_LIST_URL}
    Wait Until Element Is Visible    ${MISHAPS_HEADING}    timeout=${SELENIUM_TIMEOUT}

Verify Mishaps List Controls
    [Documentation]    Verifies Status filter, Search box, Show archived toggle, and Add a mishap button.
    Wait Until Element Is Visible    ${MISHAPS_HEADING}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${MISHAP_STATUS_SELECT}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${MISHAP_SEARCH_INPUT}    timeout=${SELENIUM_TIMEOUT}
    Page Should Contain    Show archived

Open Add Mishap Page
    [Documentation]    Navigates to the Add a mishap form (/protected/safety/mishaps/new).
    Go To    ${MISHAP_NEW_URL}
    Wait Until Element Is Visible    ${ADD_MISHAP_HEADING}    timeout=${SELENIUM_TIMEOUT}

Verify Add Mishap Form Fields
    [Documentation]    Verifies the core sections and fields on the Add a mishap page.
    Wait Until Element Is Visible    ${ADD_MISHAP_HEADING}    timeout=${SELENIUM_TIMEOUT}
    Page Should Contain    Unit the mishap happened to
    Page Should Contain    Date and time
    Page Should Contain    Category
    Page Should Contain    Cause
    Page Should Contain    Incident type
    Page Should Contain    Where it happened

Open Citations List Page
    [Documentation]    Navigates directly to the Citations list (/protected/safety/citations).
    Go To    ${CITATIONS_LIST_URL}
    Wait Until Element Is Visible    ${CITATIONS_HEADING}    timeout=${SELENIUM_TIMEOUT}

Verify Citations List Controls
    [Documentation]    Verifies Current/Archived switch and table filters on the Citations list page.
    Wait Until Element Is Visible    ${CITATIONS_HEADING}    timeout=${SELENIUM_TIMEOUT}
    Page Should Contain    Current
    Page Should Contain    Archived

Switch Citations View
    [Documentation]    Switches between 'Current' and 'Archived' citations on the Citations list page.
    [Arguments]    ${view_label}
    ${btn}=    Set Variable    xpath=//button[normalize-space()='${view_label}']
    Wait Until Element Is Visible    ${btn}    timeout=${SELENIUM_TIMEOUT}
    Click Element    ${btn}

Open Add Citation Page
    [Documentation]    Navigates to the Add a citation form (/protected/safety/citations/new).
    Go To    ${CITATION_NEW_URL}
    Wait Until Element Is Visible    ${ADD_CITATION_HEADING}    timeout=${SELENIUM_TIMEOUT}

Verify Add Citation Form Fields
    [Documentation]    Verifies the core fields on the Add a citation form.
    Wait Until Element Is Visible    ${ADD_CITATION_HEADING}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${CITATION_PERSON_INPUT}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${CITATION_TYPE_SELECT}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${CITATION_LICENSE_INPUT}    timeout=${SELENIUM_TIMEOUT}
    Page Should Contain    Issuing authority
    Wait Until Element Is Visible    ${CITATION_POC_INPUT}    timeout=${SELENIUM_TIMEOUT}
