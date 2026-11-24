*** Settings ***
Documentation     J02: Missions and Resource Assignment.
...               Covers R201, R202, R206, R210, R213, R214, R215, R217, R226, R229, R234, R243, R245, R252, R253, R254.
Resource          ../resources/common.resource
Resource          ../resources/pages/login_page.resource
Resource          ../resources/pages/navigation_page.resource
Resource          ../resources/pages/missions_page.resource

Suite Setup       Open Authenticated Missions Session
Suite Teardown    Close Test Browser

*** Keywords ***
Open Authenticated Missions Session
    [Documentation]    Opens the browser, logs in once, dismisses popups, and switches to Dispatcher for mission planning.
    Open Test Browser
    Sign In To GLADM With Env Credentials
    Dismiss Post Login Popups If Present
    Start Test As Position           Dispatcher

*** Test Cases ***
Step 1 To 2: Open Missions List And Verify All Eight Bins
    [Documentation]    J02 Steps 1-2 (R202, R206, R210, R213, R214, R215, R217, R234, R252, R253):
    ...                Verify Missions opens on Inbox and displays all eight bins (Inbox, New, In planning,
    ...                Awaiting approval, Active, Archive, Non-tracking, All).
    [Tags]    J02    R202    R217    R252    R253    missions    bins    requires_login
    Navigate To Missions List
    Element Should Be Visible        ${MISSION_BIN_INBOX}
    Element Should Be Visible        ${MISSION_BIN_NEW}
    Element Should Be Visible        ${MISSION_BIN_IN_PLANNING}
    Element Should Be Visible        ${MISSION_BIN_AWAITING_APPROVAL}
    Element Should Be Visible        ${MISSION_BIN_ACTIVE}
    Element Should Be Visible        ${MISSION_BIN_ARCHIVE}
    Element Should Be Visible        ${MISSION_BIN_NON_TRACKING}
    Element Should Be Visible        ${MISSION_BIN_ALL}
    Select Mission Bin               New
    Select Mission Bin               All

Step 4 And 24: Create Vehicles Only Mission And Validate Duration Bounds
    [Documentation]    J02 Steps 4 & 24 (R201, R243, R245): Start the 3-step New Mission wizard, verify Takes (hours)
    ...                rejects values above 720 hours (30 days), then complete Step 2 and Step 3 (Review) and create the mission.
    [Tags]    J02    R201    R243    R245    missions    wizard    requires_login
    Start New Vehicles Only Mission Wizard
    # Verify Takes (hours) > 720 validation (feedback #966)
    Clear Element Text               ${MISSION_DURATION_HOURS_INPUT}
    Input Text                       ${MISSION_DURATION_HOURS_INPUT}    800
    Click Element                    ${MISSION_NEXT_BUTTON}
    Wait Until Page Contains         720
    # Fill valid Step 2 fields and proceed to Review
    Fill New Mission Step 2 When And Who
    ...    hours=8
    ...    destination=Camp San Mateo
    ...    poc=SSgt J02 Planner
    ...    phone=760-555-0102
    ...    requested_by=1st Marine Regiment
    ...    report_to=Supply Lot 4 (760-555-0199)
    Click Element                    ${MISSION_CREATE_BUTTON}
    Wait Until Element Is Visible    ${MISSION_OVERVIEW}    timeout=20s

Step 5: Verify Mission Overview And Tabs On Created Mission
    [Documentation]    J02 Step 5 (R201, R245, R254): Verify the mission page displays the At a glance overview
    ...                and tabs (Loads, TMRs, Cargo & route, Status & steps, Dispatch, Details).
    [Tags]    J02    R201    R245    R254    missions    overview    requires_login
    Element Should Be Visible        ${MISSION_OVERVIEW}
    Element Should Be Visible        ${MISSION_TAB_LOADS}
    Element Should Be Visible        ${MISSION_TAB_TMRS}
    Element Should Be Visible        ${MISSION_TAB_CARGO_ROUTE}
    Element Should Be Visible        ${MISSION_TAB_STATUS_STEPS}
    Element Should Be Visible        ${MISSION_TAB_DISPATCH}
    Element Should Be Visible        ${MISSION_TAB_DETAILS}
    Click Element                    ${MISSION_TAB_STATUS_STEPS}
    Wait Until Page Contains         Where it stands
    Click Element                    ${MISSION_TAB_DETAILS}
    Wait Until Page Contains         Point of contact
