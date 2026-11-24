*** Settings ***
Documentation     Page Object Model for GLADM Dispatch, Daily Master Log, Trip Tickets, and Master Log Review (J08).
Library           SeleniumLibrary
Resource          ../../variables/config.resource

*** Variables ***
# Daily Master Log Board (J08 Steps 3-6, 9b, 12)
${DAILY_MASTER_LOG_HEADING}         xpath://h1[normalize-space()='Daily Master Log']
${DISPATCH_DAY_INPUT}               id:dispatch-day
${DISPATCH_A_MISSION_BUTTON}        xpath://button[contains(., 'Dispatch a mission')]
${TRIP_NUMBERS_MENU_BUTTON}         xpath://button[contains(., 'Trip numbers')]
${THIS_DAY_MENU_BUTTON}             xpath://button[contains(., 'This day')]
${BLANK_FORMS_MENU_BUTTON}          xpath://button[contains(., 'Blank forms')]
${THIS_DAY_EXPORT_EXCEL}            xpath://*[@role='menuitem'][normalize-space()='Export to Excel']
${THIS_DAY_EXPORT_PDF}              xpath://*[@role='menuitem'][normalize-space()='Export to PDF']
${THIS_DAY_HISTORY}                 xpath://*[@role='menuitem'][normalize-space()='History of this day']
${THIS_DAY_REVIEW_WEEK}             xpath://*[@role='menuitem'][contains(normalize-space(), 'Review this week')]
${THIS_DAY_SEARCH_OTHER_DAYS}       xpath://*[@role='menuitem'][normalize-space()='Search other days']

# Trip Tickets Page (J08 Step 11)
${TRIP_TICKETS_HEADING}             xpath://h1[normalize-space()='Trip tickets']
${TRIP_TICKETS_SUBTITLE}            xpath://p[contains(., 'NAVMC 10627')]

# Search Master Log, History & Supervisor Review (J08 Steps 13-20)
${MASTER_LOG_HEADING}               xpath://h1[normalize-space()='Master log']
${MASTER_LOG_TAB_ENTRIES}           xpath://*[@role='tab'][normalize-space()='Entries']
${MASTER_LOG_TAB_REVIEW}            xpath://*[@role='tab'][normalize-space()='Review']
${MASTER_LOG_TAB_HISTORY}           xpath://*[@role='tab'][normalize-space()='History']
${LOG_FROM_DATE_INPUT}              id:log-from
${LOG_TO_DATE_INPUT}                id:log-to
${LOG_MORE_FILTERS_BUTTON}          xpath://button[starts-with(normalize-space(), 'More filters')]
${LOG_SEARCH_SUBMIT_BUTTON}         xpath://button[@type='submit' and normalize-space()='Search'] | //button[normalize-space()='Search']
${REVIEW_FROM_DATE_INPUT}           id:review-from
${REVIEW_TO_DATE_INPUT}             id:review-to
${REVIEW_OVERRIDE_BANNER}           css:[data-slot="review-override"]

*** Keywords ***
Navigate To Daily Master Log
    [Documentation]    Navigates directly to the Daily Master Log board (/sgen-tcp/protected/dispatch) and waits for the heading (J08 Step 4).
    Go To                            ${BASE_URL}/sgen-tcp/protected/dispatch
    Wait Until Element Is Visible    ${DAILY_MASTER_LOG_HEADING}    timeout=20s

Open This Day Menu On Master Log
    [Documentation]    Opens the 'This day' dropdown menu on the Daily Master Log board (J08 Step 12).
    Wait Until Element Is Visible    ${THIS_DAY_MENU_BUTTON}
    Click Element                    ${THIS_DAY_MENU_BUTTON}
    Wait Until Element Is Visible    ${THIS_DAY_EXPORT_EXCEL}

Navigate To Trip Tickets Page
    [Documentation]    Navigates directly to the Trip Tickets page (/sgen-tcp/protected/dispatch/trip-tickets) (J08 Step 11).
    Go To                            ${BASE_URL}/sgen-tcp/protected/dispatch/trip-tickets
    Wait Until Element Is Visible    ${TRIP_TICKETS_HEADING}    timeout=20s
    Element Should Be Visible        ${TRIP_TICKETS_SUBTITLE}

Navigate To Search Master Log
    [Documentation]    Navigates directly to Search Master Log (/sgen-tcp/protected/dispatch/log) on the Entries tab (J08 Step 13).
    Go To                            ${BASE_URL}/sgen-tcp/protected/dispatch/log
    Wait Until Element Is Visible    ${MASTER_LOG_HEADING}    timeout=20s

Navigate To Master Log Review Tab
    [Documentation]    Opens Search Master Log on the Review tab (/sgen-tcp/protected/dispatch/log?tab=review) (J08 Step 18).
    Go To                            ${BASE_URL}/sgen-tcp/protected/dispatch/log?tab=review
    Wait Until Element Is Visible    ${MASTER_LOG_HEADING}    timeout=20s
    Wait Until Element Is Visible    ${REVIEW_FROM_DATE_INPUT}    timeout=15s

Navigate To Master Log Override
    [Documentation]    Opens Master Log Override (/sgen-tcp/protected/dispatch/log?tab=review&review=unreviewed&subUnits=1) and verifies the Override banner (J08 Step 20).
    Go To                            ${BASE_URL}/sgen-tcp/protected/dispatch/log?tab=review&review=unreviewed&subUnits=1
    Wait Until Element Is Visible    ${MASTER_LOG_HEADING}    timeout=20s
    Wait Until Element Is Visible    ${REVIEW_OVERRIDE_BANNER}    timeout=15s
