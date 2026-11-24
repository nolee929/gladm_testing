*** Settings ***
Documentation     J06: Transportation Capacity Board — Shared Fleet Allocation, Drivers, Availability, Breakdown, and Thresholds.
...               Covers R127, R138, R142, R143, R144, R151, R153, R154, R158, R183, R316, R322, R332.
Resource          ../resources/common.resource
Resource          ../resources/pages/login_page.resource
Resource          ../resources/pages/navigation_page.resource
Resource          ../resources/pages/capacity_page.resource

Suite Setup       Open Authenticated Capacity Session
Suite Teardown    Close Test Browser

*** Keywords ***
Open Authenticated Capacity Session
    [Documentation]    Opens the browser, logs in once, dismisses popups, and switches to Unit supervisor (S-4).
    Open Test Browser
    Sign In To GLADM With Env Credentials
    Dismiss Post Login Popups If Present
    Start Test As Position           Unit supervisor (S-4)

*** Test Cases ***
Step 1 To 4: Open Capacity Board And Verify Scope Bar Tiles And Allocation Controls
    [Documentation]    J06 Steps 1-4 (R142, R143, R151, R153, R316, R322, R332): Open Transport › Plan lift › Capacity Board,
    ...                verify the scope bar, stat tiles, and category cards (Cargo, Passengers, Fuel, Water) with allocation sliders.
    [Tags]    J06    R142    R143    R151    R153    R316    R322    capacity    board    requires_login
    Navigate To Capacity Board
    Element Should Be Visible        ${CAPACITY_SCOPE_BAR}
    Element Should Be Visible        ${CAPACITY_TAB_BOARD}
    Element Should Be Visible        ${CAPACITY_TAB_AVAILABILITY}
    Element Should Be Visible        ${CAPACITY_TAB_BREAKDOWN}
    Element Should Be Visible        ${CAPACITY_TAB_TRUCKS_BY_TYPE}
    Element Should Be Visible        ${CAPACITY_TAB_THRESHOLDS}
    Wait Until Page Contains Element    ${CAPACITY_STAT_TILES}    timeout=20s
    Wait Until Page Contains Element    ${CAPACITY_CATEGORY_CARD}    timeout=20s

Step 15 To 16: Switch To Drivers View And Verify Driver Coverage Section
    [Documentation]    J06 Steps 15-16 (R127, R138, R158, R183): Switch the Capacity Board to the Drivers view
    ...                and verify licensed driver availability and Driver coverage.
    [Tags]    J06    R127    R138    R158    R183    capacity    drivers    requires_login
    Navigate To Capacity Board
    Switch Capacity View To Drivers
    Page Should Contain              Driver coverage
    Switch Capacity View To Trucks

Step 19 To 21: Verify Availability Breakdown Trucks By Type And Thresholds Tabs
    [Documentation]    J06 Steps 19, 19b, 20, & 21 (R138, R143, R144, R151, R154, R183, R322): Switch through the
    ...                Availability, Breakdown, Trucks by type (TAMCN), and Thresholds tabs on the Capacity Board.
    [Tags]    J06    R138    R143    R144    R151    R154    R322    capacity    tabs    requires_login
    Navigate To Capacity Board
    Select Capacity Tab              ${CAPACITY_TAB_AVAILABILITY}
    Wait Until Element Is Visible    ${AVAILABILITY_HEADING}    timeout=15s
    Select Capacity Tab              ${CAPACITY_TAB_BREAKDOWN}
    Wait Until Element Is Visible    ${BREAKDOWN_HEADING}    timeout=15s
    Select Capacity Tab              ${CAPACITY_TAB_TRUCKS_BY_TYPE}
    Wait Until Element Is Visible    ${TAMCN_VIEW}    timeout=15s
    Select Capacity Tab              ${CAPACITY_TAB_THRESHOLDS}
    Wait Until Element Is Visible    ${THRESHOLDS_VIEW}    timeout=15s
    Page Should Contain              Capacity colors
