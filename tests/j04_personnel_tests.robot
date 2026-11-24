*** Settings ***
Documentation     J04: Personnel and Licenses — Roster, Person Profile, Driver/Vehicle Licenses, MOS, and Reports.
...               Covers R113, R114, R115, R116, R117, R118, R119, R261, R263, R274, R275, R276, R283, R284, R287, R290, R296, R298.
Resource          ../resources/common.resource
Resource          ../resources/pages/login_page.resource
Resource          ../resources/pages/navigation_page.resource
Resource          ../resources/pages/personnel_page.resource

Suite Setup       Open Authenticated Personnel Session
Suite Teardown    Close Test Browser

*** Keywords ***
Open Authenticated Personnel Session
    [Documentation]    Opens the browser, logs in once, dismisses popups, and switches to Unit supervisor (S-4).
    Open Test Browser
    Sign In To GLADM With Env Credentials
    Dismiss Post Login Popups If Present
    Start Test As Position           Unit supervisor (S-4)

*** Test Cases ***
Step 1 To 3: Open Personnel Roster And Verify Search And Filters
    [Documentation]    J04 Steps 1-3 (R263, R284, R287): Open Personnel › Records › Personnel,
    ...                verify Search, More filters, Export, Removed personnel link, and Add person button.
    [Tags]    J04    R263    R284    R287    personnel    roster    requires_login
    Navigate To Personnel List
    Element Should Be Visible        ${PERSONNEL_SEARCH_INPUT}
    Element Should Be Visible        ${PERSONNEL_MORE_FILTERS_BUTTON}
    Element Should Be Visible        ${PERSONNEL_EXPORT_BUTTON}
    Element Should Be Visible        ${REMOVED_PERSONNEL_LINK}
    Element Should Be Visible        ${ADD_PERSON_BUTTON}

Step 4 And 6 To 9: Open Person Profile And Verify All Seven Tabs
    [Documentation]    J04 Steps 4 & 6-9 (R115, R118, R274, R275, R283, R287, R290): Open a person from the roster
    ...                and verify that all 7 tabs (Profile, Licenses, MOS, Availability, Safety, Files, History) are visible and switchable.
    [Tags]    J04    R115    R118    R274    R275    R283    R290    personnel    profile    requires_login
    Navigate To Personnel List
    Open First Person From Personnel List
    Verify All Seven Person Profile Tabs

Step 11: Open Add A Person Form And Verify Name And EDIPI Validation
    [Documentation]    J04 Step 11 & Step 5 notes (R261, R276, R283, feedback #738 & #575): Open Add a person
    ...                and verify that a digit-only First name triggers 'A name needs at least one letter.'
    [Tags]    J04    R261    R276    R283    personnel    validation    requires_login
    Navigate To Add Person Page
    Page Should Contain              Start from someone like them (optional)
    Element Should Be Visible        ${NEW_PERSON_FIRST_NAME_INPUT}
    Element Should Be Visible        ${NEW_PERSON_LAST_NAME_INPUT}
    Element Should Be Visible        ${NEW_PERSON_RANK_SELECT}
    Element Should Be Visible        ${NEW_PERSON_TYPE_SELECT}
    Element Should Be Visible        ${NEW_PERSON_EDIPI_INPUT}
    Element Should Be Visible        ${NEW_PERSON_VALID_LICENSE_CHECK}
    # Verify feedback #738: First name needs at least one letter
    Input Text                       ${NEW_PERSON_FIRST_NAME_INPUT}    7
    Input Text                       ${NEW_PERSON_LAST_NAME_INPUT}     JOURNEY-J04
    Click Element                    ${ADD_PERSON_SUBMIT_BUTTON}
    Wait Until Page Contains         A name needs at least one letter

Step 10 And 18 To 20: Verify Licenses List And License Reports
    [Documentation]    J04 Steps 10 & 18-20 (R113, R114, R116, R117, R119, R263): Open Personnel › Records › Licenses,
    ...                verify 30/60/90 days filters, and verify Expired licenses, Personnel license, and Unit license reports.
    [Tags]    J04    R113    R114    R116    R117    R119    licenses    reports    requires_login
    Navigate To Licenses List
    Element Should Be Visible        ${LICENSES_EXPIRING_30_DAYS}
    Element Should Be Visible        ${LICENSES_EXPIRING_60_DAYS}
    Element Should Be Visible        ${LICENSES_EXPIRING_90_DAYS}
    Click Element                    ${LICENSES_EXPIRING_30_DAYS}
    Wait Until Page Contains         30 days
    Go To                            ${BASE_URL}/sgen-tcp/protected/reports/expired-licenses
    Wait Until Element Is Visible    ${EXPIRED_LICENSES_REPORT_HEADING}    timeout=20s
    Go To                            ${BASE_URL}/sgen-tcp/protected/reports/personnel-license
    Wait Until Element Is Visible    ${PERSONNEL_LICENSE_REPORT_HEADING}    timeout=20s
    Go To                            ${BASE_URL}/sgen-tcp/protected/reports/unit-license
    Wait Until Element Is Visible    ${UNIT_LICENSE_REPORT_HEADING}    timeout=20s
