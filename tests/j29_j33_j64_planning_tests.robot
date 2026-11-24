*** Settings ***
Documentation     Lift Planning & Move Planning Test Suite (Journeys J29, J33, and J64):
...               Verifies Plan moves (/protected/plans/new), Recent plans (/protected/plans),
...               Solver comparisons (/protected/plans/comparisons), and Plan the move
...               (/protected/plans/move and /protected/plans/move/new).
Resource          ../resources/common.resource
Resource          ../resources/pages/login_page.resource
Resource          ../resources/pages/navigation_page.resource
Resource          ../resources/pages/planning_page.resource
Suite Setup       Open Authenticated Planning Session
Suite Teardown    Close Test Browser

*** Keywords ***
Open Authenticated Planning Session
    [Documentation]    Opens the browser, logs in once, and dismisses post-login popups.
    Open Test Browser
    Sign In To GLADM With Env Credentials
    Dismiss Post Login Popups If Present

*** Test Cases ***
J29-01 Verify Plan Moves Builder And Recent Plans Load
    [Documentation]    Navigates to Recent plans (/protected/plans) and the Plan moves builder
    ...                (/protected/plans/new) and verifies Moves, Vehicles, Drivers, and A-driver controls.
    [Tags]    j29    planning    plan_moves    requires_login
    Open Recent Plans Page
    Open Plan Moves Page
    Verify Plan Moves Builder Sections

J33-01 Verify Solver Comparisons Page Loads
    [Documentation]    Navigates to Solver comparisons (/protected/plans/comparisons) and verifies
    ...                the solver comparison list and controls.
    [Tags]    j33    planning    solver_compare    requires_login
    Open Solver Comparisons Page

J64-01 Verify Plan The Move List And Builder Pages Load
    [Documentation]    Navigates to the Plan the move Plans list (/protected/plans/move) and builder
    ...                (/protected/plans/move/new) and verifies the step bar or site availability state.
    [Tags]    j64    planning    plan_the_move    requires_login
    Open Plan The Move List Page
    Open Plan The Move Builder Page
