*** Settings ***
Documentation     J08: Dispatch and the Master Log — Daily Master Log, Trip Tickets, Search, and Supervisor Review.
...               Covers R002, R003, R004, R005, R006, R008, R009, R207, R233, R236, R242, R249, R259, R260, R352, R353, R356.
Resource          ../resources/common.resource
Resource          ../resources/pages/login_page.resource
Resource          ../resources/pages/navigation_page.resource
Resource          ../resources/pages/dispatch_page.resource

Suite Setup       Open Authenticated Dispatch Session
Suite Teardown    Close Test Browser

*** Keywords ***
Open Authenticated Dispatch Session
    [Documentation]    Opens the browser, logs in once, dismisses popups, and switches to Unit supervisor (S-4).
    Open Test Browser
    Sign In To GLADM With Env Credentials
    Dismiss Post Login Popups If Present
    Start Test As Position           Unit supervisor (S-4)

*** Test Cases ***
Step 4 And 12: Open Daily Master Log And Verify This Day Menu
    [Documentation]    J08 Steps 4 & 12 (R004, R005, R207, R236, R249): Open Transport › Dispatch & Master Log › Daily Master Log,
    ...                verify the day picker and action buttons, and open 'This day' to verify Export/Print/History/Review options.
    [Tags]    J08    R004    R005    R207    R236    R249    dispatch    master_log    requires_login
    Navigate To Daily Master Log
    Element Should Be Visible        ${DISPATCH_DAY_INPUT}
    Element Should Be Visible        ${THIS_DAY_MENU_BUTTON}
    Element Should Be Visible        ${BLANK_FORMS_MENU_BUTTON}
    Open This Day Menu On Master Log
    Element Should Be Visible        ${THIS_DAY_EXPORT_EXCEL}
    Element Should Be Visible        ${THIS_DAY_EXPORT_PDF}
    Element Should Be Visible        ${THIS_DAY_HISTORY}
    Element Should Be Visible        ${THIS_DAY_REVIEW_WEEK}
    Element Should Be Visible        ${THIS_DAY_SEARCH_OTHER_DAYS}

Step 11: Open Trip Tickets Page And Verify NAVMC 10627 Subtitle
    [Documentation]    J08 Step 11 (R207): Open Trip Tickets (/protected/dispatch/trip-tickets) and verify the
    ...                NAVMC 10627 / 10523 trip ticket generator page loads.
    [Tags]    J08    R207    dispatch    trip_tickets    requires_login
    Navigate To Trip Tickets Page

Step 13 To 17: Open Search Master Log And Verify Entries Filters And History Tab
    [Documentation]    J08 Steps 13-17 (R004, R008, R009, R233, R242, R249, R259): Open Search Master Log (/protected/dispatch/log),
    ...                verify Entries, Review, and History tabs, From/To date filters, and More filters.
    [Tags]    J08    R004    R008    R009    R242    R249    R259    dispatch    search    requires_login
    Navigate To Search Master Log
    Element Should Be Visible        ${MASTER_LOG_TAB_ENTRIES}
    Element Should Be Visible        ${MASTER_LOG_TAB_REVIEW}
    Element Should Be Visible        ${MASTER_LOG_TAB_HISTORY}
    Element Should Be Visible        ${LOG_FROM_DATE_INPUT}
    Element Should Be Visible        ${LOG_TO_DATE_INPUT}
    Element Should Be Visible        ${LOG_MORE_FILTERS_BUTTON}
    Click Element                    ${LOG_MORE_FILTERS_BUTTON}
    Wait Until Page Contains         Driver or A-driver
    Click Element                    ${MASTER_LOG_TAB_HISTORY}
    Wait Until Element Is Visible    id:history-day    timeout=15s

Step 18 And 20: Verify Master Log Supervisor Review And Override View
    [Documentation]    J08 Steps 18 & 20 (R006, R352, R353, R356): Open the Master Log Review tab and Master Log Override
    ...                view, and verify the Override filter banner ('Override: days waiting for review in your unit and its sub-units.').
    [Tags]    J08    R006    R352    R353    R356    dispatch    review    override    requires_login
    Navigate To Master Log Review Tab
    Element Should Be Visible        ${REVIEW_FROM_DATE_INPUT}
    Element Should Be Visible        ${REVIEW_TO_DATE_INPUT}
    Navigate To Master Log Override
    Page Should Contain              days waiting for review in your unit and its sub-units
