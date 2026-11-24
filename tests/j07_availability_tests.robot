*** Settings ***
Documentation     Availability Updates Test Suite (Journey J07):
...               Verifies the 5-day Availability grid (/protected/records/availability),
...               Personnel and Equipment availability lists, and the Driver availability report
...               (/protected/reports/driver-availability).
Resource          ../resources/common.resource
Resource          ../resources/pages/login_page.resource
Resource          ../resources/pages/navigation_page.resource
Resource          ../resources/pages/availability_page.resource
Suite Setup       Open Authenticated Availability Session
Suite Teardown    Close Test Browser

*** Keywords ***
Open Authenticated Availability Session
    [Documentation]    Opens the browser, logs in once, dismisses popups, and switches to Unit supervisor (S-4).
    Open Test Browser
    Sign In To GLADM With Env Credentials
    Dismiss Post Login Popups If Present
    Start Test As Position           Unit supervisor (S-4)

*** Test Cases ***
J07-01 Verify Five Day Availability Grid Loads
    [Documentation]    Navigates to the 5-day Availability grid (/protected/records/availability) and verifies
    ...                the Availability heading and grid view.
    [Tags]    j07    availability    grid    requires_login
    Open Five Day Availability Grid Page

J07-02 Verify Personnel And Equipment Availability Lists Load
    [Documentation]    Navigates to the Personnel (/protected/availability/personnel/list) and Equipment
    ...                (/protected/availability/equipment/list) availability manager lists.
    [Tags]    j07    availability    managers    requires_login
    Open Personnel Availability List Page
    Open Equipment Availability List Page

J07-03 Verify Driver Availability Report Loads
    [Documentation]    Navigates to the Driver availability report (/protected/reports/driver-availability)
    ...                and verifies the report heading.
    [Tags]    j07    availability    reports    requires_login
    Open Driver Availability Report Page
