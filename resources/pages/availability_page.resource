*** Settings ***
Documentation     Page Object for GLADM Availability Updates (J07):
...               5-day availability grid (/protected/records/availability), Personnel and Equipment
...               availability lists & charts, and Driver Availability Report.
Library           SeleniumLibrary
Resource          ../../variables/config.resource

*** Variables ***
${RECORDS_AVAILABILITY_URL}         ${BASE_URL}/protected/records/availability
${PERSONNEL_AVAILABILITY_LIST_URL}    ${BASE_URL}/protected/availability/personnel/list
${EQUIPMENT_AVAILABILITY_LIST_URL}    ${BASE_URL}/protected/availability/equipment/list
${DRIVER_AVAILABILITY_REPORT_URL}   ${BASE_URL}/protected/reports/driver-availability

${AVAILABILITY_HEADING}             xpath=//h1[contains(.,'Availability') or contains(.,'availability')]
${DRIVER_AVAIL_REPORT_HEADING}      xpath=//h1[contains(.,'Driver availability')]

*** Keywords ***
Open Five Day Availability Grid Page
    [Documentation]    Navigates to the 5-day Availability grid (/protected/records/availability).
    Go To    ${RECORDS_AVAILABILITY_URL}
    Wait Until Element Is Visible    ${AVAILABILITY_HEADING}    timeout=${SELENIUM_TIMEOUT}

Open Personnel Availability List Page
    [Documentation]    Navigates to the Personnel availability list (/protected/availability/personnel/list).
    Go To    ${PERSONNEL_AVAILABILITY_LIST_URL}
    Wait Until Element Is Visible    xpath=//h1 | //main    timeout=${SELENIUM_TIMEOUT}

Open Equipment Availability List Page
    [Documentation]    Navigates to the Equipment availability list (/protected/availability/equipment/list).
    Go To    ${EQUIPMENT_AVAILABILITY_LIST_URL}
    Wait Until Element Is Visible    xpath=//h1 | //main    timeout=${SELENIUM_TIMEOUT}

Open Driver Availability Report Page
    [Documentation]    Navigates to the Driver availability report (/protected/reports/driver-availability).
    Go To    ${DRIVER_AVAILABILITY_REPORT_URL}
    Wait Until Element Is Visible    ${DRIVER_AVAIL_REPORT_HEADING}    timeout=${SELENIUM_TIMEOUT}
