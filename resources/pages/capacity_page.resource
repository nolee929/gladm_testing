*** Settings ***
Documentation     Page Object Model for GLADM Transportation Capacity Board, Shared Fleet Allocation, Drivers, Availability, and Thresholds (J06 & J07).
Library           SeleniumLibrary
Resource          ../../variables/config.resource

*** Variables ***
# Capacity Board Header, Headline & Scope Bar (J06 Steps 1-3, 10-13)
${CAPACITY_HEADLINE}                css:[data-slot="capacity-headline"]
${CAPACITY_SCOPE_BAR}               css:[data-slot="scope-bar"]
${CAPACITY_STAT_TILES}              css:[data-slot="stat-tiles"]
${CAPACITY_FIRST_STAT_TILE}         css:[data-slot="stat-tile"]
${CAPACITY_CATEGORY_CARD}           css:[data-slot="category-card"]
${CAPACITY_DRAWER}                  css:[data-slot="capacity-drawer"]
${BY_CATEGORY_HEADING}              id:by-category-heading

# Shared Fleet Allocation Sliders & Priority Controls (J06 Steps 4-4d)
${ALLOCATE_CARGO_SLIDER}            id:allocate-cargo
${ALLOCATE_PAX_SLIDER}              id:allocate-pax
${ALLOCATE_FUEL_SLIDER}             id:allocate-fuel
${ALLOCATE_WATER_SLIDER}            id:allocate-water
${PRIORITY_CARGO_SELECT}            id:priority-cargo
${PRIORITY_PAX_SELECT}              id:priority-pax
${PRIORITY_FUEL_SELECT}             id:priority-fuel
${PRIORITY_WATER_SELECT}            id:priority-water
${CAPACITY_BALANCE_BUTTON}          xpath://button[normalize-space()='Balance']

# View Switcher (Trucks vs Drivers) & Board Tabs (J06 Steps 15-21)
${CAPACITY_TRUCKS_VIEW_BUTTON}      xpath://button[normalize-space()='Trucks'] | //*[@role='tab'][normalize-space()='Trucks']
${CAPACITY_DRIVERS_VIEW_BUTTON}     xpath://button[normalize-space()='Drivers'] | //*[@role='tab'][normalize-space()='Drivers']
${CAPACITY_DRIVERS_VIEW}            css:[data-slot="drivers-view"]
${CAPACITY_TAB_BOARD}               xpath://*[@role='tab'][normalize-space()='Board']
${CAPACITY_TAB_AVAILABILITY}        xpath://*[@role='tab'][normalize-space()='Availability']
${CAPACITY_TAB_BREAKDOWN}           xpath://*[@role='tab'][normalize-space()='Breakdown']
${CAPACITY_TAB_TRUCKS_BY_TYPE}      xpath://*[@role='tab'][contains(normalize-space(), 'Trucks by type') or contains(normalize-space(), 'By type')]
${CAPACITY_TAB_THRESHOLDS}          xpath://*[@role='tab'][normalize-space()='Thresholds']
${AVAILABILITY_HEADING}             id:availability-heading
${BREAKDOWN_HEADING}                id:breakdown-heading
${TAMCN_VIEW}                       css:[data-slot="tamcn-view"]
${THRESHOLDS_VIEW}                  css:[data-slot="thresholds-view"]
${THRESHOLDS_EDIT_LINK}             css:[data-slot="thresholds-edit-link"]

*** Keywords ***
Navigate To Capacity Board
    [Documentation]    Navigates directly to the Capacity Board (/sgen-tcp/protected/capacity) and waits for the headline or category section (J06 Step 1).
    Go To                            ${BASE_URL}/sgen-tcp/protected/capacity
    Wait Until Page Contains Element    ${CAPACITY_SCOPE_BAR}    timeout=20s

Switch Capacity View To Drivers
    [Documentation]    Switches the Capacity Board from Trucks to Drivers view (J06 Step 15).
    Wait Until Element Is Visible    ${CAPACITY_DRIVERS_VIEW_BUTTON}
    Click Element                    ${CAPACITY_DRIVERS_VIEW_BUTTON}
    Wait Until Element Is Visible    ${CAPACITY_DRIVERS_VIEW}    timeout=15s

Switch Capacity View To Trucks
    [Documentation]    Switches the Capacity Board back to Trucks view.
    Wait Until Element Is Visible    ${CAPACITY_TRUCKS_VIEW_BUTTON}
    Click Element                    ${CAPACITY_TRUCKS_VIEW_BUTTON}

Select Capacity Tab
    [Documentation]    Clicks one of the Capacity Board tabs (Board, Availability, Breakdown, Trucks by type, Thresholds) (J06 Steps 19-21).
    [Arguments]    ${tab_locator}
    Wait Until Element Is Visible    ${tab_locator}
    Click Element                    ${tab_locator}
