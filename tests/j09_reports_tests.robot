*** Settings ***
Documentation     J09: Reports & Exports — Report library, transportation, equipment, driver, and data summary reports.
...               Covers R147, R176, R231, R232, R234, R264, R266, R287, R288, R289, R349, R350, R359, R367, R371, R372, R373, R374, R443.
Resource          ../resources/common.resource
Resource          ../resources/pages/login_page.resource
Resource          ../resources/pages/navigation_page.resource
Resource          ../resources/pages/reports_page.resource

Suite Setup       Open Authenticated Reports Session
Suite Teardown    Close Test Browser

*** Keywords ***
Open Authenticated Reports Session
    [Documentation]    Opens the browser, logs in once, dismisses popups, and switches to Unit supervisor (S-4).
    Open Test Browser
    Sign In To GLADM With Env Credentials
    Dismiss Post Login Popups If Present
    Start Test As Position           Unit supervisor (S-4)

*** Test Cases ***
Step 1 To 3: Report Library Categories And Search Filter Work
    [Documentation]    J09 Steps 1-3: Open the Report library (/protected/reports), verify Transportation, Equipment,
    ...                and Personnel categories render, and filter reports via 'Find a report'.
    [Tags]    J09    reports    library    requires_login
    Open Report Library Page
    Verify Report Library Categories And Search
    Filter Report Library By Keyword    license
    Open Report Library Page

Step 4 To 9: Comptroller And Cargo Reports Render
    [Documentation]    J09 Steps 4-9 (R231, R232, R234): Open Comptroller report, Cargo by class of supply,
    ...                Unit cargo, fuel and mileage, and Vehicle cargo, fuel and mileage reports.
    [Tags]    J09    R231    R232    R234    reports    transportation    cargo    requires_login
    Open Comptroller Report Page
    Page Should Contain    Comptroller report
    Open Cargo By Class Report Page
    Page Should Contain    Cargo by class of supply
    Open Unit Cargo Fuel Mileage Report Page
    Page Should Contain    Unit cargo, fuel and mileage
    Open Vehicle Cargo Fuel Mileage Report Page
    Page Should Contain    Vehicle cargo, fuel and mileage

Step 10 To 13: Equipment Availability Utilization And GCSS Reports Render
    [Documentation]    J09 Steps 10-13 (R266, R287): Open Equipment availability, Equipment utilization,
    ...                and GCSS report (operational status and time codes).
    [Tags]    J09    R266    R287    reports    equipment    gcss    requires_login
    Open Equipment Availability Report Page
    Page Should Contain    Equipment availability
    Open Equipment Utilization Report Page
    Page Should Contain    Equipment utilization
    Open GCSS Report Page
    Page Should Contain    GCSS report

Step 19 To 21: Individual Operator Rollup And Driver Log Reports Render
    [Documentation]    J09 Steps 19-21 (R264, R288, R289, R367, R371, R372): Open Individual operator rollup
    ...                and Driver log reports and verify their headings and filter controls.
    [Tags]    J09    R264    R288    R289    R367    R371    R372    reports    drivers    requires_login
    Open Individual Operator Rollup Page
    Page Should Contain    Individual operator rollup
    Open Driver Log Report Page
    Page Should Contain    Driver log

Step 22 To 24: Run Roster Master Log Dispatch And Data Summary Render
    [Documentation]    J09 Steps 22-24 (R147, R373, R374, R443): Open Run roster, Master Log dispatch report,
    ...                and Unit Data summary pages.
    [Tags]    J09    R147    R373    R374    R443    reports    run_roster    data_summary    requires_login
    Open Run Roster Report Page
    Page Should Contain    Run roster
    Open Master Log Dispatch Report Page
    Page Should Contain    Master Log dispatch report
    Open Data Summary Report Page
    Page Should Contain    Data summary
