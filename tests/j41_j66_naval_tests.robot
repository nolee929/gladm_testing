*** Settings ***
Documentation     MEU/ARG & Naval Amphibious Planning Test Suite (Journeys J41, J43, J44, J45, and J66):
...               Verifies ARG presence (/protected/naval/presence), Plan the offload (/protected/naval/offload),
...               MEU sustainment (/protected/naval/sustainment), Plan MEU resupply (/protected/naval/resupply),
...               and Fleet schedule (/protected/naval/fleet-schedule).
Resource          ../resources/common.resource
Resource          ../resources/pages/login_page.resource
Resource          ../resources/pages/navigation_page.resource
Resource          ../resources/pages/naval_page.resource
Suite Setup       Open Authenticated Naval Session
Suite Teardown    Close Test Browser

*** Keywords ***
Open Authenticated Naval Session
    [Documentation]    Opens the browser, logs in once, and dismisses post-login popups.
    Open Test Browser
    Sign In To GLADM With Env Credentials
    Dismiss Post Login Popups If Present

*** Test Cases ***
J41-01 Verify ARG Presence Page Loads
    [Documentation]    Navigates to ARG presence (/protected/naval/presence) and verifies the heading
    ...                and presence coverage view.
    [Tags]    j41    naval    arg_presence    requires_login
    Open ARG Presence Page

J43-01 Verify Plan The Offload Page Loads
    [Documentation]    Navigates to Plan the offload (/protected/naval/offload) and verifies the
    ...                amphibious offload planner loads.
    [Tags]    j43    naval    offload    requires_login
    Open Plan The Offload Page

J44-01 Verify MEU Sustainment Page Loads
    [Documentation]    Navigates to MEU sustainment (/protected/naval/sustainment) and verifies the
    ...                days-of-supply sustainment dashboard loads.
    [Tags]    j44    naval    meu_sustainment    requires_login
    Open MEU Sustainment Page

J45-01 Verify Plan MEU Resupply Page Loads
    [Documentation]    Navigates to Plan MEU resupply (/protected/naval/resupply) and verifies the
    ...                resupply planner loads.
    [Tags]    j45    naval    meu_resupply    requires_login
    Open Plan MEU Resupply Page

J66-01 Verify Fleet Schedule Page And Sections Load
    [Documentation]    Navigates to Fleet schedule (/protected/naval/fleet-schedule) and verifies
    ...                the Fleet schedule heading, coverage, ships, and docks sections.
    [Tags]    j66    naval    fleet_schedule    requires_login
    Open Fleet Schedule Page
    Wait Until Element Is Visible    ${FLEET_COVERAGE_SECTION}    timeout=${SELENIUM_TIMEOUT}
