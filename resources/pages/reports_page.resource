*** Settings ***
Documentation     Page Object for GLADM Reports & Exports (J09):
...               Report library (/protected/reports), Transportation reports (Comptroller,
...               Cargo by class, Run roster, Master Log dispatch), Equipment reports
...               (Equipment availability, Equipment utilization, GCSS report, Unit/Vehicle
...               cargo, fuel and mileage), Personnel/License reports (Driver availability,
...               Driver log, Individual operator, Individual operator rollup, Unit license,
...               Personnel license, Expired licenses), and Activity & Data summary.
Library           SeleniumLibrary
Resource          ../../variables/config.resource

*** Variables ***
# URLs
${REPORTS_LIBRARY_URL}              ${BASE_URL}/protected/reports
${REPORT_COMPTROLLER_URL}           ${BASE_URL}/protected/reports/comptroller
${REPORT_CARGO_BY_CLASS_URL}        ${BASE_URL}/protected/reports/cargo-by-class
${REPORT_UNIT_CARGO_URL}            ${BASE_URL}/protected/reports/unit-cargo-fuel-mileage
${REPORT_VEHICLE_CARGO_URL}         ${BASE_URL}/protected/reports/vehicle-cargo-fuel-mileage
${REPORT_EQUIP_AVAIL_URL}           ${BASE_URL}/protected/reports/equipment-availability
${REPORT_EQUIP_UTIL_URL}            ${BASE_URL}/protected/reports/equipment-utilization
${REPORT_GCSS_URL}                  ${BASE_URL}/protected/reports/gcss
${REPORT_DRIVER_AVAIL_URL}          ${BASE_URL}/protected/reports/driver-availability
${REPORT_DRIVER_LOG_URL}            ${BASE_URL}/protected/reports/driver-log
${REPORT_INDIV_OPERATOR_URL}        ${BASE_URL}/protected/reports/individual-operator
${REPORT_INDIV_ROLLUP_URL}          ${BASE_URL}/protected/reports/individual-rollup
${REPORT_UNIT_LICENSE_URL}          ${BASE_URL}/protected/reports/unit-license
${REPORT_PERSONNEL_LICENSE_URL}     ${BASE_URL}/protected/reports/personnel-license
${REPORT_EXPIRED_LICENSES_URL}      ${BASE_URL}/protected/reports/expired-licenses
${REPORT_RUN_ROSTER_URL}            ${BASE_URL}/protected/reports/run-roster
${REPORT_MASTER_LOG_DISPATCH_URL}   ${BASE_URL}/protected/reports/master-log-dispatch
${REPORT_DATA_SUMMARY_URL}          ${BASE_URL}/protected/reports/data-summary

# Report Library Locators
${REPORT_LIBRARY_HEADING}           xpath=//h1[normalize-space()='Report library']
${FIND_REPORT_INPUT}                xpath=//label[contains(.,'Find a report')]/following::input[1]
${RECENTLY_OPENED_HEADING}          xpath=//h2[normalize-space()='Recently opened']

# Common Report Controls
${REPORT_UNIT_SELECT}               xpath=//label[normalize-space()='Unit']/following::select[1]
${REPORT_INCLUDE_SUBUNITS_CHECK}    xpath=//label[contains(.,'Include sub-units')]/preceding::input[@type='checkbox'][1] | //label[contains(.,'Include sub-units')]//input[@type='checkbox']
${REPORT_EXPORT_BTN}                xpath=//button[contains(.,'Export')]
${REPORT_CUSTOM_DATES_BTN}          xpath=//button[normalize-space()='Custom dates']
${REPORT_LAST_30_DAYS_BTN}          xpath=//button[normalize-space()='Last 30 days']

# Report Headings
${COMPTROLLER_HEADING}              xpath=//h1[normalize-space()='Comptroller report']
${CARGO_BY_CLASS_HEADING}           xpath=//h1[normalize-space()='Cargo by class of supply']
${UNIT_CARGO_HEADING}               xpath=//h1[normalize-space()='Unit cargo, fuel and mileage']
${VEHICLE_CARGO_HEADING}            xpath=//h1[normalize-space()='Vehicle cargo, fuel and mileage']
${EQUIP_AVAIL_HEADING}              xpath=//h1[normalize-space()='Equipment availability']
${EQUIP_UTIL_HEADING}               xpath=//h1[normalize-space()='Equipment utilization']
${GCSS_REPORT_HEADING}              xpath=//h1[normalize-space()='GCSS report']
${DRIVER_AVAIL_HEADING}             xpath=//h1[normalize-space()='Driver availability']
${DRIVER_LOG_HEADING}               xpath=//h1[normalize-space()='Driver log']
${INDIV_OPERATOR_HEADING}           xpath=//h1[normalize-space()='Individual operator report']
${INDIV_ROLLUP_HEADING}             xpath=//h1[normalize-space()='Individual operator rollup']
${RUN_ROSTER_HEADING}               xpath=//h1[normalize-space()='Run roster']
${MASTER_LOG_DISPATCH_HEADING}      xpath=//h1[normalize-space()='Master Log dispatch report']
${DATA_SUMMARY_HEADING}             xpath=//h1[normalize-space()='Data summary']

*** Keywords ***
Open Report Library Page
    [Documentation]    Navigates directly to the Report Library (/protected/reports).
    Go To    ${REPORTS_LIBRARY_URL}
    Wait Until Element Is Visible    ${REPORT_LIBRARY_HEADING}    timeout=${SELENIUM_TIMEOUT}

Verify Report Library Categories And Search
    [Documentation]    Verifies the Report Library displays category sections and filters reports via Find a report.
    Wait Until Element Is Visible    ${REPORT_LIBRARY_HEADING}    timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${FIND_REPORT_INPUT}    timeout=${SELENIUM_TIMEOUT}
    Page Should Contain    Transportation
    Page Should Contain    Equipment
    Page Should Contain    Personnel

Filter Report Library By Keyword
    [Documentation]    Types a keyword into 'Find a report' and verifies the filtered match count appears.
    [Arguments]    ${keyword}
    Wait Until Element Is Visible    ${FIND_REPORT_INPUT}    timeout=${SELENIUM_TIMEOUT}
    Clear Element Text    ${FIND_REPORT_INPUT}
    Input Text    ${FIND_REPORT_INPUT}    ${keyword}
    Wait Until Page Contains    match    timeout=${SELENIUM_TIMEOUT}

Open Report From Library
    [Documentation]    Clicks a report card by its title in the Report Library.
    [Arguments]    ${report_title}
    ${card}=    Set Variable    xpath=//a[.//span[normalize-space()='${report_title}']]
    Wait Until Element Is Visible    ${card}    timeout=${SELENIUM_TIMEOUT}
    Click Element    ${card}

Open Comptroller Report Page
    [Documentation]    Navigates to the Comptroller report (/protected/reports/comptroller).
    Go To    ${REPORT_COMPTROLLER_URL}
    Wait Until Element Is Visible    ${COMPTROLLER_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open Cargo By Class Report Page
    [Documentation]    Navigates to the Cargo by class of supply report (/protected/reports/cargo-by-class).
    Go To    ${REPORT_CARGO_BY_CLASS_URL}
    Wait Until Element Is Visible    ${CARGO_BY_CLASS_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open Unit Cargo Fuel Mileage Report Page
    [Documentation]    Navigates to the Unit cargo, fuel and mileage report (/protected/reports/unit-cargo-fuel-mileage).
    Go To    ${REPORT_UNIT_CARGO_URL}
    Wait Until Element Is Visible    ${UNIT_CARGO_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open Vehicle Cargo Fuel Mileage Report Page
    [Documentation]    Navigates to the Vehicle cargo, fuel and mileage report (/protected/reports/vehicle-cargo-fuel-mileage).
    Go To    ${REPORT_VEHICLE_CARGO_URL}
    Wait Until Element Is Visible    ${VEHICLE_CARGO_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open Equipment Availability Report Page
    [Documentation]    Navigates to the Equipment availability report (/protected/reports/equipment-availability).
    Go To    ${REPORT_EQUIP_AVAIL_URL}
    Wait Until Element Is Visible    ${EQUIP_AVAIL_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open Equipment Utilization Report Page
    [Documentation]    Navigates to the Equipment utilization report (/protected/reports/equipment-utilization).
    Go To    ${REPORT_EQUIP_UTIL_URL}
    Wait Until Element Is Visible    ${EQUIP_UTIL_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open GCSS Report Page
    [Documentation]    Navigates to the GCSS report (/protected/reports/gcss).
    Go To    ${REPORT_GCSS_URL}
    Wait Until Element Is Visible    ${GCSS_REPORT_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open Driver Log Report Page
    [Documentation]    Navigates to the Driver log report (/protected/reports/driver-log).
    Go To    ${REPORT_DRIVER_LOG_URL}
    Wait Until Element Is Visible    ${DRIVER_LOG_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open Individual Operator Rollup Page
    [Documentation]    Navigates to the Individual operator rollup report (/protected/reports/individual-rollup).
    Go To    ${REPORT_INDIV_ROLLUP_URL}
    Wait Until Element Is Visible    ${INDIV_ROLLUP_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open Run Roster Report Page
    [Documentation]    Navigates to the Run roster report (/protected/reports/run-roster).
    Go To    ${REPORT_RUN_ROSTER_URL}
    Wait Until Element Is Visible    ${RUN_ROSTER_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open Master Log Dispatch Report Page
    [Documentation]    Navigates to the Master Log dispatch report (/protected/reports/master-log-dispatch).
    Go To    ${REPORT_MASTER_LOG_DISPATCH_URL}
    Wait Until Element Is Visible    ${MASTER_LOG_DISPATCH_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open Data Summary Report Page
    [Documentation]    Navigates to the Unit Data summary report (/protected/reports/data-summary).
    Go To    ${REPORT_DATA_SUMMARY_URL}
    Wait Until Element Is Visible    ${DATA_SUMMARY_HEADING}    timeout=${SELENIUM_TIMEOUT}
