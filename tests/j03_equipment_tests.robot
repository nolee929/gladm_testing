*** Settings ***
Documentation     J03: Equipment, TAMCNs, and Models — Equipment List, Vehicle Profiles, and Catalog.
...               Covers R010, R011, R013, R014, R015, R016, R017, R022, R024, R026, R027, R030, R033, R035, R040, R042, R044, R046, R049, R050, R053, R055, R061, R064, R066, R068, R073.
Resource          ../resources/common.resource
Resource          ../resources/pages/login_page.resource
Resource          ../resources/pages/navigation_page.resource
Resource          ../resources/pages/equipment_page.resource

Suite Setup       Open Authenticated Equipment Session
Suite Teardown    Close Test Browser

*** Keywords ***
Open Authenticated Equipment Session
    [Documentation]    Opens the browser, logs in once, dismisses popups, and switches to Unit supervisor (S-4).
    Open Test Browser
    Sign In To GLADM With Env Credentials
    Dismiss Post Login Popups If Present
    Start Test As Position           Unit supervisor (S-4)

*** Test Cases ***
Step 1 To 3: Open Equipment List And Verify Search And Filters
    [Documentation]    J03 Steps 1-3 (R030, R033, R042, R044, R061, R064): Open Equipment › Records › Equipment,
    ...                verify Search, More filters, Export, Removed equipment link, and Add vehicle button.
    [Tags]    J03    R030    R042    R044    R061    equipment    list    requires_login
    Navigate To Equipment List
    Element Should Be Visible        ${EQUIPMENT_SEARCH_INPUT}
    Element Should Be Visible        ${EQUIPMENT_MORE_FILTERS_BUTTON}
    Element Should Be Visible        ${EQUIPMENT_EXPORT_BUTTON}
    Element Should Be Visible        ${REMOVED_EQUIPMENT_LINK}
    Element Should Be Visible        ${ADD_VEHICLE_BUTTON}

Step 4 To 6 And 10: Open Vehicle Profile And Verify All Seven Tabs
    [Documentation]    J03 Steps 4-6 & 10 (R013, R017, R046, R049, R053, R055, R066, R073): Open a vehicle from the list
    ...                and verify that all 7 tabs (Profile, Capabilities, Availability, Service requests (GCSS),
    ...                Condition alerts (CBM+), Pairing, History) are visible and switchable.
    [Tags]    J03    R046    R049    R053    R055    R066    R073    equipment    profile    requires_login
    Navigate To Equipment List
    Open First Vehicle From Equipment List
    Verify All Seven Vehicle Profile Tabs

Step 8: Open Add A Vehicle Form And Verify Required Fields
    [Documentation]    J03 Step 8 (R024, R050, R054): Open Add a vehicle (/protected/records/equipment/new) and verify
    ...                the Copy from section, Model, Serial number, License plate, and Add vehicle buttons.
    [Tags]    J03    R024    R050    R054    equipment    add_vehicle    requires_login
    Go To                            ${BASE_URL}/sgen-tcp/protected/records/equipment/new
    Wait Until Element Is Visible    ${ADD_VEHICLE_HEADING}    timeout=20s
    Page Should Contain              Start from a vehicle like it (optional)
    Element Should Be Visible        ${NEW_VEHICLE_SERIAL_INPUT}
    Element Should Be Visible        ${NEW_VEHICLE_PLATE_INPUT}
    Element Should Be Visible        ${NEW_VEHICLE_RFID_INPUT}
    Element Should Be Visible        ${NEW_VEHICLE_RADIO_INPUT}
    Element Should Be Visible        ${NEW_VEHICLE_TRACKER_INPUT}
    Element Should Be Visible        ${ADD_AND_START_ANOTHER_BUTTON}
    Element Should Be Visible        ${ADD_VEHICLE_SUBMIT_BUTTON}

Step 18 To 21 And 25: Verify TAMCNs Models NSN Check And Model Capabilities
    [Documentation]    J03 Steps 18-21 & 25 (R010, R011, R015, R016, R017, R026, R027, R040, R068):
    ...                Open TAMCNs and Models catalog, verify Add a model requires an NSN, and check Model capabilities.
    [Tags]    J03    R010    R015    R016    R017    R040    R068    catalog    tamcn    models    requires_login
    Navigate To TAMCN Catalog
    Element Should Be Visible        ${FIND_TAMCN_INPUT}
    Element Should Be Visible        ${CAPACITY_BY_TAMCN_LINK}
    Navigate To Models Catalog
    Element Should Be Visible        ${ADD_MODEL_BUTTON}
    Navigate To Add Model Page
    # Verify Step 21: A model cannot be created without an NSN
    Click Element                    ${ADD_MODEL_SAVE_BUTTON}
    Wait Until Page Contains         Enter the NSN
    Navigate To Model Capabilities Page
    Element Should Be Visible        ${ONLY_UNIT_DIFFERS_CHECKBOX}
