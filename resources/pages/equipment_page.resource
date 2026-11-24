*** Settings ***
Documentation     Page Object Model for GLADM Equipment, Vehicle Profiles, TAMCNs, and Models Catalog (J03).
Library           SeleniumLibrary
Resource          ../../variables/config.resource

*** Variables ***
# Equipment List & Filters (J03 Steps 1-3, 12-13)
${EQUIPMENT_HEADING}                xpath://h1[normalize-space()='Equipment']
${ADD_VEHICLE_BUTTON}               xpath://a[contains(., 'Add vehicle')] | //button[contains(., 'Add vehicle')]
${REMOVED_EQUIPMENT_LINK}           xpath://a[normalize-space()='Removed equipment']
${EQUIPMENT_SEARCH_INPUT}           xpath://form[@role='search']//input | //input[@type='search']
${EQUIPMENT_SEARCH_BUTTON}          xpath://form[@role='search']//button[@type='submit'] | //button[normalize-space()='Search']
${EQUIPMENT_MORE_FILTERS_BUTTON}    xpath://button[starts-with(normalize-space(), 'More filters')]
${EQUIPMENT_CLEAR_FILTERS_BUTTON}   xpath://button[normalize-space()='Clear filters']
${EQUIPMENT_SHOW_REMOVED_CHECKBOX}  xpath://label[contains(., 'Show removed')]
${EQUIPMENT_EXPORT_BUTTON}          xpath://button[normalize-space()='Export']

# Add Vehicle Form (J03 Steps 8-9)
${ADD_VEHICLE_HEADING}              xpath://h1[normalize-space()='Add a vehicle']
${NEW_VEHICLE_MODEL_INPUT}          xpath://input[@id='new-vehicle-model' or @id='new-vehicle-model-input'] | //label[contains(., 'Model')]/following::input[1]
${NEW_VEHICLE_SERIAL_INPUT}         id:new-vehicle-serialNumber
${NEW_VEHICLE_PLATE_INPUT}          id:new-vehicle-licensePlate
${NEW_VEHICLE_RFID_INPUT}           id:new-vehicle-rfid
${NEW_VEHICLE_RADIO_INPUT}          id:new-vehicle-radioSerialNumber
${NEW_VEHICLE_TRACKER_INPUT}        id:new-vehicle-trackUid
${ADD_VEHICLE_SUBMIT_BUTTON}        xpath://button[@type='submit' and normalize-space()='Add vehicle']
${ADD_AND_START_ANOTHER_BUTTON}     xpath://button[normalize-space()='Add and start another']

# Vehicle Profile & 7 Tabs (J03 Steps 4-7, 10-11)
${VEHICLE_TAB_PROFILE}              xpath://*[@role='tab'][normalize-space()='Profile']
${VEHICLE_TAB_CAPABILITIES}         xpath://*[@role='tab'][normalize-space()='Capabilities']
${VEHICLE_TAB_AVAILABILITY}         xpath://*[@role='tab'][normalize-space()='Availability']
${VEHICLE_TAB_GCSS}                 xpath://*[@role='tab'][contains(normalize-space(), 'Service requests')]
${VEHICLE_TAB_CBM}                  xpath://*[@role='tab'][contains(normalize-space(), 'Condition alerts')]
${VEHICLE_TAB_PAIRING}              xpath://*[@role='tab'][normalize-space()='Pairing']
${VEHICLE_TAB_HISTORY}              xpath://*[@role='tab'][normalize-space()='History']
${VEHICLE_EDIT_BUTTON}              xpath://button[normalize-space()='Edit']
${VEHICLE_REMOVE_BUTTON}            xpath://button[normalize-space()='Remove']

# Catalog: TAMCNs, Models, Model Capabilities, VMCs (J03 Steps 18-25, 28)
${TAMCNS_HEADING}                   xpath://h1[normalize-space()='TAMCNs']
${FIND_TAMCN_INPUT}                 xpath://div[@role='search' and @aria-label='TAMCNs']//input | //label[contains(., 'Find a TAMCN')]/following::input[1]
${CAPACITY_BY_TAMCN_LINK}           xpath://a[contains(normalize-space(), 'In your unit (capacity by TAMCN)')]
${MODELS_HEADING}                   xpath://h1[normalize-space()='Models']
${ADD_MODEL_BUTTON}                 xpath://a[contains(., 'Add a model')] | //button[contains(., 'Add a model')]
${ADD_MODEL_HEADING}                xpath://h1[normalize-space()='Add a model']
${ADD_MODEL_SAVE_BUTTON}            xpath://button[@type='submit' and normalize-space()='Add'] | //button[normalize-space()='Add']
${MODEL_CAPABILITIES_HEADING}       xpath://h1[normalize-space()='Model capabilities']
${ONLY_UNIT_DIFFERS_CHECKBOX}       xpath://label[contains(., 'Only where your unit differs from the system')]
${VMC_HEADING}                      xpath://h1[normalize-space()='Valid model combinations']
${VMC_READ_ONLY_NOTE}               css:[data-testid="vmc-read-only"]

*** Keywords ***
Navigate To Equipment List
    [Documentation]    Navigates directly to the Equipment list (/sgen-tcp/protected/records/equipment) and waits for the heading (J03 Step 1).
    Go To                            ${BASE_URL}/sgen-tcp/protected/records/equipment
    Wait Until Element Is Visible    ${EQUIPMENT_HEADING}    timeout=20s

Open First Vehicle From Equipment List
    [Documentation]    Clicks the first vehicle serial link in the Equipment list table and waits for the 7 profile tabs (J03 Step 4).
    ${first_vehicle}=                Set Variable    xpath:(//table//tbody//tr[1]//a)[1] | (//a[contains(@href, '/protected/records/equipment/') and not(contains(@href, '/new')) and not(contains(@href, '/removed'))])[1]
    Wait Until Element Is Visible    ${first_vehicle}    timeout=15s
    Click Element                    ${first_vehicle}
    Wait Until Element Is Visible    ${VEHICLE_TAB_PROFILE}    timeout=15s

Verify All Seven Vehicle Profile Tabs
    [Documentation]    Verifies that all 7 tabs on a vehicle profile page are visible and switches through Capabilities, GCSS, Pairing, and History (J03 Steps 4-6, 10).
    Element Should Be Visible        ${VEHICLE_TAB_PROFILE}
    Element Should Be Visible        ${VEHICLE_TAB_CAPABILITIES}
    Element Should Be Visible        ${VEHICLE_TAB_AVAILABILITY}
    Element Should Be Visible        ${VEHICLE_TAB_GCSS}
    Element Should Be Visible        ${VEHICLE_TAB_CBM}
    Element Should Be Visible        ${VEHICLE_TAB_PAIRING}
    Element Should Be Visible        ${VEHICLE_TAB_HISTORY}
    Click Element                    ${VEHICLE_TAB_CAPABILITIES}
    Wait Until Page Contains         What it can carry
    Click Element                    ${VEHICLE_TAB_GCSS}
    Wait Until Page Contains         GCSS
    Click Element                    ${VEHICLE_TAB_PAIRING}
    Wait Until Page Contains         prime mover
    Click Element                    ${VEHICLE_TAB_PROFILE}

Navigate To TAMCN Catalog
    [Documentation]    Opens Equipment › Catalog › TAMCNs (/sgen-tcp/protected/records/catalog/tamcns) (J03 Step 18, Step 35).
    Go To                            ${BASE_URL}/sgen-tcp/protected/records/catalog/tamcns
    Wait Until Element Is Visible    ${TAMCNS_HEADING}    timeout=20s

Navigate To Models Catalog
    [Documentation]    Opens Equipment › Catalog › Models (/sgen-tcp/protected/records/catalog/models) (J03 Step 19).
    Go To                            ${BASE_URL}/sgen-tcp/protected/records/catalog/models
    Wait Until Element Is Visible    ${MODELS_HEADING}    timeout=20s

Navigate To Add Model Page
    [Documentation]    Opens the Add a model page (/sgen-tcp/protected/records/catalog/models/new) (J03 Step 21).
    Go To                            ${BASE_URL}/sgen-tcp/protected/records/catalog/models/new
    Wait Until Element Is Visible    ${ADD_MODEL_HEADING}    timeout=20s

Navigate To Model Capabilities Page
    [Documentation]    Opens Equipment › Catalog › Model capabilities (/sgen-tcp/protected/equipment/modelCapabilitiesManager) (J03 Step 25).
    Go To                            ${BASE_URL}/sgen-tcp/protected/equipment/modelCapabilitiesManager
    Wait Until Element Is Visible    ${MODEL_CAPABILITIES_HEADING}    timeout=20s
