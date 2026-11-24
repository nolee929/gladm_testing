*** Settings ***
Documentation     Page Object Model for GLADM Requests List, Request Details, and the New TMR/GTR/LSR Wizard (J20, J01).
Library           SeleniumLibrary
Resource          ../../variables/config.resource

*** Variables ***
# Requests List & Navigation (J20 Steps 3-10, J01 Step 6)
${REQUESTS_HEADING}                 xpath://h1[normalize-space()='Requests']
${NEW_TMR_BUTTON}                   xpath://a[contains(., 'New TMR') or contains(., 'New request')] | //button[contains(., 'New TMR') or contains(., 'New request')]
${NEW_GTR_BUTTON}                   xpath://a[contains(., 'New GTR')] | //button[contains(., 'New GTR')]
${REQUEST_BOARD_BUTTON}             xpath://a[contains(., 'Board')] | //button[contains(., 'Board')]
${MORE_FILTERS_BUTTON}              xpath://button[contains(., 'More filters')]
${CLEAR_FILTERS_BUTTON}             xpath://button[contains(., 'Clear filters')]
${SAVE_THIS_VIEW_BUTTON}            xpath://button[contains(., 'Save this view')]
${OVERVIEW_BINS_NOTE}               css:[data-testid="overview-bins-note"]
${REQUEST_SEARCH_INPUT}             xpath://input[@type='search' or contains(@placeholder, 'Search') or @aria-label='Search']

# Request Bins (J20 Step 6, J01 Step 6, 23)
${BIN_INBOX}                        xpath://button[starts-with(normalize-space(), 'Inbox')] | //*[@role='tab'][starts-with(normalize-space(), 'Inbox')]
${BIN_DRAFT}                        xpath://button[starts-with(normalize-space(), 'Draft')] | //*[@role='tab'][starts-with(normalize-space(), 'Draft')]
${BIN_SUBMITTED}                    xpath://button[starts-with(normalize-space(), 'Submitted')] | //*[@role='tab'][starts-with(normalize-space(), 'Submitted')]
${BIN_SUPPORTING}                   xpath://button[starts-with(normalize-space(), 'Supporting')] | //*[@role='tab'][starts-with(normalize-space(), 'Supporting')]
${BIN_FORWARDED}                    xpath://button[starts-with(normalize-space(), 'Forwarded')] | //*[@role='tab'][starts-with(normalize-space(), 'Forwarded')]
${BIN_DECLINED}                     xpath://button[starts-with(normalize-space(), 'Declined')] | //*[@role='tab'][starts-with(normalize-space(), 'Declined')]
${BIN_CHANGE_REQUEST}               xpath://button[starts-with(normalize-space(), 'Change Request')] | //*[@role='tab'][starts-with(normalize-space(), 'Change Request')]
${BIN_ARCHIVE}                      xpath://button[starts-with(normalize-space(), 'Archive')] | //*[@role='tab'][starts-with(normalize-space(), 'Archive')]
${BIN_ALL}                          xpath://button[@aria-label='All bins' or normalize-space()='All'] | //*[@role='tab'][@aria-label='All bins' or normalize-space()='All']

# Request Wizard Shell & Stepper (J20 Steps 13-27, J01 Steps 1-3)
${WIZARD_HEADING}                   css:[data-testid="wizard-heading"]
${WIZARD_SUMMARY_ASIDE}             css:[data-testid="wizard-summary"]
${WIZARD_STEP_PROBLEM}              css:[data-testid="wizard-step-problem"]
${WIZARD_NEXT_BUTTON}               xpath://*[@aria-label="Step actions"]//button[normalize-space()='Next'] | //button[@type='submit' and normalize-space()='Next']
${WIZARD_BACK_BUTTON}               xpath://*[@aria-label="Step actions"]//button[normalize-space()='Back']
${WIZARD_SAVE_DRAFT_BUTTON}         xpath://button[normalize-space()='Save draft']
${WIZARD_SAVE_CHANGES_BUTTON}       css:[data-testid="wizard-save-changes"]
${WIZARD_SAVE_AND_SUBMIT_BUTTON}    xpath://*[@aria-label="Step actions"]//button[normalize-space()='Save and submit' or normalize-space()='Submit']
${WIZARD_VIEW_REQUEST_LINK}         css:[data-testid="wizard-view-request"]

# Wizard Step 1: What (J20 Steps 14-17, J01 Step 2a)
${WHAT_ERRORS_ALERT}                css:[data-testid="what-errors"]
${WHAT_REQUESTING_UNIT_INPUT}       id:wizard-what-requestingUnit
${WHAT_SUPPORTING_UNIT_INPUT}       id:wizard-what-supportingUnit
${WHAT_POC_INPUT}                   id:wizard-what-ruPoc
${WHAT_PHONE_INPUT}                 id:wizard-what-ruPhone

# Wizard Step 2: Where and When (J20 Steps 18-20a, J01 Step 2b)
${WIZARD_STEP_WHERE}                css:[data-testid="wizard-step-where"]
${PICKUP_LOCATION_INPUT}            id:wizard-pickup-location
${PICKUP_GRID_INPUT}                id:wizard-pickup-grid
${PICKUP_TIME_INPUT}                id:wizard-pickup-time
${PICKUP_POC_SAME_CHECKBOX}         id:wizard-pickup-poc-same-box
${DELIVERY_LOCATION_INPUT}          id:wizard-delivery-location
${DELIVERY_GRID_INPUT}              id:wizard-delivery-grid
${DELIVERY_TIME_INPUT}              id:wizard-delivery-time
${DELIVERY_POC_SAME_CHECKBOX}       id:wizard-delivery-poc-same-box
${ORIGINATOR_COMMENTS_INPUT}        id:wizard-comments
${ROUTE_CHOICE_SECTION}             css:[data-slot="wizard-route-choice"]
${THREAT_AREAS_HELP}                css:[data-slot="threat-areas-help"]

# Wizard Step 3: Cargo (J20 Steps 21-22a, J01 Step 2c)
${WIZARD_STEP_CARGO}                css:[data-testid="wizard-step-cargo"]
${CARGO_CATALOG_ADD_INPUT}          id:cargo-add
${CARGO_ADD_CUSTOM_BUTTON}          css:[data-testid="cargo-add-custom"]
${CARGO_LINE_1_CATALOG_INPUT}       id:cargo-0-catalog
${CARGO_LINE_1_DESCRIPTION}         id:cargo-0-description
${CARGO_LINE_1_CLASS_SELECT}        id:cargo-0-classOfSupply
${CARGO_LINE_1_TYPE_SELECT}         id:cargo-0-cargoType
${CARGO_LINE_1_QTY_INPUT}           id:cargo-0-cargoQuantity
${CARGO_LINE_1_RAW_QTY_INPUT}       id:cargo-0-rawQuantity
${CARGO_LINE_1_WEIGHT_INPUT}        id:cargo-0-weight
${CARGO_LINE_1_COMMENTS_INPUT}      id:cargo-0-comments
${CARGO_TOTALS}                     css:[data-testid="cargo-totals"]

# Wizard Step 4: Funding and Commercial (J20 Steps 23-23a)
${WIZARD_STEP_FUNDING}              css:[data-testid="wizard-step-funding"]
${FUNDING_OPTIONAL_NOTE}            css:[data-testid="funding-optional"]
${FUNDING_ESTIMATED_COST_INPUT}     id:funding-estimatedCost
${FUNDING_ACTUAL_COST_INPUT}        id:funding-actualCost
${FUNDING_COMMENTS_INPUT}           id:funding-comments

# Wizard Step 5: Review (J20 Steps 24-26, J01 Steps 2d-3)
${REVIEW_READY_BANNER}              css:[data-testid="review-ready"]
${REVIEW_PROBLEMS_BANNER}           css:[data-testid="review-problems"]

# Request Full Page & Workflow Actions (J20 Step 11, J01 Steps 4-22)
${REQUEST_OVERVIEW}                 css:[data-testid="request-overview"]
${WAITING_ON_LINE}                  css:[data-testid="waiting-on"]
${APPROVAL_CHAIN}                   css:[data-testid="approval-chain"]
${MORE_ACTIONS_MENU_BUTTON}         xpath://*[@data-slot="request-title-actions"]//button[@aria-label="More actions"] | //button[@aria-label="More actions"]
${ACTION_SUBMIT_BUTTON}             xpath://button[normalize-space()='Submit']
${ACTION_RECALL_TO_DRAFT_BUTTON}    xpath://button[normalize-space()='Recall to draft' or normalize-space()='Recall']
${ACTION_ACKNOWLEDGE_BUTTON}        xpath://button[normalize-space()='Acknowledge']
${ACTION_MARK_REVIEWED_BUTTON}      xpath://button[normalize-space()='Mark reviewed']
${ACTION_RETURN_TO_DRAFT_BUTTON}    xpath://button[normalize-space()='Return to draft']
${DIALOG_CONFIRM_SUBMIT_BUTTON}     xpath://div[@role='dialog']//button[normalize-space()='Submit']
${DIALOG_REASON_TEXTAREA}           xpath://div[@role='dialog']//textarea

# Request Type Tabs (J05 Step 1, J16 Step 1)
${TYPE_TAB_ALL}                     xpath://button[@role='tab' and normalize-space()='All'] | //button[normalize-space()='All']
${TYPE_TAB_TMR}                     xpath://button[@id='TMR' or normalize-space()='TMR'] | //*[@role='tab'][normalize-space()='TMR']
${TYPE_TAB_LSR}                     xpath://button[@id='LSR' or normalize-space()='LSR'] | //*[@role='tab'][normalize-space()='LSR']
${TYPE_TAB_GTR}                     xpath://button[@id='GTR' or normalize-space()='GTR'] | //*[@role='tab'][normalize-space()='GTR']
${NEW_LSR_BUTTON}                   xpath://a[contains(., 'New LSR') or contains(., 'New request')] | //button[contains(., 'New LSR') or contains(., 'New request')]

# GTR Wizard Step 3: Convoy & Step 4: Route (J05 Steps 4-5, J20 Steps 28-34)
${WIZARD_STEP_CONVOY}               css:[data-testid="wizard-step-convoy"]
${CONVOY_CALL_SIGN_INPUT}           xpath://label[contains(normalize-space(), 'Call Sign')]/following::input[1]
${CONVOY_NUMBER_INPUT}              xpath://label[contains(normalize-space(), 'Convoy Number')]/following::input[1]
${CONVOY_CLASSIFICATION_SELECT}     xpath://label[contains(normalize-space(), 'Convoy Classification')]/following::select[1]
${CONVOY_COMMANDER_INPUT}           xpath://label[contains(normalize-space(), 'Convoy Commander')]/following::input[1]
${CONVOY_REVIEW_PATH_NOTE}          css:[data-testid="review-path"]
${CONVOY_PAX_TOTAL}                 css:[data-testid="convoy-paxTotalCount"]
${CONVOY_VEHICLE_TOTAL}             css:[data-testid="convoy-vehicleTotalCount"]
${WIZARD_STEP_ROUTE}                css:[data-testid="wizard-step-route"]
${ROUTE_SEGMENT_ADD_INPUT}          xpath://label[contains(normalize-space(), 'Add a route segment')]/following::input[1]
${ROUTE_BATTLESPACES_SECTION}       css:[data-testid="route-battlespaces"]

# GTR Review Queue Page (J05 Steps 10-11)
${GTR_REVIEW_HEADING}               xpath://h1[normalize-space()='GTR Review']
${GTR_REVIEW_TAB_BATTLESPACE}       xpath://*[@role='tab'][starts-with(normalize-space(), 'Battlespace')] | //button[starts-with(normalize-space(), 'Battlespace')]
${GTR_REVIEW_TAB_MMCC}              xpath://*[@role='tab'][starts-with(normalize-space(), 'MMCC')] | //button[starts-with(normalize-space(), 'MMCC')]
${GTR_REVIEW_TAB_FTB}               xpath://*[@role='tab'][starts-with(normalize-space(), 'FTB')] | //button[starts-with(normalize-space(), 'FTB')]

# LSR Wizard Step 3: Line Items (J16 Steps 4-6a)
${WIZARD_STEP_LINE_ITEMS}           css:[data-testid="wizard-step-line-items"]
${LSR_ADD_SUPPLY_LINE_BUTTON}       xpath://*[@aria-labelledby="line-items-by-type"]//button[normalize-space()='Supply']
${LSR_ADD_MAINTENANCE_LINE_BUTTON}  xpath://*[@aria-labelledby="line-items-by-type"]//button[normalize-space()='Maintenance']
${LSR_LINE_1_CLASS_SELECT}          id:item-0-classOfSupply
${LSR_LINE_1_DESCRIPTION_INPUT}     id:item-0-description
${LSR_LINE_1_QTY_INPUT}             id:item-0-supplyQuantity
${LSR_LINE_1_UNIT_SELECT}           id:item-0-unitOfIssue
${LSR_LINE_ITEMS_EMPTY}             css:[data-testid="line-items-empty"]

*** Keywords ***
Navigate To Requests List
    [Documentation]    Navigates directly to the Requests list page and waits for the heading (J20 Steps 3-4).
    Go To                            ${BASE_URL}/sgen-tcp/protected/requests
    Wait Until Element Is Visible    ${REQUESTS_HEADING}    timeout=20s

Select Request Bin
    [Documentation]    Clicks one of the request bins by name (e.g., Inbox, Draft, Submitted, Supporting, Archive, All).
    [Arguments]    ${bin_name}
    ${bin_locator}=                  Set Variable    xpath://button[starts-with(normalize-space(), '${bin_name}')] | //*[@role='tab'][starts-with(normalize-space(), '${bin_name}')]
    Wait Until Element Is Visible    ${bin_locator}
    Click Element                    ${bin_locator}

Open More Filters Panel
    [Documentation]    Opens the More filters side drawer on the Requests list (J20 Step 7).
    Wait Until Element Is Visible    ${MORE_FILTERS_BUTTON}
    Click Element                    ${MORE_FILTERS_BUTTON}
    Wait Until Page Contains         Delivery from

Start New TMR Wizard
    [Documentation]    Clicks the New TMR button on the Requests list and waits for Step 1 (What) (J20 Step 13, J01 Step 1).
    Wait Until Element Is Visible    ${NEW_TMR_BUTTON}
    Click Element                    ${NEW_TMR_BUTTON}
    Wait Until Element Is Visible    ${WIZARD_HEADING}

Fill Wizard Step 1 What
    [Documentation]    Ensures Point of Contact and Phone are populated on Step 1 (What) and advances to Step 2 (J20 Steps 15-17, J01 Step 2a).
    [Arguments]    ${poc_name}=Sgt Test Requester    ${phone}=555-0199
    Wait Until Element Is Visible    ${WHAT_POC_INPUT}
    ${current_poc}=                  Get Value    ${WHAT_POC_INPUT}
    IF    '${current_poc}' == '${EMPTY}'
        Input Text                   ${WHAT_POC_INPUT}    ${poc_name}
    END
    ${current_phone}=                Get Value    ${WHAT_PHONE_INPUT}
    IF    '${current_phone}' == '${EMPTY}'
        Input Text                   ${WHAT_PHONE_INPUT}    ${phone}
    END
    Click Element                    ${WIZARD_NEXT_BUTTON}
    Wait Until Element Is Visible    ${WIZARD_STEP_WHERE}

Fill Wizard Step 2 Where And When
    [Documentation]    Fills Pickup and Delivery locations/grids on Step 2 (Where and when) and advances to Step 3 (J20 Steps 18-20, J01 Step 2b).
    [Arguments]    ${pickup_loc}=Camp Horno    ${pickup_grid}=11SMS5549493155    ${delivery_loc}=Camp San Mateo    ${delivery_grid}=11SMS5210096400    ${comments}=Automated Robot Framework TMR test
    Wait Until Element Is Visible    ${WIZARD_STEP_WHERE}
    Clear Element Text               ${PICKUP_LOCATION_INPUT}
    Input Text                       ${PICKUP_LOCATION_INPUT}      ${pickup_loc}
    Clear Element Text               ${PICKUP_GRID_INPUT}
    Input Text                       ${PICKUP_GRID_INPUT}          ${pickup_grid}
    Clear Element Text               ${DELIVERY_LOCATION_INPUT}
    Input Text                       ${DELIVERY_LOCATION_INPUT}    ${delivery_loc}
    Clear Element Text               ${DELIVERY_GRID_INPUT}
    Input Text                       ${DELIVERY_GRID_INPUT}        ${delivery_grid}
    Input Text                       ${ORIGINATOR_COMMENTS_INPUT}  ${comments}
    Click Element                    ${WIZARD_NEXT_BUTTON}
    Wait Until Element Is Visible    ${WIZARD_STEP_CARGO}

Fill Wizard Step 3 Custom Cargo Line
    [Documentation]    Fills Line 1 on Step 3 (Cargo) with a custom pallet item and advances to Step 4 (J20 Steps 22-22a, J01 Step 2c).
    [Arguments]    ${description}=Mixed pallet: MREs and water    ${qty}=2    ${weight}=1200
    Wait Until Element Is Visible    ${WIZARD_STEP_CARGO}
    ${line_1_visible}=               Run Keyword And Return Status    Wait Until Element Is Visible    ${CARGO_LINE_1_DESCRIPTION}    timeout=3s
    IF    not ${line_1_visible}
        Click Element                ${CARGO_ADD_CUSTOM_BUTTON}
        Wait Until Element Is Visible    ${CARGO_LINE_1_DESCRIPTION}
    END
    Input Text                       ${CARGO_LINE_1_DESCRIPTION}    ${description}
    Select From List By Index        ${CARGO_LINE_1_CLASS_SELECT}   1
    Select From List By Index        ${CARGO_LINE_1_TYPE_SELECT}    1
    Clear Element Text               ${CARGO_LINE_1_QTY_INPUT}
    Input Text                       ${CARGO_LINE_1_QTY_INPUT}      ${qty}
    Clear Element Text               ${CARGO_LINE_1_WEIGHT_INPUT}
    Input Text                       ${CARGO_LINE_1_WEIGHT_INPUT}     ${weight}
    Click Element                    ${WIZARD_NEXT_BUTTON}
    Wait Until Element Is Visible    ${WIZARD_STEP_FUNDING}

Complete Wizard Step 4 Funding Optional
    [Documentation]    Verifies Step 4 (Funding and commercial) is optional and advances to Step 5 (Review) (J20 Step 23).
    Wait Until Element Is Visible    ${WIZARD_STEP_FUNDING}
    Element Should Be Visible        ${FUNDING_OPTIONAL_NOTE}
    Click Element                    ${WIZARD_NEXT_BUTTON}
    Wait Until Element Is Visible    ${WIZARD_HEADING}
    Element Text Should Be           ${WIZARD_HEADING}    Check and save

Save TMR As Draft On Review Step
    [Documentation]    Clicks Save draft on the Review step and waits for the View T... link to appear (J20 Step 24, J01 Step 2d).
    Wait Until Element Is Visible    ${WIZARD_SAVE_DRAFT_BUTTON}
    Click Element                    ${WIZARD_SAVE_DRAFT_BUTTON}
    Wait Until Element Is Visible    ${WIZARD_VIEW_REQUEST_LINK}    timeout=15s

Open Saved Draft From Wizard
    [Documentation]    Clicks the 'View T...' button next to Save draft to open the full request page (J01 Step 4a).
    Wait Until Element Is Visible    ${WIZARD_VIEW_REQUEST_LINK}
    Click Element                    ${WIZARD_VIEW_REQUEST_LINK}
    Wait Until Element Is Visible    ${REQUEST_OVERVIEW}

Start New GTR Wizard
    [Documentation]    Selects the GTR type tab on the Requests list and clicks New GTR (J05 Step 1, J20 Step 28).
    Wait Until Element Is Visible    ${TYPE_TAB_GTR}
    Click Element                    ${TYPE_TAB_GTR}
    Wait Until Element Is Visible    ${NEW_GTR_BUTTON}
    Click Element                    ${NEW_GTR_BUTTON}
    Wait Until Element Is Visible    ${WIZARD_HEADING}

Fill GTR Wizard Step 3 Convoy
    [Documentation]    Fills the required Convoy Information fields on Step 3 of a GTR and advances to Route (J05 Step 4, J20 Step 31).
    [Arguments]    ${call_sign}=DUSTY 6    ${convoy_num}=CONVOY-RF-01    ${commander}=SSgt Convoy Test
    Wait Until Element Is Visible    ${WIZARD_STEP_CONVOY}
    Input Text                       ${CONVOY_CALL_SIGN_INPUT}       ${call_sign}
    Input Text                       ${CONVOY_NUMBER_INPUT}          ${convoy_num}
    Select From List By Index        ${CONVOY_CLASSIFICATION_SELECT}    1
    Wait Until Element Is Visible    ${CONVOY_REVIEW_PATH_NOTE}
    Input Text                       ${CONVOY_COMMANDER_INPUT}       ${commander}
    Element Should Be Visible        ${CONVOY_PAX_TOTAL}
    Element Should Be Visible        ${CONVOY_VEHICLE_TOTAL}
    Click Element                    ${WIZARD_NEXT_BUTTON}
    Wait Until Element Is Visible    ${WIZARD_STEP_ROUTE}

Verify GTR Wizard Step 4 Route And Advance
    [Documentation]    Verifies Route Segments and Associated Battlespaces sections on Step 4 of a GTR and advances to Review (J05 Step 5, J20 Steps 32-33).
    Wait Until Element Is Visible    ${WIZARD_STEP_ROUTE}
    Element Should Be Visible        ${ROUTE_SEGMENT_ADD_INPUT}
    Element Should Be Visible        ${ROUTE_BATTLESPACES_SECTION}
    Click Element                    ${WIZARD_NEXT_BUTTON}
    Wait Until Element Is Visible    ${WIZARD_HEADING}
    Element Text Should Be           ${WIZARD_HEADING}    Check and save

Navigate To GTR Review Queue
    [Documentation]    Navigates to the GTR Review queue (/sgen-tcp/protected/requests/review) and verifies tabs (J05 Steps 10-11).
    Go To                            ${BASE_URL}/sgen-tcp/protected/requests/review
    Wait Until Element Is Visible    ${GTR_REVIEW_HEADING}    timeout=20s

Start New LSR Wizard
    [Documentation]    Selects the LSR type tab on the Requests list and clicks New LSR (J16 Step 1).
    Wait Until Element Is Visible    ${TYPE_TAB_LSR}
    Click Element                    ${TYPE_TAB_LSR}
    Wait Until Element Is Visible    ${NEW_LSR_BUTTON}
    Click Element                    ${NEW_LSR_BUTTON}
    Wait Until Element Is Visible    ${WIZARD_HEADING}

Fill LSR Wizard Step 3 Supply Line Item
    [Documentation]    Adds a Supply line item on Step 3 of an LSR, fills class, description, quantity, and unit of issue, and advances to Review (J16 Steps 4-5).
    [Arguments]    ${description}=Meal, Ready-to-Eat (MRE)    ${qty}=40
    Wait Until Element Is Visible    ${WIZARD_STEP_LINE_ITEMS}
    Click Element                    ${LSR_ADD_SUPPLY_LINE_BUTTON}
    Wait Until Element Is Visible    ${LSR_LINE_1_CLASS_SELECT}
    Select From List By Index        ${LSR_LINE_1_CLASS_SELECT}      1
    Input Text                       ${LSR_LINE_1_DESCRIPTION_INPUT}    ${description}
    Clear Element Text               ${LSR_LINE_1_QTY_INPUT}
    Input Text                       ${LSR_LINE_1_QTY_INPUT}         ${qty}
    Select From List By Index        ${LSR_LINE_1_UNIT_SELECT}       1
    Click Element                    ${WIZARD_NEXT_BUTTON}
    Wait Until Element Is Visible    ${WIZARD_HEADING}
    Element Text Should Be           ${WIZARD_HEADING}    Check and save

