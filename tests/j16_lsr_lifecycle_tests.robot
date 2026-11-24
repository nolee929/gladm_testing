*** Settings ***
Documentation     J16: LSR (Logistics Support Request) Lifecycle — From Request to TMR.
...               Covers R399, R400, R401, R415, R416, R418, R421.
Resource          ../resources/common.resource
Resource          ../resources/pages/login_page.resource
Resource          ../resources/pages/navigation_page.resource
Resource          ../resources/pages/requests_page.resource

Suite Setup       Open Authenticated LSR Session
Suite Teardown    Close Test Browser

*** Keywords ***
Open Authenticated LSR Session
    [Documentation]    Opens the browser, logs in once, dismisses popups, and opens Requests.
    Open Test Browser
    Sign In To GLADM With Env Credentials
    Dismiss Post Login Popups If Present
    Navigate To Requests List

*** Test Cases ***
Step 1 To 3: Start New LSR And Complete What And Where Steps
    [Documentation]    J16 Steps 1-3 (R416, R421): Switch to the LSR type tab on Requests, click New LSR,
    ...                fill Step 1 (What) and Step 2 (Where and when), and verify advancing to Step 3 (Line items).
    [Tags]    J16    R416    R421    lsr    wizard    requires_login
    Navigate To Requests List
    Start New LSR Wizard
    Fill Wizard Step 1 What          poc_name=Sgt Supply Requester    phone=555-0177
    Wait Until Element Is Visible    ${WIZARD_STEP_WHERE}
    Clear Element Text               ${PICKUP_LOCATION_INPUT}
    Input Text                       ${PICKUP_LOCATION_INPUT}      Camp Horno
    Clear Element Text               ${PICKUP_GRID_INPUT}
    Input Text                       ${PICKUP_GRID_INPUT}          11SMS5549493155
    Clear Element Text               ${DELIVERY_LOCATION_INPUT}
    Input Text                       ${DELIVERY_LOCATION_INPUT}    Camp San Mateo
    Clear Element Text               ${DELIVERY_GRID_INPUT}
    Input Text                       ${DELIVERY_GRID_INPUT}        11SMS5210096400
    Click Element                    ${WIZARD_NEXT_BUTTON}
    Wait Until Element Is Visible    ${WIZARD_STEP_LINE_ITEMS}

Step 4 To 8: Add Supply Line Item And Save Draft LSR
    [Documentation]    J16 Steps 4-8 (R418, R421): Add a Supply line item on Step 3, advance to Review,
    ...                verify readiness banner, save as draft, and open the full LSR page.
    [Tags]    J16    R418    R421    lsr    line_items    requires_login
    Fill LSR Wizard Step 3 Supply Line Item
    ...    description=Meal, Ready-to-Eat (MRE), case A
    ...    qty=40
    Wait Until Element Is Visible    ${REVIEW_READY_BANNER}
    Save TMR As Draft On Review Step
    Open Saved Draft From Wizard
    Page Should Contain              At a glance

Step 9 To 11: Submit Draft LSR And Verify Recall Action
    [Documentation]    J16 Steps 9-11 (R400, R416): Submit the saved LSR to the supporting unit, verify
    ...                Submitted status and waiting-on text, and recall back to Draft if available.
    [Tags]    J16    R400    R416    lsr    lifecycle    requires_login
    Wait Until Element Is Visible    ${ACTION_SUBMIT_BUTTON}
    Click Element                    ${ACTION_SUBMIT_BUTTON}
    Wait Until Element Is Visible    ${DIALOG_CONFIRM_SUBMIT_BUTTON}
    Click Element                    ${DIALOG_CONFIRM_SUBMIT_BUTTON}
    Wait Until Page Contains         Submitted    timeout=15s
    Element Should Be Visible        ${WAITING_ON_LINE}
    ${can_recall}=                   Run Keyword And Return Status    Wait Until Element Is Visible    ${ACTION_RECALL_TO_DRAFT_BUTTON}    timeout=5s
    IF    ${can_recall}
        Click Element                ${ACTION_RECALL_TO_DRAFT_BUTTON}
        ${has_reason}=               Run Keyword And Return Status    Wait Until Element Is Visible    ${DIALOG_REASON_TEXTAREA}    timeout=3s
        IF    ${has_reason}
            Input Text               ${DIALOG_REASON_TEXTAREA}    Recalling LSR to draft in automated J16 test
        END
        Click Element                xpath://div[@role='dialog']//button[contains(normalize-space(), 'Recall')]
        Wait Until Page Contains     Draft    timeout=15s
    END
