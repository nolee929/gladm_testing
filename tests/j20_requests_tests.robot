*** Settings ***
Documentation     J20: New to GLADM — Asking for Transport with Requests.
...               Covers Requests list navigation, bins, search, More filters, quick look,
...               and the 5-step New TMR wizard (What, Where and when, Cargo, Funding, Review).
Resource          ../resources/common.resource
Resource          ../resources/pages/login_page.resource
Resource          ../resources/pages/navigation_page.resource
Resource          ../resources/pages/requests_page.resource

Suite Setup       Open Authenticated Requests Session
Suite Teardown    Close Test Browser

*** Keywords ***
Open Authenticated Requests Session
    [Documentation]    Opens the browser, logs in once, dismisses popups, and navigates to Requests.
    Open Test Browser
    Sign In To GLADM With Env Credentials
    Dismiss Post Login Popups If Present
    Navigate To Requests List

*** Test Cases ***
Step 3 To 6: Open Requests List And Verify Bins
    [Documentation]    J20 Steps 3-6: Verify Requests list loads with type tabs and workflow stage bins
    ...                (Inbox, Draft, Submitted, Supporting, Forwarded, Declined, Change Request, Archive, All).
    [Tags]    J20    requests    bins    requires_login
    Navigate To Requests List
    Element Should Be Visible        ${BIN_INBOX}
    Element Should Be Visible        ${BIN_DRAFT}
    Element Should Be Visible        ${BIN_SUBMITTED}
    Element Should Be Visible        ${BIN_SUPPORTING}
    Element Should Be Visible        ${BIN_ARCHIVE}
    Element Should Be Visible        ${BIN_ALL}

Step 7: Narrow List With Search And More Filters
    [Documentation]    J20 Step 7: Verify switching bins, opening the More filters drawer, and filtering.
    [Tags]    J20    requests    filters    requires_login
    Select Request Bin               All
    Open More Filters Panel
    Page Should Contain              Delivery from
    Page Should Contain              Delivery to
    # Close More filters drawer with Escape
    Press Keys                       NONE    ESCAPE

Step 13 To 17: Start New TMR And Validate Phone Check On What Step
    [Documentation]    J20 Steps 13-17: Start a New TMR, verify invalid phone with letters blocks Next,
    ...                then enter a valid phone number and advance to Where and when.
    [Tags]    J20    tmr    wizard    validation    requires_login
    Navigate To Requests List
    Start New TMR Wizard
    Wait Until Element Is Visible    ${WHAT_PHONE_INPUT}
    # Step 17: Phone with letters should trigger validation error and prevent advancing
    Clear Element Text               ${WHAT_PHONE_INPUT}
    Input Text                       ${WHAT_PHONE_INPUT}    55-01ab
    Click Element                    ${WIZARD_NEXT_BUTTON}
    Wait Until Element Is Visible    ${WHAT_ERRORS_ALERT}
    # Fix phone and proceed to Step 2
    Clear Element Text               ${WHAT_PHONE_INPUT}
    Fill Wizard Step 1 What          poc_name=Sgt Test Requester    phone=555-0199

Step 18 To 20a: Fill Where And When And Verify Route Choice Help
    [Documentation]    J20 Steps 18-20a: Enter pickup and delivery places/grids, verify Same as you POC checkboxes
    ...                and Route choice / threat areas help, then advance to Cargo.
    [Tags]    J20    tmr    wizard    requires_login
    Element Should Be Visible        ${PICKUP_POC_SAME_CHECKBOX}
    Element Should Be Visible        ${DELIVERY_POC_SAME_CHECKBOX}
    Fill Wizard Step 2 Where And When
    ...    pickup_loc=Camp Horno
    ...    pickup_grid=11SMS5549493155
    ...    delivery_loc=Camp San Mateo
    ...    delivery_grid=11SMS5210096400
    ...    comments=J20 automated wizard walkthrough

Step 21 To 23: Fill Cargo Line And Verify Optional Funding Step
    [Documentation]    J20 Steps 21-23: Populate Line 1 on the Cargo step, advance to Funding and commercial (optional),
    ...                verify negative cost validation, and proceed to Review.
    [Tags]    J20    tmr    cargo    funding    requires_login
    Fill Wizard Step 3 Custom Cargo Line
    ...    description=Mixed pallet: MREs and water
    ...    qty=2
    ...    weight=1200
    # Step 23: Verify negative cost is rejected on Funding and commercial
    Input Text                       ${FUNDING_ESTIMATED_COST_INPUT}    -1
    Click Element                    ${WIZARD_NEXT_BUTTON}
    Wait Until Element Is Visible    ${WIZARD_STEP_PROBLEM}
    Clear Element Text               ${FUNDING_ESTIMATED_COST_INPUT}
    Complete Wizard Step 4 Funding Optional

Step 24: Review Readiness And Save TMR Draft
    [Documentation]    J20 Step 24: Verify Review step reports 'Nothing left to fix. It is ready to submit.'
    ...                and saving as draft assigns a TMR number.
    [Tags]    J20    tmr    draft    requires_login
    Wait Until Element Is Visible    ${REVIEW_READY_BANNER}
    Page Should Contain              Nothing left to fix. It is ready to submit.
    Save TMR As Draft On Review Step
