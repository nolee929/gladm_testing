*** Settings ***
Documentation     Page Object for validating GLADM form field value types, HTML5/ARIA constraints,
...               invalid-input prevention, and valid-input acceptance across public and protected forms.
Library           SeleniumLibrary
Library           String
Resource          ../../variables/config.resource
Resource          login_page.resource
Resource          navigation_page.resource

*** Variables ***
# ==============================================================================
# Public Request Account Form (/request-account)
# ==============================================================================
${REQ_ACCT_FORM}                    css:form[aria-label="Request an account"]
${REQ_ACCT_SUMMARY}                 id:request-account-summary
${REQ_ACCT_FIRST_NAME}              id:request-account-firstName
${REQ_ACCT_FIRST_NAME_ERR}          id:request-account-firstName-error
${REQ_ACCT_LAST_NAME}               id:request-account-lastName
${REQ_ACCT_LAST_NAME_ERR}           id:request-account-lastName-error
${REQ_ACCT_EMAIL}                   id:request-account-email
${REQ_ACCT_EMAIL_ERR}               id:request-account-email-error
${REQ_ACCT_PHONE}                   id:request-account-phone
${REQ_ACCT_PHONE_ERR}               id:request-account-phone-error
${REQ_ACCT_UNIT}                    id:request-account-unitText
${REQ_ACCT_UNIT_ERR}                id:request-account-unitText-error
${REQ_ACCT_ROLE_SELECT}             id:request-account-roleWanted
${REQ_ACCT_ROLE_ERR}                id:request-account-roleWanted-error
${REQ_ACCT_REASON}                  id:request-account-reason
${REQ_ACCT_REASON_ERR}              id:request-account-reason-error
${REQ_ACCT_SPONSOR_NAME}            id:request-account-sponsorName
${REQ_ACCT_SPONSOR_NAME_ERR}        id:request-account-sponsorName-error
${REQ_ACCT_SPONSOR_EMAIL}           id:request-account-sponsorEmail
${REQ_ACCT_SPONSOR_EMAIL_ERR}       id:request-account-sponsorEmail-error
${REQ_ACCT_SUBMIT_BTN}              css:form[aria-label="Request an account"] button[type="submit"]

# ==============================================================================
# Public Forgot Password Form (/forgot-password)
# ==============================================================================
${FORGOT_PW_FORM}                   css:form[aria-label="Forgot password"]
${FORGOT_PW_SUMMARY}                id:forgot-password-summary
${FORGOT_PW_USERNAME}               id:forgot-password-username
${FORGOT_PW_USERNAME_ERR}           id:forgot-password-username-error
${FORGOT_PW_FULL_NAME}              id:forgot-password-fullName
${FORGOT_PW_FULL_NAME_ERR}          id:forgot-password-fullName-error
${FORGOT_PW_UNIT}                   id:forgot-password-unitText
${FORGOT_PW_UNIT_ERR}               id:forgot-password-unitText-error
${FORGOT_PW_CONTACT}                id:forgot-password-contact
${FORGOT_PW_CONTACT_ERR}            id:forgot-password-contact-error
${FORGOT_PW_LOST_AUTH_CHK}          css:input[name="lostAuthenticator"], button[role="checkbox"]
${FORGOT_PW_SUBMIT_BTN}             css:form[aria-label="Forgot password"] button[type="submit"]

# ==============================================================================
# Protected Transportation Request Wizard (/sgen-tcp/protected/requests)
# ==============================================================================
${WIZARD_PICKUP_DATE_FIELD}         id:wizard-pickup-time
${WIZARD_PICKUP_TIME_OF_DAY_FIELD}  id:wizard-pickup-time-time
${WIZARD_PICKUP_TIME_ERR}           id:wizard-pickup-time-error
${WIZARD_DELIVERY_DATE_FIELD}       id:wizard-delivery-time
${WIZARD_DELIVERY_TIME_OF_DAY}      id:wizard-delivery-time-time
${WIZARD_DELIVERY_TIME_ERR}         id:wizard-delivery-time-error

# ==============================================================================
# Protected Equipment & New Model Form (/sgen-tcp/protected/records/models/new)
# ==============================================================================
${MODEL_NSN_INPUT}                  xpath://label[contains(normalize-space(), 'NSN')]/following::input[1]
${MODEL_NAME_INPUT}                 xpath://label[contains(normalize-space(), 'Model')]/following::input[1]
${MODEL_PAYLOAD_INPUT}              xpath://label[contains(normalize-space(), 'Payload')]/following::input[1]
${MODEL_CAB_SEATS_INPUT}            xpath://label[contains(normalize-space(), 'Cab seats')]/following::input[1]
${MODEL_SAVE_BTN}                   xpath://button[contains(normalize-space(), 'Create model') or contains(normalize-space(), 'Save')]

# ==============================================================================
# Protected Watch Log 9-Line MEDEVAC Form (/protected/watchlog/create/medevac)
# ==============================================================================
${MEDEVAC_LITTER_INPUT}             xpath://label[contains(normalize-space(), 'Litter')]/following::input[1]
${MEDEVAC_WALKING_INPUT}            xpath://label[contains(normalize-space(), 'Walking') or contains(normalize-space(), 'Ambulatory')]/following::input[1]
${MEDEVAC_URGENT_INPUT}             xpath://label[contains(normalize-space(), 'Urgent')]/following::input[1]

# ==============================================================================
# Protected Utilities Request & Supply Calculators (/protected/utilities/...)
# ==============================================================================
${UTIL_MOS_INPUT}                   xpath://label[contains(normalize-space(), 'MOS')]/following::input[1]
${CALC_DAYS_INPUT}                  xpath://label[contains(normalize-space(), 'Days')]/following::input[1]
${CALC_MARINES_INPUT}               xpath://label[contains(normalize-space(), 'Marines') or contains(normalize-space(), 'Headcount') or contains(normalize-space(), 'People')]/following::input[1]

*** Keywords ***
# ==============================================================================
# Generic Field Attribute & Type Assertion Helpers
# ==============================================================================
Verify Input Attribute Equals
    [Documentation]    Asserts that an input element's HTML attribute matches the expected value.
    [Arguments]    ${locator}    ${attribute}    ${expected_value}
    Wait Until Element Is Visible    ${locator}    ${EXPLICIT_WAIT}
    Element Attribute Value Should Be    ${locator}    ${attribute}    ${expected_value}

Verify Field Enforces Max Length
    [Documentation]    Verifies the input has maxLength=${max_length} and truncates strings exceeding ${max_length}.
    [Arguments]    ${locator}    ${max_length}
    Wait Until Element Is Visible    ${locator}    ${EXPLICIT_WAIT}
    Element Attribute Value Should Be    ${locator}    maxlength    ${max_length}
    ${over_len}=    Evaluate    int(${max_length}) + 15
    ${long_str}=    Generate Random String    ${over_len}    [LETTERS]
    Clear Input Via Keyboard    ${locator}
    Input Text    ${locator}    ${long_str}
    ${actual_val}=    Get Value    ${locator}
    ${actual_len}=    Get Length    ${actual_val}
    Should Be Equal As Integers    ${actual_len}    ${max_length}

Clear Input Via Keyboard
    [Documentation]    Selects all text in a controlled React input and deletes it cleanly.
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    ${EXPLICIT_WAIT}
    ${el}=    Get WebElement    ${locator}
    Execute Javascript    arguments[0].scrollIntoView({block: 'center'}); arguments[0].focus();    ARGUMENTS    ${el}
    Press Keys    ${locator}    CTRL+a    BACKSPACE

Verify Field Marked Aria Invalid
    [Documentation]    Verifies that a form control has aria-invalid="true" after invalid input.
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    ${EXPLICIT_WAIT}
    Element Attribute Value Should Be    ${locator}    aria-invalid    true

Verify Field Not Marked Aria Invalid
    [Documentation]    Verifies that a form control does not have aria-invalid="true" after valid input.
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    ${EXPLICIT_WAIT}
    ${aria_invalid}=    Get Element Attribute    ${locator}    aria-invalid
    Should Not Be Equal    ${aria_invalid}    true

# ==============================================================================
# Public Request Account Form Navigation & Validation Keywords
# ==============================================================================
Open Public Request Account Form
    [Documentation]    Navigates to /request-account and accepts the DoD Notice and Consent banner if shown.
    Go To    ${BASE_URL}/request-account
    ${has_consent}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${DOD_AGREE_BUTTON}    5s
    IF    ${has_consent}
        Click Button    ${DOD_AGREE_BUTTON}
    END
    Wait Until Element Is Visible    ${REQ_ACCT_FORM}    ${EXPLICIT_WAIT}

Verify Request Account Field Value Types And Constraints
    [Documentation]    Validates HTML input types, inputModes, and maxLength attributes on /request-account.
    Verify Input Attribute Equals    ${REQ_ACCT_FIRST_NAME}       maxlength       100
    Verify Input Attribute Equals    ${REQ_ACCT_FIRST_NAME}       autocomplete    given-name
    Verify Input Attribute Equals    ${REQ_ACCT_LAST_NAME}        maxlength       100
    Verify Input Attribute Equals    ${REQ_ACCT_LAST_NAME}        autocomplete    family-name
    Verify Input Attribute Equals    ${REQ_ACCT_EMAIL}            type            email
    Verify Input Attribute Equals    ${REQ_ACCT_EMAIL}            inputmode       email
    Verify Input Attribute Equals    ${REQ_ACCT_PHONE}            type            tel
    Verify Input Attribute Equals    ${REQ_ACCT_PHONE}            inputmode       tel
    Verify Input Attribute Equals    ${REQ_ACCT_PHONE}            maxlength       30
    Verify Input Attribute Equals    ${REQ_ACCT_UNIT}             maxlength       200
    Verify Input Attribute Equals    ${REQ_ACCT_REASON}           rows            5
    Verify Input Attribute Equals    ${REQ_ACCT_SPONSOR_NAME}     maxlength       100
    Verify Input Attribute Equals    ${REQ_ACCT_SPONSOR_EMAIL}    type            email
    Verify Input Attribute Equals    ${REQ_ACCT_SPONSOR_EMAIL}    inputmode       email

Submit Request Account Form And Expect Validation Errors
    [Documentation]    Clicks Send request on /request-account and waits for validation summary.
    Click Button    ${REQ_ACCT_SUBMIT_BTN}
    Wait Until Element Is Visible    ${REQ_ACCT_SUMMARY}    ${EXPLICIT_WAIT}

# ==============================================================================
# Public Forgot Password Form Navigation & Validation Keywords
# ==============================================================================
Open Public Forgot Password Form
    [Documentation]    Navigates to /forgot-password and accepts the DoD Notice and Consent banner if shown.
    Go To    ${BASE_URL}/forgot-password
    ${has_consent}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${DOD_AGREE_BUTTON}    5s
    IF    ${has_consent}
        Click Button    ${DOD_AGREE_BUTTON}
    END
    Wait Until Element Is Visible    ${FORGOT_PW_FORM}    ${EXPLICIT_WAIT}

Verify Forgot Password Field Value Types And Constraints
    [Documentation]    Validates HTML attributes and maxLength constraints on /forgot-password.
    Verify Input Attribute Equals    ${FORGOT_PW_USERNAME}     maxlength       64
    Verify Input Attribute Equals    ${FORGOT_PW_USERNAME}     autocomplete    username
    Verify Input Attribute Equals    ${FORGOT_PW_FULL_NAME}    maxlength       200
    Verify Input Attribute Equals    ${FORGOT_PW_FULL_NAME}    autocomplete    name
    Verify Input Attribute Equals    ${FORGOT_PW_UNIT}         maxlength       200
    Verify Input Attribute Equals    ${FORGOT_PW_UNIT}         autocomplete    organization
    Verify Input Attribute Equals    ${FORGOT_PW_CONTACT}      maxlength       200
    Verify Input Attribute Equals    ${FORGOT_PW_CONTACT}      autocomplete    tel

Submit Forgot Password Form And Expect Validation Errors
    [Documentation]    Clicks Send request on /forgot-password and waits for validation summary.
    Click Button    ${FORGOT_PW_SUBMIT_BTN}
    Wait Until Element Is Visible    ${FORGOT_PW_SUMMARY}    ${EXPLICIT_WAIT}

# ==============================================================================
# Shared Date & 24-Hour Time Field Validation Keywords
# ==============================================================================
Verify Date And Time Field Prevents Invalid Inputs
    [Documentation]    Tests a GLADM DateTimeField (e.g., #wizard-pickup-time and #wizard-pickup-time-time)
    ...                against non-date text, numeric slash dates, impossible calendar days, and invalid 24h times,
    ...                then verifies valid "dd MMM yyyy" and "HH:MM" values are accepted.
    [Arguments]    ${date_locator}    ${time_locator}    ${error_locator}
    Wait Until Element Is Visible    ${date_locator}    ${EXPLICIT_WAIT}
    Verify Input Attribute Equals    ${date_locator}    placeholder    dd MMM yyyy
    Verify Input Attribute Equals    ${time_locator}    placeholder    HH:MM
    Verify Input Attribute Equals    ${time_locator}    inputmode      numeric

    # 1. Non-date text is rejected
    Clear Input Via Keyboard    ${date_locator}
    Input Text    ${date_locator}    invalid-date-text
    Press Keys    ${date_locator}    TAB
    Wait Until Element Is Visible    ${error_locator}    ${EXPLICIT_WAIT}
    Element Should Contain    ${error_locator}    Type a date like
    Verify Field Marked Aria Invalid    ${date_locator}

    # 2. Numeric slash date (MM/DD/YYYY) is rejected to prevent day/month ambiguity
    Clear Input Via Keyboard    ${date_locator}
    Input Text    ${date_locator}    10/11/2026
    Press Keys    ${date_locator}    TAB
    Wait Until Element Is Visible    ${error_locator}    ${EXPLICIT_WAIT}
    Element Should Contain    ${error_locator}    Type the month as a word

    # 3. Impossible calendar day (31 Feb 2026) is rejected
    Clear Input Via Keyboard    ${date_locator}
    Input Text    ${date_locator}    31 Feb 2026
    Press Keys    ${date_locator}    TAB
    Wait Until Element Is Visible    ${error_locator}    ${EXPLICIT_WAIT}
    Element Should Contain    ${error_locator}    February 2026 has no day 31

    # 4. Valid date (15 Oct 2026) is accepted
    Clear Input Via Keyboard    ${date_locator}
    Input Text    ${date_locator}    15 Oct 2026
    Press Keys    ${date_locator}    TAB

    # 5. Out-of-range 24-hour time (25:99) is rejected
    Clear Input Via Keyboard    ${time_locator}
    Input Text    ${time_locator}    25:99
    Press Keys    ${time_locator}    TAB
    Wait Until Element Is Visible    ${error_locator}    ${EXPLICIT_WAIT}
    Element Should Contain    ${error_locator}    Type a 24-hour time like 14:30 (00:00 to 23:59)
    Verify Field Marked Aria Invalid    ${time_locator}

    # 6. Alphabetic time string is rejected
    Clear Input Via Keyboard    ${time_locator}
    Input Text    ${time_locator}    abcd
    Press Keys    ${time_locator}    TAB
    Wait Until Element Is Visible    ${error_locator}    ${EXPLICIT_WAIT}
    Element Should Contain    ${error_locator}    Type a 24-hour time like 14:30

    # 7. Valid 24-hour time (08:30) is accepted and clears error
    Clear Input Via Keyboard    ${time_locator}
    Input Text    ${time_locator}    08:30
    Press Keys    ${time_locator}    TAB
    Verify Field Not Marked Aria Invalid    ${date_locator}
    Verify Field Not Marked Aria Invalid    ${time_locator}
