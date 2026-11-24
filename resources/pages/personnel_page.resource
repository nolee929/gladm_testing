*** Settings ***
Documentation     Page Object Model for GLADM Personnel Roster, Person Profiles, Licenses, and MOS (J04).
Library           SeleniumLibrary
Resource          ../../variables/config.resource

*** Variables ***
# Personnel List & Filters (J04 Steps 1-3, 13-14)
${PERSONNEL_HEADING}                xpath://h1[normalize-space()='Personnel' or normalize-space()='All personnel']
${ADD_PERSON_BUTTON}                xpath://a[contains(., 'Add person')] | //button[contains(., 'Add person')]
${REMOVED_PERSONNEL_LINK}           xpath://a[normalize-space()='Removed personnel']
${PERSONNEL_SEARCH_INPUT}           xpath://form[@role='search']//input | //input[@type='search']
${PERSONNEL_MORE_FILTERS_BUTTON}    xpath://button[starts-with(normalize-space(), 'More filters')]
${PERSONNEL_EXPORT_BUTTON}          xpath://button[normalize-space()='Export']

# Add Person Form (J04 Step 11)
${ADD_PERSON_HEADING}               xpath://h1[normalize-space()='Add a person']
${NEW_PERSON_FIRST_NAME_INPUT}      id:new-person-firstName
${NEW_PERSON_MIDDLE_INITIAL_INPUT}  id:new-person-middleInitial
${NEW_PERSON_LAST_NAME_INPUT}       id:new-person-lastName
${NEW_PERSON_RANK_SELECT}           id:new-person-rankId
${NEW_PERSON_TYPE_SELECT}           id:new-person-personnelTypeId
${NEW_PERSON_BILLET_SELECT}         id:new-person-billetId
${NEW_PERSON_GENDER_SELECT}         id:new-person-gender
${NEW_PERSON_EDIPI_INPUT}           id:new-person-edipi
${NEW_PERSON_EMAIL_INPUT}           id:new-person-email
${NEW_PERSON_DOB_INPUT}             id:new-person-dateOfBirth
${NEW_PERSON_NOTE_TEXTAREA}         id:new-person-note
${NEW_PERSON_VALID_LICENSE_CHECK}   xpath://label[contains(., 'Holds a valid driver license')]
${ADD_PERSON_SUBMIT_BUTTON}         xpath://button[@type='submit' and normalize-space()='Add person']

# Person Profile & 7 Tabs (J04 Steps 4-9)
${PERSON_TAB_PROFILE}               xpath://*[@role='tab'][normalize-space()='Profile']
${PERSON_TAB_LICENSES}              xpath://*[@role='tab'][normalize-space()='Licenses']
${PERSON_TAB_MOS}                   xpath://*[@role='tab'][normalize-space()='MOS']
${PERSON_TAB_AVAILABILITY}          xpath://*[@role='tab'][normalize-space()='Availability']
${PERSON_TAB_SAFETY}                xpath://*[@role='tab'][normalize-space()='Safety']
${PERSON_TAB_FILES}                 xpath://*[@role='tab'][normalize-space()='Files']
${PERSON_TAB_HISTORY}               xpath://*[@role='tab'][normalize-space()='History']
${PERSON_EDIT_BUTTON}               xpath://button[normalize-space()='Edit']
${PERSON_REMOVE_BUTTON}             xpath://button[normalize-space()='Remove']

# Licenses List & License Reports (J04 Steps 10, 18-20)
${LICENSES_HEADING}                 xpath://h1[normalize-space()='Licenses']
${LICENSES_SUBTITLE}                xpath://p[contains(., 'Vehicle licenses held in your units')]
${LICENSES_EXPIRING_30_DAYS}        xpath://button[normalize-space()='30 days'] | //*[@role='tab'][normalize-space()='30 days']
${LICENSES_EXPIRING_60_DAYS}        xpath://button[normalize-space()='60 days'] | //*[@role='tab'][normalize-space()='60 days']
${LICENSES_EXPIRING_90_DAYS}        xpath://button[normalize-space()='90 days'] | //*[@role='tab'][normalize-space()='90 days']
${EXPIRED_LICENSES_REPORT_HEADING}  xpath://h1[normalize-space()='Expired licenses']
${PERSONNEL_LICENSE_REPORT_HEADING}    xpath://h1[normalize-space()='Personnel license report']
${UNIT_LICENSE_REPORT_HEADING}      xpath://h1[normalize-space()='Unit license report']

*** Keywords ***
Navigate To Personnel List
    [Documentation]    Navigates directly to the Personnel roster (/sgen-tcp/protected/records/personnel) and waits for the heading (J04 Step 1).
    Go To                            ${BASE_URL}/sgen-tcp/protected/records/personnel
    Wait Until Element Is Visible    ${PERSONNEL_HEADING}    timeout=20s

Open First Person From Personnel List
    [Documentation]    Clicks the first person link in the Personnel roster and waits for the 7 profile tabs (J04 Step 4).
    ${first_person}=                 Set Variable    xpath:(//table//tbody//tr[1]//a)[1] | (//a[contains(@href, '/protected/records/personnel/') and not(contains(@href, '/new')) and not(contains(@href, '/removed'))])[1]
    Wait Until Element Is Visible    ${first_person}    timeout=15s
    Click Element                    ${first_person}
    Wait Until Element Is Visible    ${PERSON_TAB_PROFILE}    timeout=15s

Verify All Seven Person Profile Tabs
    [Documentation]    Verifies that all 7 tabs on a person's profile page are visible and switches through Licenses, MOS, and History (J04 Steps 4, 6, 8, 9).
    Element Should Be Visible        ${PERSON_TAB_PROFILE}
    Element Should Be Visible        ${PERSON_TAB_LICENSES}
    Element Should Be Visible        ${PERSON_TAB_MOS}
    Element Should Be Visible        ${PERSON_TAB_AVAILABILITY}
    Element Should Be Visible        ${PERSON_TAB_SAFETY}
    Element Should Be Visible        ${PERSON_TAB_FILES}
    Element Should Be Visible        ${PERSON_TAB_HISTORY}
    Click Element                    ${PERSON_TAB_LICENSES}
    Wait Until Page Contains         Driver license
    Click Element                    ${PERSON_TAB_MOS}
    Wait Until Page Contains         Add an MOS
    Click Element                    ${PERSON_TAB_HISTORY}
    Wait Until Page Contains         License changes
    Click Element                    ${PERSON_TAB_PROFILE}

Navigate To Add Person Page
    [Documentation]    Opens the Add a person form (/sgen-tcp/protected/records/personnel/new) (J04 Step 11).
    Go To                            ${BASE_URL}/sgen-tcp/protected/records/personnel/new
    Wait Until Element Is Visible    ${ADD_PERSON_HEADING}    timeout=20s

Navigate To Licenses List
    [Documentation]    Opens Personnel › Records › Licenses (/sgen-tcp/protected/records/licences) (J04 Step 10).
    Go To                            ${BASE_URL}/sgen-tcp/protected/records/licences
    Wait Until Element Is Visible    ${LICENSES_HEADING}    timeout=20s
    Element Should Be Visible        ${LICENSES_SUBTITLE}
