*** Settings ***
Documentation     Page Object for GLADM Route Planner (J21) & Operations Map / Report My Location (J31):
...               Route planner (/protected/route-planner) with Distance, Plan network, Threats,
...               Tracks tabs and Weather on the map; Operations map (/protected/map) with Layers,
...               Find and lists, Moving now, Time slider, and Here menu; Report my location
...               (/protected/my-location).
Library           SeleniumLibrary
Resource          ../../variables/config.resource

*** Variables ***
# URLs
${ROUTE_PLANNER_URL}                ${BASE_URL}/protected/route-planner
${OPERATIONS_MAP_URL}               ${BASE_URL}/protected/map
${MY_LOCATION_URL}                  ${BASE_URL}/protected/my-location

# Route Planner Locators
${ROUTE_PLANNER_ROOT}               css=[data-slot='route-planner']
${ROUTE_TABLIST}                    xpath=//div[@role='tablist' and @aria-label='Route planner']
${ROUTE_TAB_DISTANCE}               xpath=//div[@role='tablist' and @aria-label='Route planner']//button[@role='tab' and normalize-space()='Distance']
${ROUTE_TAB_NETWORK}                xpath=//div[@role='tablist' and @aria-label='Route planner']//button[@role='tab' and normalize-space()='Plan network']
${ROUTE_TAB_THREATS}                xpath=//div[@role='tablist' and @aria-label='Route planner']//button[@role='tab' and normalize-space()='Threats']
${ROUTE_TAB_TRACKS}                 xpath=//div[@role='tablist' and @aria-label='Route planner']//button[@role='tab' and normalize-space()='Tracks']
${ROUTE_START_INPUT}                xpath=//input[@placeholder='Choose start, or click the map']
${ROUTE_DEST_INPUT}                 xpath=//input[@placeholder='Choose destination']
${ROUTE_SWAP_BTN}                   xpath=//button[@aria-label='Swap start and destination']
${ROUTE_ADD_STOP_BTN}               xpath=//button[contains(.,'Add stop')]
${ROUTE_RUN_BTN}                    xpath=//form[@aria-label='Trip']//button[@type='submit' and normalize-space()='Run']
${ROUTE_SUMMARY_BOX}                css=[data-slot='route-summary']
${ROUTE_WEATHER_BOX}                css=[data-slot='route-weather']
${ROUTE_ADD_THREAT_BTN}             css=[data-slot='distance-add-threat']
${ROUTE_DRAW_TRACK_BTN}             css=[data-slot='draw-track']
${ROUTE_TRACKS_LIST}                xpath=//*[@data-slot='tracks' or @data-slot='tracks-none']
${ROUTE_TRACK_FORM}                 css=[data-slot='track-form']
${ROUTE_NEW_NETWORK_BTN}            xpath=//button[contains(.,'New network') or contains(.,'Add place')]

# Operations Map Locators
${OPS_MAP_ROOT}                     css=[data-slot='ops-map']
${OPS_TOP_ROW}                      css=[data-slot='ops-top-row']
${OPS_TAB_LAYERS_BTN}               css=[data-slot='ops-tab-left']
${OPS_TAB_LISTS_BTN}                css=[data-slot='ops-tab-right']
${OPS_MOVING_NOW_BTN}               css=[data-slot='moving-now']
${OPS_MAP_ONLY_BTN}                 id=map-only
${OPS_PANEL_LEFT}                   id=panel-left
${OPS_PANEL_RIGHT}                  id=panel-right
${OPS_FIND_LAYER_INPUT}             xpath=//div[@id='panel-left']//input[@type='search' or contains(@placeholder,'layer')] | //label[contains(.,'Find a layer')]/following::input[1]
${OPS_REPORT_MY_LOC_BTN}            css=[data-slot='ops-check-in-open']
${OPS_FIND_RECORD_INPUT}            xpath=//input[@placeholder='Mission, convoy, TMR, truck, driver, utilities site or place']
${OPS_WHATS_HAPPENING_SECTION}      css=[data-slot='ops-happening']
${OPS_PLAN_MOVES_SECTION}           css=[data-slot='ops-plan-box']
${OPS_RECORDS_LIST}                 css=[data-slot='ops-list']
${OPS_TIME_BAR}                     css=[data-slot='ops-time-bar']

# Report My Location Locators
${MY_LOC_PANEL}                     css=[data-slot='check-in']
${MY_LOC_LAST_CHECKIN}              css=[data-slot='check-in-last']
${MY_LOC_USE_DEVICE_BTN}            xpath=//button[normalize-space()='Use my location' or normalize-space()='Find my location again']
${MY_LOC_TYPE_GRID_BTN}             xpath=//button[normalize-space()='Type my grid instead']
${MY_LOC_PICK_ON_MAP_BTN}           xpath=//button[normalize-space()='Pick on map']
${MY_LOC_GRID_INPUT}                xpath=//input[@placeholder='11S MS 12345 67890']
${MY_LOC_NOTE_INPUT}                xpath=//input[@placeholder='At the ASP gate']
${MY_LOC_SEND_BTN}                  xpath=//button[normalize-space()='Send my location']

*** Keywords ***
Open Route Planner Page
    [Documentation]    Navigates directly to the Route Planner (/protected/route-planner).
    Go To    ${ROUTE_PLANNER_URL}
    Wait Until Element Is Visible    ${ROUTE_TABLIST}    timeout=${SELENIUM_TIMEOUT}

Verify Route Planner Tabs And Trip Form
    [Documentation]    Verifies the 4 Route Planner tabs (Distance, Plan network, Threats, Tracks) and From/To inputs.
    Wait Until Element Is Visible    ${ROUTE_TAB_DISTANCE}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${ROUTE_TAB_NETWORK}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${ROUTE_TAB_THREATS}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${ROUTE_TAB_TRACKS}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${ROUTE_START_INPUT}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${ROUTE_DEST_INPUT}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${ROUTE_ADD_STOP_BTN}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${ROUTE_RUN_BTN}    timeout=${SELENIUM_TIMEOUT}

Switch Route Planner Tab
    [Documentation]    Clicks one of the Route Planner tabs ('Distance', 'Plan network', 'Threats', 'Tracks').
    [Arguments]    ${tab_label}
    ${tab}=    Set Variable    xpath=//div[@role='tablist' and @aria-label='Route planner']//button[@role='tab' and normalize-space()='${tab_label}']
    Wait Until Element Is Visible    ${tab}    timeout=${SELENIUM_TIMEOUT}
    Click Element    ${tab}
    Element Attribute Value Should Be    ${tab}    aria-selected    true

Enter Route Start And Destination Grids
    [Documentation]    Enters start and destination grids/places into the Route Planner and clicks Run.
    [Arguments]    ${start_grid}    ${dest_grid}
    Wait Until Element Is Visible    ${ROUTE_START_INPUT}    timeout=${SELENIUM_TIMEOUT}
    Clear Element Text    ${ROUTE_START_INPUT}
    Input Text    ${ROUTE_START_INPUT}    ${start_grid}
    Press Keys    ${ROUTE_START_INPUT}    TAB
    Clear Element Text    ${ROUTE_DEST_INPUT}
    Input Text    ${ROUTE_DEST_INPUT}    ${dest_grid}
    Press Keys    ${ROUTE_DEST_INPUT}    TAB
    Click Element    ${ROUTE_RUN_BTN}

Open Operations Map Page
    [Documentation]    Navigates directly to the Operations Map (/protected/map).
    Go To    ${OPERATIONS_MAP_URL}
    Wait Until Element Is Visible    ${OPS_MAP_ROOT}    timeout=${SELENIUM_TIMEOUT}

Open Operations Map Layers Panel
    [Documentation]    Opens the left 'Layers' panel on the Operations Map if it is not already open.
    ${visible}=    Run Keyword And Return Status    Element Should Be Visible    ${OPS_PANEL_LEFT}
    IF    not ${visible}
        Wait Until Element Is Visible    ${OPS_TAB_LAYERS_BTN}    timeout=${SELENIUM_TIMEOUT}
        Click Element    ${OPS_TAB_LAYERS_BTN}
        Wait Until Element Is Visible    ${OPS_PANEL_LEFT}    timeout=${SELENIUM_TIMEOUT}
    END

Open Operations Map Find And Lists Panel
    [Documentation]    Opens the right 'Find and lists' panel on the Operations Map if it is not already open.
    ${visible}=    Run Keyword And Return Status    Element Should Be Visible    ${OPS_PANEL_RIGHT}
    IF    not ${visible}
        Wait Until Element Is Visible    ${OPS_TAB_LISTS_BTN}    timeout=${SELENIUM_TIMEOUT}
        Click Element    ${OPS_TAB_LISTS_BTN}
        Wait Until Element Is Visible    ${OPS_PANEL_RIGHT}    timeout=${SELENIUM_TIMEOUT}
    END

Open Report My Location Page
    [Documentation]    Navigates directly to Report my location (/protected/my-location).
    Go To    ${MY_LOCATION_URL}
    Wait Until Element Is Visible    ${MY_LOC_PANEL}    timeout=${SELENIUM_TIMEOUT}

Verify Report My Location Controls
    [Documentation]    Verifies the last check-in line and the 3 location options (Use my location, Type my grid instead, Pick on map).
    Wait Until Element Is Visible    ${MY_LOC_PANEL}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${MY_LOC_LAST_CHECKIN}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${MY_LOC_USE_DEVICE_BTN}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${MY_LOC_TYPE_GRID_BTN}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${MY_LOC_PICK_ON_MAP_BTN}    timeout=${SELENIUM_TIMEOUT}

Verify Plan Network Tab Controls
    [Documentation]    Switches to the Plan network tab (J26, J28) and verifies network planning controls.
    Switch Route Planner Tab    Plan network
    Wait Until Element Is Visible    xpath=//button[contains(.,'New network') or contains(.,'Add place') or contains(.,'Calculate')] | //*[@data-slot='route-panel']    timeout=${SELENIUM_TIMEOUT}

Verify Tracks Tab And Draw A Track Controls
    [Documentation]    Switches to the Tracks tab (J36) and verifies the tracks list and Draw a track button.
    Switch Route Planner Tab    Tracks
    Wait Until Element Is Visible    ${ROUTE_TRACKS_LIST}    timeout=${SELENIUM_TIMEOUT}
    ${can_draw}=    Run Keyword And Return Status    Element Should Be Visible    ${ROUTE_DRAW_TRACK_BTN}
    IF    ${can_draw}
        Click Element    ${ROUTE_DRAW_TRACK_BTN}
        Wait Until Element Is Visible    ${ROUTE_TRACK_FORM}    timeout=${SELENIUM_TIMEOUT}
    END
