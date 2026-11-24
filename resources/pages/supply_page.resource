*** Settings ***
Documentation     Page Object for GLADM Supply App: LOGSTAT (J18), Bulk Fuel Dashboard (J38),
...               Ammunition Dashboard (J39), and Supply Calculators (J70).
Library           SeleniumLibrary
Resource          ../../variables/config.resource

*** Variables ***
# URLs
${LOGSTAT_URL}                      ${BASE_URL}/protected/logstat
${LOGSTAT_NEW_URL}                  ${BASE_URL}/protected/logstat/new
${LOGSTAT_UPLOAD_URL}               ${BASE_URL}/protected/logstat/upload
${BULK_FUEL_URL}                    ${BASE_URL}/protected/fuel
${BULK_FUEL_COUNT_URL}              ${BASE_URL}/protected/fuel/count
${AMMUNITION_URL}                   ${BASE_URL}/protected/ammunition
${SUPPLY_CALCULATORS_URL}           ${BASE_URL}/protected/utilities/calculators

# LOGSTAT Locators (J18)
${LOGSTAT_HEADING}                  xpath=//h1[normalize-space()='LOGSTAT']
${LOGSTAT_STOCK_SLOT}               css=[data-slot='logstat-stock']
${LOGSTAT_ENTRIES_SLOT}             css=[data-slot='logstat-entries']
${LOGSTAT_CLASSES_SLOT}             css=[data-slot='logstat-classes']
${LOGSTAT_USAGE_SLOT}               css=[data-slot='logstat-usage']
${LOGSTAT_UTILITIES_SLOT}           css=[data-slot='logstat-utilities']
${LOGSTAT_REPORT_BTN}               xpath=//a[normalize-space()='Report LOGSTAT'] | //button[normalize-space()='Report LOGSTAT']
${LOGSTAT_FIND_ITEM_INPUT}          xpath=//input[@placeholder='For example: JP-8, 9130 or Class III']
${LOGSTAT_ADD_ITEM_INPUT}           id=logstat-add-item
${LOGSTAT_GRID_INPUT}               id=logstat-grid
${LOGSTAT_FILE_INPUT}               id=logstat-file

# Bulk Fuel Locators (J38)
${BULK_FUEL_HEADING}                xpath=//h1[normalize-space()='Bulk fuel']
${BULK_FUEL_DASHBOARD}              css=[data-slot='fuel-dashboard']
${BULK_FUEL_SCOPE}                  css=[data-slot='fuel-scope']
${BULK_FUEL_WINDOW}                 css=[data-slot='fuel-window']
${COUNT_FUEL_HEADING}               xpath=//h1[normalize-space()='Count fuel']
${COUNT_FUEL_SLOT}                  css=[data-slot='fuel-count']

# Ammunition Locators (J39)
${AMMUNITION_HEADING}               xpath=//h1[normalize-space()='Ammunition']
${AMMUNITION_DASHBOARD}             css=[data-slot='ammo-dashboard']
${AMMO_BY_DODIC_TAB}                xpath=//button[normalize-space()='By DODIC']
${AMMO_BY_LOCATION_TAB}             xpath=//button[normalize-space()='By location']

# Supply Calculators Locators (J70)
${CALCULATORS_ROOT}                 id=calculators
${CALC_EQUIPMENT_SECTION}           id=calc-equipment
${CALC_VEHICLES_SECTION}            id=calc-vehicles
${CALC_AMMO_LINE}                   css=[data-testid='calc-ammo-line']
${CALC_EQUIPMENT_LINE}              css=[data-testid='calc-equipment-line']
${CALC_VEHICLE_CARD}                css=[data-testid='calc-vehicle']

*** Keywords ***
Open LOGSTAT Page
    [Documentation]    Navigates directly to the LOGSTAT Stock page (/protected/logstat).
    Go To    ${LOGSTAT_URL}
    Wait Until Element Is Visible    ${LOGSTAT_HEADING}    timeout=${SELENIUM_TIMEOUT}

Switch LOGSTAT Tab
    [Documentation]    Clicks a tab in the LOGSTAT views tab bar ('Stock', 'Reports', 'By class of supply', 'Commodity usage').
    [Arguments]    ${tab_name}
    ${tab}=    Set Variable    xpath=//*[@aria-label='LOGSTAT views']//*[normalize-space()='${tab_name}'] | //button[@role='tab' and contains(.,'${tab_name}')]
    Wait Until Element Is Visible    ${tab}    timeout=${SELENIUM_TIMEOUT}
    Click Element    ${tab}

Open Report LOGSTAT Form
    [Documentation]    Navigates to the Report LOGSTAT page (/protected/logstat/new).
    Go To    ${LOGSTAT_NEW_URL}
    Wait Until Page Contains    Report    timeout=${SELENIUM_TIMEOUT}

Open Upload LOGSTAT Spreadsheet Page
    [Documentation]    Navigates to the Upload LOGSTAT spreadsheet page (/protected/logstat/upload).
    Go To    ${LOGSTAT_UPLOAD_URL}
    Wait Until Page Contains    spreadsheet    timeout=${SELENIUM_TIMEOUT}

Open Bulk Fuel Dashboard Page
    [Documentation]    Navigates to the Bulk fuel dashboard (/protected/fuel).
    Go To    ${BULK_FUEL_URL}
    Wait Until Element Is Visible    ${BULK_FUEL_HEADING}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${BULK_FUEL_DASHBOARD}    timeout=${SELENIUM_TIMEOUT}

Open Count Fuel Page
    [Documentation]    Navigates to the Count fuel page (/protected/fuel/count).
    Go To    ${BULK_FUEL_COUNT_URL}
    Wait Until Element Is Visible    ${COUNT_FUEL_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open Ammunition Dashboard Page
    [Documentation]    Navigates to the Ammunition dashboard (/protected/ammunition).
    Go To    ${AMMUNITION_URL}
    Wait Until Element Is Visible    ${AMMUNITION_HEADING}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${AMMUNITION_DASHBOARD}    timeout=${SELENIUM_TIMEOUT}

Open Supply Calculators Page
    [Documentation]    Navigates to the Supply calculators page (/protected/utilities/calculators).
    Go To    ${SUPPLY_CALCULATORS_URL}
    Wait Until Element Is Visible    ${CALCULATORS_ROOT}    timeout=${SELENIUM_TIMEOUT}
