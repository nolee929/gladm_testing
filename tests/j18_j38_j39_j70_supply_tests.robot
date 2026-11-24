*** Settings ***
Documentation     Supply App Test Suite (Journeys J18, J38, J39, and J70):
...               Verifies LOGSTAT stock & reports, Bulk Fuel Dashboard & Count Fuel,
...               Ammunition Dashboard (by DODIC & location), and Supply Calculators.
Resource          ../resources/common.resource
Resource          ../resources/pages/login_page.resource
Resource          ../resources/pages/navigation_page.resource
Resource          ../resources/pages/supply_page.resource
Suite Setup       Open Authenticated Supply Session
Suite Teardown    Close Test Browser

*** Keywords ***
Open Authenticated Supply Session
    [Documentation]    Opens the browser, logs in once, and dismisses post-login popups.
    Open Test Browser
    Sign In To GLADM With Env Credentials
    Dismiss Post Login Popups If Present

*** Test Cases ***
J18-01 Verify LOGSTAT Stock And Views Tabs Load
    [Documentation]    Logs into GLADM, navigates to LOGSTAT (/protected/logstat), and verifies
    ...                the Stock view and LOGSTAT tab navigation ('Stock', 'Reports', 'By class of supply', 'Commodity usage').
    [Tags]    j18    supply    logstat    requires_login
    Open LOGSTAT Page
    Wait Until Element Is Visible    ${LOGSTAT_STOCK_SLOT}    timeout=${SELENIUM_TIMEOUT}
    Switch LOGSTAT Tab    Reports
    Wait Until Element Is Visible    ${LOGSTAT_ENTRIES_SLOT}    timeout=${SELENIUM_TIMEOUT}
    Switch LOGSTAT Tab    By class of supply
    Wait Until Element Is Visible    ${LOGSTAT_CLASSES_SLOT}    timeout=${SELENIUM_TIMEOUT}
    Switch LOGSTAT Tab    Commodity usage
    Wait Until Element Is Visible    ${LOGSTAT_USAGE_SLOT}    timeout=${SELENIUM_TIMEOUT}

J18-02 Verify Report LOGSTAT And Upload Spreadsheet Pages Load
    [Documentation]    Verifies that the Report LOGSTAT (/protected/logstat/new) and Upload LOGSTAT
    ...                spreadsheet (/protected/logstat/upload) forms load cleanly.
    [Tags]    j18    supply    logstat    requires_login
    Open Report LOGSTAT Form
    Open Upload LOGSTAT Spreadsheet Page

J38-01 Verify Bulk Fuel Dashboard And Count Fuel Pages Load
    [Documentation]    Navigates to the Bulk fuel dashboard (/protected/fuel) and Count fuel
    ...                (/protected/fuel/count) and verifies the dashboard slots and headings.
    [Tags]    j38    supply    bulk_fuel    requires_login
    Open Bulk Fuel Dashboard Page
    Element Should Be Visible    ${BULK_FUEL_SCOPE}
    Element Should Be Visible    ${BULK_FUEL_WINDOW}
    Open Count Fuel Page
    Element Should Be Visible    ${COUNT_FUEL_SLOT}

J39-01 Verify Ammunition Dashboard By DODIC And Location Views Load
    [Documentation]    Navigates to the Ammunition dashboard (/protected/ammunition) and verifies
    ...                switching between 'By DODIC' and 'By location' views.
    [Tags]    j39    supply    ammunition    requires_login
    Open Ammunition Dashboard Page
    Element Should Be Visible    ${AMMO_BY_DODIC_TAB}
    Element Should Be Visible    ${AMMO_BY_LOCATION_TAB}
    Click Element                ${AMMO_BY_LOCATION_TAB}

J70-01 Verify Supply Calculators Page And Sections Load
    [Documentation]    Navigates to Supply calculators (/protected/utilities/calculators) and verifies
    ...                the Equipment, Vehicles, and Commodity calculation sections.
    [Tags]    j70    supply    calculators    requires_login
    Open Supply Calculators Page
    Wait Until Element Is Visible    ${CALC_EQUIPMENT_SECTION}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${CALC_VEHICLES_SECTION}     timeout=${SELENIUM_TIMEOUT}
