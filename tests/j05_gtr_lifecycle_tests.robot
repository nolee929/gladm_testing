*** Settings ***
Documentation     J05: GTR (Ground Transportation Request) Lifecycle & Convoy Review Queue.
...               Covers R080, R083, R092, R093, R094, R096, R097, R098, R101, R108, R111, R112.
Resource          ../resources/common.resource
Resource          ../resources/pages/login_page.resource
Resource          ../resources/pages/navigation_page.resource
Resource          ../resources/pages/requests_page.resource

Suite Setup       Open Authenticated GTR Session
Suite Teardown    Close Test Browser

*** Keywords ***
Open Authenticated GTR Session
    [Documentation]    Opens the browser, logs in once, dismisses popups, and opens Requests.
    Open Test Browser
    Sign In To GLADM With Env Credentials
    Dismiss Post Login Popups If Present
    Navigate To Requests List

*** Test Cases ***
Step 1 To 3: Start New GTR And Fill What And Where Steps
    [Documentation]    J05 Steps 1-3 (R080, R093, R101): Select the GTR tab on Requests, start New GTR,
    ...                complete Step 1 (What) and Step 2 (Where and when), and advance to Convoy.
    [Tags]    J05    R080    R093    R101    gtr    wizard    requires_login
    Navigate To Requests List
    Start New GTR Wizard
    Fill Wizard Step 1 What          poc_name=Sgt Convoy Requester    phone=555-0144
    Fill Wizard Step 2 Where And When
    ...    pickup_loc=Camp Horno
    ...    pickup_grid=11SMS5549493155
    ...    delivery_loc=MCAS Miramar
    ...    delivery_grid=11SMS8720055100
    ...    comments=J05 automated GTR convoy test
    Wait Until Element Is Visible    ${WIZARD_STEP_CONVOY}

Step 4 To 6: Fill Convoy And Route Steps And Save Draft GTR
    [Documentation]    J05 Steps 4-6 (R083, R092, R094, R096, R097, R108, R080): Fill Call Sign, Convoy Number,
    ...                Convoy Classification, and Commander on Step 3, verify Route Segments and Associated Battlespaces
    ...                on Step 4, and save the GTR as a draft on Step 5 (Review).
    [Tags]    J05    R083    R092    R094    R096    R097    R108    gtr    requires_login
    Fill GTR Wizard Step 3 Convoy
    ...    call_sign=DUSTY 6
    ...    convoy_num=CONVOY-D-07
    ...    commander=SSgt Convoy Test
    Verify GTR Wizard Step 4 Route And Advance
    Save TMR As Draft On Review Step
    Open Saved Draft From Wizard
    Page Should Contain              At a glance

Step 10 To 11: Open GTR Review Queue And Verify Battlespace MMCC And FTB Tabs
    [Documentation]    J05 Steps 10-11 (R098, R111, R112): Navigate to the GTR Review queue (/protected/requests/review)
    ...                and verify the Battlespace, MMCC, and FTB tabs and departure-order note.
    [Tags]    J05    R098    R111    R112    gtr_review    requires_login
    Navigate To GTR Review Queue
    Element Should Be Visible        ${GTR_REVIEW_TAB_BATTLESPACE}
    Element Should Be Visible        ${GTR_REVIEW_TAB_MMCC}
    Element Should Be Visible        ${GTR_REVIEW_TAB_FTB}
    Page Should Contain              Sorted by departure, soonest first
    Click Element                    ${GTR_REVIEW_TAB_MMCC}
    Click Element                    ${GTR_REVIEW_TAB_FTB}
