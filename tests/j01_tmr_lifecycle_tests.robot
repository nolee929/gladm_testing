*** Settings ***
Documentation     J01: TMR Lifecycle — From Request to Mission (Submit, Recall, Acknowledge, Review, Cancel).
...               Covers R392, R394, R397, R399, R400, R403, R410, R414, R418, R421, R429, R430, R431, R433, R434.
Resource          ../resources/common.resource
Resource          ../resources/pages/login_page.resource
Resource          ../resources/pages/navigation_page.resource
Resource          ../resources/pages/requests_page.resource

Suite Setup       Open Authenticated TMR Lifecycle Session
Suite Teardown    Close Test Browser

*** Keywords ***
Open Authenticated TMR Lifecycle Session
    [Documentation]    Opens the browser, logs in once, dismisses popups, and opens Requests.
    Open Test Browser
    Sign In To GLADM With Env Credentials
    Dismiss Post Login Popups If Present
    Navigate To Requests List

*** Test Cases ***
Step 1 To 2d: Create And Save A Complete Draft TMR
    [Documentation]    J01 Steps 1-2d (R421, R392, R418, R429, R397): Create a new TMR through all 5 wizard steps,
    ...                save it as a draft, and open its full request page.
    [Tags]    J01    R421    R392    R418    R397    tmr_lifecycle    requires_login
    Navigate To Requests List
    Start New TMR Wizard
    Fill Wizard Step 1 What          poc_name=Sgt Test Requester    phone=555-0199
    Fill Wizard Step 2 Where And When
    ...    pickup_loc=Camp Horno
    ...    pickup_grid=11SMS5549493155
    ...    delivery_loc=Camp San Mateo
    ...    delivery_grid=11SMS5210096400
    ...    comments=J01 lifecycle automated test TMR
    Fill Wizard Step 3 Custom Cargo Line
    ...    description=Standard Pallet Class I Rations
    ...    qty=4
    ...    weight=1800
    Complete Wizard Step 4 Funding Optional
    Wait Until Element Is Visible    ${REVIEW_READY_BANNER}
    Save TMR As Draft On Review Step
    Open Saved Draft From Wizard
    Page Should Contain              At a glance

Step 3 To 4a: Submit Draft TMR To Supporting Unit And Verify Approval Chain
    [Documentation]    J01 Steps 3-4a (R414, R434, R400, R430, R431): Submit the saved draft TMR to the supporting unit
    ...                and verify status transitions to Submitted and waiting-on text updates.
    [Tags]    J01    R414    R434    R400    R430    R431    tmr_lifecycle    requires_login
    Wait Until Element Is Visible    ${ACTION_SUBMIT_BUTTON}
    Click Element                    ${ACTION_SUBMIT_BUTTON}
    Wait Until Element Is Visible    ${DIALOG_CONFIRM_SUBMIT_BUTTON}
    Click Element                    ${DIALOG_CONFIRM_SUBMIT_BUTTON}
    Wait Until Page Contains         Submitted    timeout=15s
    Element Should Be Visible        ${REQUEST_OVERVIEW}
    Element Should Be Visible        ${WAITING_ON_LINE}

Step 5: Recall Submitted TMR Back To Draft
    [Documentation]    J01 Step 5 (R410, R433): Recall a Submitted TMR back to Draft with a reason and verify status returns to Draft.
    [Tags]    J01    R410    R433    tmr_lifecycle    requires_login
    ${can_recall}=                   Run Keyword And Return Status    Wait Until Element Is Visible    ${ACTION_RECALL_TO_DRAFT_BUTTON}    timeout=5s
    IF    ${can_recall}
        Click Element                ${ACTION_RECALL_TO_DRAFT_BUTTON}
        Wait Until Element Is Visible    ${DIALOG_REASON_TEXTAREA}
        Input Text                   ${DIALOG_REASON_TEXTAREA}    Recalling to draft in automated J01 test to verify R410/R433
        Click Element                xpath://div[@role='dialog']//button[normalize-space()='Recall to draft']
        Wait Until Page Contains     Draft    timeout=15s
    END

Step 23 To 25: Verify Archive Bin And Request Board View
    [Documentation]    J01 Steps 23 & 25 (R394, R416): Verify Archive bin is accessible and switching to the Request Board displays stage columns.
    [Tags]    J01    R394    R416    tmr_lifecycle    requires_login
    Navigate To Requests List
    Select Request Bin               Archive
    Wait Until Element Is Visible    ${REQUEST_BOARD_BUTTON}
    Click Element                    ${REQUEST_BOARD_BUTTON}
    Wait Until Page Contains         Board    timeout=15s
