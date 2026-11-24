*** Settings ***
Documentation     J14: Safety, Mishaps & Citations — Mishap reports, investigation, traffic citations, and archiving.
...               Covers R188, R189, R190, R191, R192, R193, R194, R255, R256, R257, R258, R362.
Resource          ../resources/common.resource
Resource          ../resources/pages/login_page.resource
Resource          ../resources/pages/navigation_page.resource
Resource          ../resources/pages/safety_page.resource

Suite Setup       Open Authenticated Safety Session
Suite Teardown    Close Test Browser

*** Keywords ***
Open Authenticated Safety Session
    [Documentation]    Opens the browser, logs in once, dismisses popups, and switches to Mishap manager (SNCO and CO).
    Open Test Browser
    Sign In To GLADM With Env Credentials
    Dismiss Post Login Popups If Present
    Start Test As Position           Mishap manager (SNCO and CO)

*** Test Cases ***
Step 1 To 2: Mishaps List Filters And Search Render
    [Documentation]    J14 Steps 1-2 (R188, R190): Open Mishaps list (/protected/safety/mishaps) and verify
    ...                Status filter, Search box, and Show archived toggle.
    [Tags]    J14    R188    R190    safety    mishaps    requires_login
    Open Mishaps List Page
    Verify Mishaps List Controls

Step 3 To 7: Add A Mishap Form Fields Render
    [Documentation]    J14 Steps 3-7 (R191, R192, R193): Open Add a mishap (/protected/safety/mishaps/new) and verify
    ...                Unit, Date and time, Category, Cause, Incident type, Where it happened, and Grid fields.
    [Tags]    J14    R191    R192    R193    safety    mishaps    form    requires_login
    Open Add Mishap Page
    Verify Add Mishap Form Fields

Step 15 And 18: Citations List Current And Archived Views Work
    [Documentation]    J14 Steps 15 & 18 (R255, R258): Open Citations list (/protected/safety/citations) and switch
    ...                between Current and Archived citations.
    [Tags]    J14    R255    R258    safety    citations    requires_login
    Start Test As Position           Citation manager
    Open Citations List Page
    Verify Citations List Controls
    Switch Citations View            Archived
    Switch Citations View            Current

Step 16: Add A Citation Form Fields Render
    [Documentation]    J14 Step 16 (R256, R257): Open Add a citation (/protected/safety/citations/new) and verify
    ...                Cited person, Citation type, Date of the citation, License number, and Issuing authority POC fields.
    [Tags]    J14    R256    R257    safety    citations    form    requires_login
    Open Add Citation Page
    Verify Add Citation Form Fields
