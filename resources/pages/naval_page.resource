*** Settings ***
Documentation     Page Object for GLADM MEU/ARG & Naval Amphibious Planning (J41, J43, J44, J45, J66):
...               ARG presence (/protected/naval/presence), Plan the offload (/protected/naval/offload),
...               MEU sustainment (/protected/naval/sustainment), Plan MEU resupply (/protected/naval/resupply),
...               and Fleet schedule (/protected/naval/fleet-schedule).
Library           SeleniumLibrary
Resource          ../../variables/config.resource

*** Variables ***
${ARG_PRESENCE_URL}                 ${BASE_URL}/protected/naval/presence
${PLAN_OFFLOAD_URL}                 ${BASE_URL}/protected/naval/offload
${MEU_SUSTAINMENT_URL}              ${BASE_URL}/protected/naval/sustainment
${MEU_RESUPPLY_URL}                 ${BASE_URL}/protected/naval/resupply
${FLEET_SCHEDULE_URL}               ${BASE_URL}/protected/naval/fleet-schedule
${FLEET_SCHEDULE_COMPARE_URL}       ${BASE_URL}/protected/naval/fleet-schedule-compare

# Headings & Sections
${ARG_PRESENCE_HEADING}             xpath=//h1[normalize-space()='ARG presence']
${PLAN_OFFLOAD_HEADING}             xpath=//h1[normalize-space()='Plan the offload']
${MEU_SUSTAINMENT_HEADING}          xpath=//h1[normalize-space()='MEU sustainment']
${MEU_RESUPPLY_HEADING}             xpath=//h1[normalize-space()='Resupply plan' or contains(.,'resupply')]
${FLEET_SCHEDULE_HEADING}           xpath=//h1[normalize-space()='Fleet schedule']
${FLEET_COVERAGE_SECTION}           id=fleet-coverage
${FLEET_SHIPS_SECTION}              id=fleet-ships
${FLEET_DOCKS_SECTION}              id=fleet-docks

*** Keywords ***
Open ARG Presence Page
    [Documentation]    Navigates to ARG presence (/protected/naval/presence).
    Go To    ${ARG_PRESENCE_URL}
    Wait Until Element Is Visible    ${ARG_PRESENCE_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open Plan The Offload Page
    [Documentation]    Navigates to Plan the offload (/protected/naval/offload).
    Go To    ${PLAN_OFFLOAD_URL}
    Wait Until Element Is Visible    ${PLAN_OFFLOAD_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open MEU Sustainment Page
    [Documentation]    Navigates to MEU sustainment (/protected/naval/sustainment).
    Go To    ${MEU_SUSTAINMENT_URL}
    Wait Until Element Is Visible    ${MEU_SUSTAINMENT_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open Plan MEU Resupply Page
    [Documentation]    Navigates to Plan MEU resupply (/protected/naval/resupply).
    Go To    ${MEU_RESUPPLY_URL}
    Wait Until Element Is Visible    ${MEU_RESUPPLY_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open Fleet Schedule Page
    [Documentation]    Navigates to the Amphibious Fleet schedule (/protected/naval/fleet-schedule).
    Go To    ${FLEET_SCHEDULE_URL}
    Wait Until Element Is Visible    ${FLEET_SCHEDULE_HEADING}    timeout=${SELENIUM_TIMEOUT}
