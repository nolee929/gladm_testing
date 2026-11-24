*** Settings ***
Documentation     J21 & J31: Route Planner, Operations Map & Report My Location — Distance, Plan network, Threats, Tracks, Map Layers, and Check-in.
...               Covers R040, R041, R042, R043, R044, R045, UT-001.
Resource          ../resources/common.resource
Resource          ../resources/pages/login_page.resource
Resource          ../resources/pages/navigation_page.resource
Resource          ../resources/pages/map_page.resource

Suite Setup       Open Authenticated Map Session
Suite Teardown    Close Test Browser

*** Keywords ***
Open Authenticated Map Session
    [Documentation]    Opens the browser, logs in once, dismisses popups, and switches to Unit supervisor (S-4).
    Open Test Browser
    Sign In To GLADM With Env Credentials
    Dismiss Post Login Popups If Present
    Start Test As Position           Unit supervisor (S-4)

*** Test Cases ***
Step 1 To 5: Route Planner Tabs And Trip Form Render
    [Documentation]    J21 Steps 1-5 (R040, R041, R042): Open Route Planner (/protected/route-planner), verify
    ...                Distance, Plan network, Threats, and Tracks tabs, From/To inputs, Add stop, and Run button.
    [Tags]    J21    R040    R041    R042    route_planner    requires_login
    Open Route Planner Page
    Verify Route Planner Tabs And Trip Form
    Switch Route Planner Tab         Plan network
    Switch Route Planner Tab         Threats
    Switch Route Planner Tab         Tracks
    Switch Route Planner Tab         Distance

Step 1 To 7: Operations Map Layers And Find And Lists Panels Open
    [Documentation]    J31 Steps 1-7: Open Operations Map (/protected/map) and open both the left Layers panel
    ...                and the right Find and lists panel (What's happening, Plan moves, Find).
    [Tags]    J31    operations_map    requires_login
    Open Operations Map Page
    Open Operations Map Layers Panel
    Page Should Contain              Operations map
    Open Operations Map Find And Lists Panel
    Wait Until Element Is Visible    ${OPS_FIND_RECORD_INPUT}          timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${OPS_WHATS_HAPPENING_SECTION}    timeout=${SELENIUM_TIMEOUT}

Step 22 To 24: Report My Location Check In Options Render
    [Documentation]    J31 Steps 22-24: Open Report my location (/protected/my-location) and verify last check-in status,
    ...                Use my location, Type my grid instead, and Pick on map controls.
    [Tags]    J31    my_location    requires_login
    Open Report My Location Page
    Verify Report My Location Controls
    Click Element                    ${MY_LOC_TYPE_GRID_BTN}
    Wait Until Element Is Visible    ${MY_LOC_GRID_INPUT}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${MY_LOC_SEND_BTN}      timeout=${SELENIUM_TIMEOUT}

J26 And J28: Plan Network Tab And Network Places Render
    [Documentation]    J26 & J28: Open Route Planner, switch to Plan network tab, and verify network builder
    ...                places, areas, and matrix controls load.
    [Tags]    J26    J28    plan_network    route_planner    requires_login
    Open Route Planner Page
    Verify Plan Network Tab Controls

J36: Tracks Tab And Draw A Track Form Render
    [Documentation]    J36: Open Route Planner, switch to the Tracks tab, and verify the tracks list and
    ...                Draw a track form controls.
    [Tags]    J36    draw_track    route_planner    requires_login
    Open Route Planner Page
    Verify Tracks Tab And Draw A Track Controls
