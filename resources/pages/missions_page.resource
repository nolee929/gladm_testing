*** Settings ***
Documentation     Page Object Model for GLADM Missions, Resource Assignments, and New Mission Wizard (J02).
Library           SeleniumLibrary
Resource          ../../variables/config.resource

*** Variables ***
# Missions List & Bins (J02 Steps 1-3)
${MISSIONS_HEADING}                 xpath://h1[normalize-space()='Missions']
${NEW_MISSION_BUTTON}               xpath://a[contains(., 'New mission')] | //button[contains(., 'New mission')]
${PLAN_NEW_MISSION_BUTTON}          xpath://button[contains(., 'Plan a new mission')]
${MISSIONS_CREATED_BY_ME_BUTTON}    css:[data-slot="missions-created-by-me"]
${MISSION_BIN_INBOX}                xpath://*[@role='tab'][starts-with(normalize-space(), 'Inbox')] | //button[starts-with(normalize-space(), 'Inbox')]
${MISSION_BIN_NEW}                  xpath://*[@role='tab'][starts-with(normalize-space(), 'New')] | //button[starts-with(normalize-space(), 'New')]
${MISSION_BIN_IN_PLANNING}          xpath://*[@role='tab'][starts-with(normalize-space(), 'In planning')] | //button[starts-with(normalize-space(), 'In planning')]
${MISSION_BIN_AWAITING_APPROVAL}    xpath://*[@role='tab'][starts-with(normalize-space(), 'Awaiting approval')] | //button[starts-with(normalize-space(), 'Awaiting approval')]
${MISSION_BIN_ACTIVE}               xpath://*[@role='tab'][starts-with(normalize-space(), 'Active')] | //button[starts-with(normalize-space(), 'Active')]
${MISSION_BIN_ARCHIVE}              xpath://*[@role='tab'][starts-with(normalize-space(), 'Archive')] | //button[starts-with(normalize-space(), 'Archive')]
${MISSION_BIN_NON_TRACKING}         xpath://*[@role='tab'][starts-with(normalize-space(), 'Non-tracking')] | //button[starts-with(normalize-space(), 'Non-tracking')]
${MISSION_BIN_ALL}                  xpath://*[@role='tab'][starts-with(normalize-space(), 'All')] | //button[starts-with(normalize-space(), 'All')]

# 3-Step New Mission Wizard (J02 Step 4, Step 24)
${NEW_MISSION_STEP_HEADING}         id:new-mission-step
${NEW_MISSION_TMRS_HEADING}         id:new-mission-tmrs
${KIND_VEHICLES_ONLY_RADIO}         xpath://label[contains(., 'Vehicles only (non-tracking)')]
${MISSION_NEXT_BUTTON}              xpath://button[normalize-space()='Next']
${MISSION_BACK_BUTTON}              xpath://button[normalize-space()='Back']
${MISSION_CREATE_BUTTON}            xpath://button[normalize-space()='Create mission']
${MISSION_DEPARTURE_INPUT}          id:new-mission-departure
${MISSION_DURATION_HOURS_INPUT}     id:new-mission-durationHours
${MISSION_DESTINATION_INPUT}        id:new-mission-destination
${MISSION_POC_INPUT}                id:new-mission-poc
${MISSION_POC_PHONE_INPUT}          id:new-mission-pocPhone
${MISSION_COMMANDER_INPUT}          id:new-mission-commander
${MISSION_REQUESTED_BY_INPUT}       id:new-mission-requestedBy
${MISSION_REPORT_TO_INPUT}          id:new-mission-reportTo

# Mission Full Page & Overview (J02 Steps 5-25)
${MISSION_OVERVIEW}                 id:mission-overview
${MISSION_JOURNEY}                  css:[data-testid="mission-journey"]
${MISSION_STATUS_BADGE}             css:[data-testid="mission-status"]
${MISSION_TAB_LOADS}                xpath://*[@role='tab'][starts-with(normalize-space(), 'Loads')]
${MISSION_TAB_TMRS}                 xpath://*[@role='tab'][starts-with(normalize-space(), 'TMRs')]
${MISSION_TAB_CARGO_ROUTE}          xpath://*[@role='tab'][starts-with(normalize-space(), 'Cargo & route')]
${MISSION_TAB_STATUS_STEPS}         xpath://*[@role='tab'][starts-with(normalize-space(), 'Status & steps')]
${MISSION_TAB_DISPATCH}             xpath://*[@role='tab'][starts-with(normalize-space(), 'Dispatch')]
${MISSION_TAB_DETAILS}              xpath://*[@role='tab'][starts-with(normalize-space(), 'Details')]

*** Keywords ***
Navigate To Missions List
    [Documentation]    Navigates directly to the Missions list page (/sgen-tcp/protected/missions) and waits for the heading (J02 Step 1).
    Go To                            ${BASE_URL}/sgen-tcp/protected/missions
    Wait Until Element Is Visible    ${MISSIONS_HEADING}    timeout=20s

Select Mission Bin
    [Documentation]    Clicks one of the mission bins by name (Inbox, New, In planning, Awaiting approval, Active, Archive, Non-tracking, All).
    [Arguments]    ${bin_name}
    ${bin_locator}=                  Set Variable    xpath://*[@role='tab'][starts-with(normalize-space(), '${bin_name}')] | //button[starts-with(normalize-space(), '${bin_name}')]
    Wait Until Element Is Visible    ${bin_locator}
    Click Element                    ${bin_locator}

Start New Vehicles Only Mission Wizard
    [Documentation]    Opens the New Mission wizard (/sgen-tcp/protected/missions/new), selects 'Vehicles only (non-tracking)', and advances to Step 2 (J02 Step 4, Step 24).
    Go To                            ${BASE_URL}/sgen-tcp/protected/missions/new
    Wait Until Element Is Visible    ${NEW_MISSION_STEP_HEADING}    timeout=20s
    Click Element                    ${KIND_VEHICLES_ONLY_RADIO}
    Click Element                    ${MISSION_NEXT_BUTTON}
    Wait Until Element Is Visible    ${MISSION_DURATION_HOURS_INPUT}

Fill New Mission Step 2 When And Who
    [Documentation]    Fills Step 2 (When and who) of the New Mission wizard and advances to Step 3 (Review) (J02 Step 4).
    [Arguments]    ${hours}=8    ${destination}=Camp San Mateo    ${poc}=SSgt J02 Planner    ${phone}=760-555-0102    ${requested_by}=1st Marine Regiment    ${report_to}=Supply Lot 4 (760-555-0199)
    Wait Until Element Is Visible    ${MISSION_DURATION_HOURS_INPUT}
    Clear Element Text               ${MISSION_DURATION_HOURS_INPUT}
    Input Text                       ${MISSION_DURATION_HOURS_INPUT}    ${hours}
    Clear Element Text               ${MISSION_DESTINATION_INPUT}
    Input Text                       ${MISSION_DESTINATION_INPUT}       ${destination}
    ${cur_poc}=                      Get Value    ${MISSION_POC_INPUT}
    IF    '${cur_poc}' == '${EMPTY}'
        Input Text                   ${MISSION_POC_INPUT}               ${poc}
    END
    ${cur_phone}=                    Get Value    ${MISSION_POC_PHONE_INPUT}
    IF    '${cur_phone}' == '${EMPTY}'
        Input Text                   ${MISSION_POC_PHONE_INPUT}         ${phone}
    END
    Clear Element Text               ${MISSION_REQUESTED_BY_INPUT}
    Input Text                       ${MISSION_REQUESTED_BY_INPUT}      ${requested_by}
    Clear Element Text               ${MISSION_REPORT_TO_INPUT}
    Input Text                       ${MISSION_REPORT_TO_INPUT}         ${report_to}
    Click Element                    ${MISSION_NEXT_BUTTON}
    Wait Until Element Is Visible    ${MISSION_CREATE_BUTTON}
