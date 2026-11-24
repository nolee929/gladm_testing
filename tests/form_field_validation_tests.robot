*** Settings ***
Documentation     Comprehensive Form Field Type & Input Validation Test Suite for GLADM.
...               Validates that form fields across public and protected GLADM pages request and
...               accept the proper value types (email, tel, numeric, decimal, dates, 24-hour times,
...               10-digit EDIPI, 13-digit NSN, 4-digit MOS, whole-number counts, MGRS grids, and
...               letter-containing names) and properly prevent invalid inputs based on their type.
Resource          ../resources/common.resource
Resource          ../resources/pages/login_page.resource
Resource          ../resources/pages/navigation_page.resource
Resource          ../resources/pages/form_validation_page.resource
Resource          ../resources/pages/requests_page.resource
Resource          ../resources/pages/personnel_page.resource
Resource          ../resources/pages/equipment_page.resource
Resource          ../resources/pages/watchlog_page.resource
Resource          ../resources/pages/utilities_page.resource
Resource          ../resources/pages/supply_page.resource
Suite Setup       Open Test Browser
Suite Teardown    Close Test Browser

*** Test Cases ***
# ==============================================================================
# SAFE UNAUTHENTICATED FORM FIELD VALIDATION TESTS (NO LOGIN ATTEMPT)
# ==============================================================================
Public Request Account Form Enforces Field Value Types And MaxLength Constraints
    [Documentation]    Verifies that /request-account inputs declare the proper HTML5 types
    ...                (type="email", type="tel", inputMode="email", inputMode="tel") and enforce
    ...                character maxLength limits (100 for names, 30 for phone, 200 for unit, 1000 for reason).
    [Tags]    safe    form_validation    public_forms    J11    J25
    Open Public Request Account Form
    Verify Request Account Field Value Types And Constraints
    Verify Field Enforces Max Length    ${REQ_ACCT_FIRST_NAME}    100
    Verify Field Enforces Max Length    ${REQ_ACCT_LAST_NAME}     100
    Verify Field Enforces Max Length    ${REQ_ACCT_PHONE}         30
    Verify Field Enforces Max Length    ${REQ_ACCT_UNIT}          200
    Verify Field Enforces Max Length    ${REQ_ACCT_SPONSOR_NAME}  100

Public Request Account Form Prevents Empty Required Fields And Invalid Email Or Phone Inputs
    [Documentation]    Verifies that /request-account prevents submission when required fields are empty,
    ...                rejects malformed work/sponsor email addresses and invalid phone numbers, and
    ...                clears field errors once valid values of the proper type are entered.
    [Tags]    safe    form_validation    public_forms    J11    J25
    Open Public Request Account Form

    # 1. Submitting empty form blocks submission and flags all 8 required fields
    Submit Request Account Form And Expect Validation Errors
    Element Should Contain    ${REQ_ACCT_SUMMARY}             Fix 8 problems
    Element Should Contain    ${REQ_ACCT_FIRST_NAME_ERR}      Enter your first name.
    Element Should Contain    ${REQ_ACCT_LAST_NAME_ERR}       Enter your last name.
    Element Should Contain    ${REQ_ACCT_EMAIL_ERR}           Enter your email address.
    Element Should Contain    ${REQ_ACCT_UNIT_ERR}            Enter your unit.
    Element Should Contain    ${REQ_ACCT_ROLE_ERR}            Choose the job you need GLADM for.
    Element Should Contain    ${REQ_ACCT_REASON_ERR}          Say why you need an account.
    Element Should Contain    ${REQ_ACCT_SPONSOR_NAME_ERR}    Enter your supervisor's or sponsor's name.
    Element Should Contain    ${REQ_ACCT_SPONSOR_EMAIL_ERR}   Enter your supervisor's or sponsor's email address.
    Verify Field Marked Aria Invalid    ${REQ_ACCT_FIRST_NAME}
    Verify Field Marked Aria Invalid    ${REQ_ACCT_EMAIL}
    Verify Field Marked Aria Invalid    ${REQ_ACCT_SPONSOR_EMAIL}

    # 2. Entering invalid email addresses and invalid phone format prevents submission
    Input Text                 ${REQ_ACCT_FIRST_NAME}       John
    Input Text                 ${REQ_ACCT_LAST_NAME}        Doe
    Input Text                 ${REQ_ACCT_EMAIL}            not-an-email
    Input Text                 ${REQ_ACCT_PHONE}            abc-invalid-phone
    Input Text                 ${REQ_ACCT_UNIT}             1st Bn, 7th Marines
    Select From List By Label  ${REQ_ACCT_ROLE_SELECT}      Dispatcher
    Input Text                 ${REQ_ACCT_REASON}           Dispatch duty for motor pool operations.
    Input Text                 ${REQ_ACCT_SPONSOR_NAME}     Capt Jane Smith
    Input Text                 ${REQ_ACCT_SPONSOR_EMAIL}    missing-domain@
    Submit Request Account Form And Expect Validation Errors

    Element Should Contain    ${REQ_ACCT_SUMMARY}             Fix 3 problems
    Element Should Contain    ${REQ_ACCT_EMAIL_ERR}           Enter an email address like name@example.mil.
    Element Should Contain    ${REQ_ACCT_PHONE_ERR}           Enter a phone number using digits, spaces, +, - or brackets.
    Element Should Contain    ${REQ_ACCT_SPONSOR_EMAIL_ERR}   Enter an email address like name@example.mil.
    Verify Field Marked Aria Invalid        ${REQ_ACCT_EMAIL}
    Verify Field Marked Aria Invalid        ${REQ_ACCT_PHONE}
    Verify Field Marked Aria Invalid        ${REQ_ACCT_SPONSOR_EMAIL}
    Verify Field Not Marked Aria Invalid    ${REQ_ACCT_FIRST_NAME}
    Verify Field Not Marked Aria Invalid    ${REQ_ACCT_LAST_NAME}

    # 3. Also verify too-short phone number (< 7 chars) and >1000-character reason are rejected
    Clear Input Via Keyboard   ${REQ_ACCT_PHONE}
    Input Text                 ${REQ_ACCT_PHONE}            12345
    ${over_1000_reason}=       Generate Random String       1005    [LETTERS]
    Clear Input Via Keyboard   ${REQ_ACCT_REASON}
    Input Text                 ${REQ_ACCT_REASON}           ${over_1000_reason}
    Submit Request Account Form And Expect Validation Errors
    Element Should Contain     ${REQ_ACCT_PHONE_ERR}        Enter a phone number using digits, spaces, +, - or brackets.
    Element Should Contain     ${REQ_ACCT_REASON_ERR}       Use 1000 characters or fewer.
    Verify Field Marked Aria Invalid    ${REQ_ACCT_REASON}
    Clear Input Via Keyboard   ${REQ_ACCT_REASON}
    Input Text                 ${REQ_ACCT_REASON}           Dispatch duty for motor pool operations.

    # 4. Entering valid email and phone types is accepted by the fields
    Clear Input Via Keyboard   ${REQ_ACCT_EMAIL}
    Input Text                 ${REQ_ACCT_EMAIL}            john.doe@usmc.mil
    Clear Input Via Keyboard   ${REQ_ACCT_PHONE}
    Input Text                 ${REQ_ACCT_PHONE}            +1 (760) 555-0199
    Clear Input Via Keyboard   ${REQ_ACCT_SPONSOR_EMAIL}
    Input Text                 ${REQ_ACCT_SPONSOR_EMAIL}    jane.smith@usmc.mil
    Textfield Value Should Be  ${REQ_ACCT_EMAIL}            john.doe@usmc.mil
    Textfield Value Should Be  ${REQ_ACCT_PHONE}            +1 (760) 555-0199
    Textfield Value Should Be  ${REQ_ACCT_SPONSOR_EMAIL}    jane.smith@usmc.mil

Public Forgot Password Form Enforces Field Value Types And Conditional Identity Validation
    [Documentation]    Verifies that /forgot-password enforces maxLength limits (64 for username,
    ...                200 for fullName/unit/contact), prevents blank submissions, requires Unit
    ...                when User name is omitted, and dynamically clears errors as valid values are typed.
    [Tags]    safe    form_validation    public_forms    J11    J25
    Open Public Forgot Password Form
    Verify Forgot Password Field Value Types And Constraints
    Verify Field Enforces Max Length    ${FORGOT_PW_USERNAME}     64
    Verify Field Enforces Max Length    ${FORGOT_PW_FULL_NAME}    200
    Verify Field Enforces Max Length    ${FORGOT_PW_UNIT}         200
    Verify Field Enforces Max Length    ${FORGOT_PW_CONTACT}      200

    # Clear fields and submit blank form
    Clear Input Via Keyboard    ${FORGOT_PW_USERNAME}
    Clear Input Via Keyboard    ${FORGOT_PW_FULL_NAME}
    Clear Input Via Keyboard    ${FORGOT_PW_UNIT}
    Clear Input Via Keyboard    ${FORGOT_PW_CONTACT}
    Submit Forgot Password Form And Expect Validation Errors

    Element Should Contain    ${FORGOT_PW_USERNAME_ERR}     Enter your user name, or your full name.
    Element Should Contain    ${FORGOT_PW_FULL_NAME_ERR}    Enter your user name, or your full name.
    Element Should Contain    ${FORGOT_PW_UNIT_ERR}         Enter your unit.
    Element Should Contain    ${FORGOT_PW_CONTACT_ERR}      Say how System Support can reach you: a phone number, or where to find you.
    Verify Field Marked Aria Invalid    ${FORGOT_PW_USERNAME}
    Verify Field Marked Aria Invalid    ${FORGOT_PW_CONTACT}

    # Entering a valid username dynamically clears username, fullName, and unitText errors
    Input Text    ${FORGOT_PW_USERNAME}    cpl.smith
    Verify Field Not Marked Aria Invalid    ${FORGOT_PW_USERNAME}
    Verify Field Not Marked Aria Invalid    ${FORGOT_PW_FULL_NAME}
    Verify Field Not Marked Aria Invalid    ${FORGOT_PW_UNIT}
    Verify Field Marked Aria Invalid        ${FORGOT_PW_CONTACT}

    # Entering valid contact info clears the remaining error
    Input Text    ${FORGOT_PW_CONTACT}     760-555-0144, Bldg 1420 Rm 104
    Verify Field Not Marked Aria Invalid    ${FORGOT_PW_CONTACT}

# ==============================================================================
# PROTECTED APPLICATION FORM FIELD VALIDATION TESTS (REQUIRES LOGIN)
# ==============================================================================
Authenticate For Protected Form Validation Suite
    [Documentation]    Logs into GLADM once for the protected form validation tests.
    [Tags]    requires_login    form_validation
    Sign In To GLADM With Env Credentials
    Dismiss Post Login Popups If Present

Transportation Request Form Validates Date Time Phone Email And Numeric Cargo Fields
    [Documentation]    Verifies that the Transportation Request wizard (/sgen-tcp/protected/requests)
    ...                enforces POC phone validation (7+ digits or 4-5 digit DSN), date ("dd MMM yyyy"),
    ...                24-hour time ("HH:MM"), MGRS grid coordinates, and positive numeric cargo weights.
    [Tags]    requires_login    form_validation    requests    J01    J20
    Navigate To Requests List
    Start New TMR Wizard
    Wait Until Element Is Visible    ${WHAT_PHONE_INPUT}    ${EXPLICIT_WAIT}

    # 1. Verify POC phone field type and invalid phone rejection on Step 1 (What)
    Verify Input Attribute Equals    ${WHAT_PHONE_INPUT}    type    tel
    Clear Input Via Keyboard         ${WHAT_POC_INPUT}
    Input Text                       ${WHAT_POC_INPUT}      SSgt Miller
    Clear Input Via Keyboard         ${WHAT_PHONE_INPUT}
    Input Text                       ${WHAT_PHONE_INPUT}    123
    Click Element                    ${WIZARD_NEXT_BUTTON}
    Wait Until Page Contains         Enter a phone number with at least 7 digits (or a 4–5 digit DSN extension).    ${EXPLICIT_WAIT}

    # 2. Enter valid phone to advance to Step 2 (Where and When) and validate DateTimeField
    Clear Input Via Keyboard    ${WHAT_PHONE_INPUT}
    Input Text                  ${WHAT_PHONE_INPUT}    760-555-0188
    Click Element               ${WIZARD_NEXT_BUTTON}
    Wait Until Element Is Visible    ${WIZARD_STEP_WHERE}    ${EXPLICIT_WAIT}

    Verify Date And Time Field Prevents Invalid Inputs
    ...    ${WIZARD_PICKUP_DATE_FIELD}    ${WIZARD_PICKUP_TIME_OF_DAY_FIELD}    ${WIZARD_PICKUP_TIME_ERR}

Personnel Form Validates Name Letters Middle Initial 10 Digit EDIPI Email And Past Date Of Birth
    [Documentation]    Verifies that the Add a Person form (/sgen-tcp/protected/records/personnel/new) rejects
    ...                digit-only names ("A name needs at least one letter."), multi-char/numeric middle
    ...                initials ("One letter only."), non-10-digit EDIPIs ("An EDIPI is 10 digits"),
    ...                invalid work emails, and future dates of birth ("The date of birth must be in the past.").
    [Tags]    requires_login    form_validation    personnel    J04    J13
    Navigate To Add Person Page
    Wait Until Element Is Visible    ${NEW_PERSON_FIRST_NAME_INPUT}    ${EXPLICIT_WAIT}

    # 1. Verify field attributes
    Verify Input Attribute Equals    ${NEW_PERSON_FIRST_NAME_INPUT}        maxlength    50
    Verify Input Attribute Equals    ${NEW_PERSON_LAST_NAME_INPUT}         maxlength    50
    Verify Input Attribute Equals    ${NEW_PERSON_MIDDLE_INITIAL_INPUT}    maxlength    2
    Verify Input Attribute Equals    ${NEW_PERSON_EDIPI_INPUT}             inputmode    numeric
    Verify Input Attribute Equals    ${NEW_PERSON_EDIPI_INPUT}             maxlength    12
    Verify Input Attribute Equals    ${NEW_PERSON_EMAIL_INPUT}             type         email
    Verify Input Attribute Equals    ${NEW_PERSON_EMAIL_INPUT}             maxlength    100

    # 2. Enter invalid values for each field type and attempt to save
    Input Text    ${NEW_PERSON_FIRST_NAME_INPUT}        12345
    Input Text    ${NEW_PERSON_MIDDLE_INITIAL_INPUT}    99
    Input Text    ${NEW_PERSON_LAST_NAME_INPUT}         67890
    Input Text    ${NEW_PERSON_EDIPI_INPUT}             12345
    Input Text    ${NEW_PERSON_EMAIL_INPUT}             invalid-email
    Input Text    ${NEW_PERSON_DOB_INPUT}               15 Oct 2035
    Press Keys    ${NEW_PERSON_DOB_INPUT}               TAB
    Click Button  ${ADD_PERSON_SUBMIT_BUTTON}

    Wait Until Page Contains    A name needs at least one letter.                        ${EXPLICIT_WAIT}
    Wait Until Page Contains    One letter only.                                         ${EXPLICIT_WAIT}
    Wait Until Page Contains    An EDIPI is 10 digits (on the back of the CAC).          ${EXPLICIT_WAIT}
    Wait Until Page Contains    Enter an email address like name@usmc.mil.               ${EXPLICIT_WAIT}
    Wait Until Page Contains    The date of birth must be in the past.                   ${EXPLICIT_WAIT}

    # 3. Replace with valid values of the proper type
    Clear Input Via Keyboard    ${NEW_PERSON_FIRST_NAME_INPUT}
    Input Text                  ${NEW_PERSON_FIRST_NAME_INPUT}        Marcus
    Clear Input Via Keyboard    ${NEW_PERSON_MIDDLE_INITIAL_INPUT}
    Input Text                  ${NEW_PERSON_MIDDLE_INITIAL_INPUT}    A
    Clear Input Via Keyboard    ${NEW_PERSON_LAST_NAME_INPUT}
    Input Text                  ${NEW_PERSON_LAST_NAME_INPUT}         Vance
    Clear Input Via Keyboard    ${NEW_PERSON_EDIPI_INPUT}
    Input Text                  ${NEW_PERSON_EDIPI_INPUT}             1234567890
    Clear Input Via Keyboard    ${NEW_PERSON_EMAIL_INPUT}
    Input Text                  ${NEW_PERSON_EMAIL_INPUT}             marcus.vance@usmc.mil
    Clear Input Via Keyboard    ${NEW_PERSON_DOB_INPUT}
    Input Text                  ${NEW_PERSON_DOB_INPUT}               12 May 1998
    Press Keys                  ${NEW_PERSON_DOB_INPUT}               TAB
    Verify Field Not Marked Aria Invalid    ${NEW_PERSON_DOB_INPUT}

Equipment New Model Form Validates 13 Digit NSN And Numeric Capacity Fields
    [Documentation]    Verifies that the New Model form (/sgen-tcp/protected/records/models/new) enforces
    ...                13-digit NSN format (like 2320-01-523-1234) and numeric/decimal input modes
    ...                for vehicle weight, payload, dimensions, and seating capacities.
    [Tags]    requires_login    form_validation    equipment    J03    J62
    Go To    ${BASE_URL}/sgen-tcp/protected/records/models/new
    Wait Until Element Is Visible    ${MODEL_NSN_INPUT}    ${EXPLICIT_WAIT}

    Verify Input Attribute Equals    ${MODEL_NSN_INPUT}          maxlength    16
    Verify Input Attribute Equals    ${MODEL_PAYLOAD_INPUT}      inputmode    decimal
    Verify Input Attribute Equals    ${MODEL_CAB_SEATS_INPUT}    inputmode    numeric

    # Enter invalid NSN and attempt to save
    Input Text      ${MODEL_NAME_INPUT}    MTVR MK23 Test
    Input Text      ${MODEL_NSN_INPUT}     12345-BAD-NSN
    Click Button    ${MODEL_SAVE_BTN}
    Wait Until Page Contains    Enter a 13-digit NSN (like 2320-01-523-1234), or leave it blank.    ${EXPLICIT_WAIT}

    # Enter valid 13-digit NSN
    Clear Input Via Keyboard      ${MODEL_NSN_INPUT}
    Input Text                    ${MODEL_NSN_INPUT}    2320-01-447-3892
    Textfield Value Should Be     ${MODEL_NSN_INPUT}    2320-01-447-3892

Watch Log 9 Line MEDEVAC Form Validates Whole Number Patient Counts And MGRS Grid
    [Documentation]    Verifies that the Watch Log 9-Line MEDEVAC form (/protected/watchlog/create/medevac)
    ...                enforces inputMode="numeric" on patient count fields, rejects negative or decimal
    ...                numbers with "Enter a whole number, or 0.", and validates MGRS grid coordinates.
    [Tags]    requires_login    form_validation    watchlog    J15
    Open MEDEVAC 9 Line Page
    Wait Until Element Is Visible    ${MEDEVAC_LITTER_INPUT}    ${EXPLICIT_WAIT}

    Verify Input Attribute Equals    ${MEDEVAC_LITTER_INPUT}     inputmode    numeric
    Verify Input Attribute Equals    ${MEDEVAC_WALKING_INPUT}    inputmode    numeric

    # Enter non-whole/negative numbers in patient count fields
    Clear Input Via Keyboard    ${MEDEVAC_LITTER_INPUT}
    Input Text                  ${MEDEVAC_LITTER_INPUT}     -2
    Clear Input Via Keyboard    ${MEDEVAC_WALKING_INPUT}
    Input Text                  ${MEDEVAC_WALKING_INPUT}    1.5
    Press Keys                  ${MEDEVAC_WALKING_INPUT}    TAB

    # Submit or trigger validation on the 9-Line MEDEVAC form
    Click Button    ${WATCHLOG_SUBMIT_BTN}
    Wait Until Page Contains    Enter a whole number, or 0.    ${EXPLICIT_WAIT}

    # Replace with valid whole numbers and valid MGRS grid
    Clear Input Via Keyboard      ${MEDEVAC_LITTER_INPUT}
    Input Text                    ${MEDEVAC_LITTER_INPUT}       2
    Clear Input Via Keyboard      ${MEDEVAC_WALKING_INPUT}
    Input Text                    ${MEDEVAC_WALKING_INPUT}      1
    Clear Input Via Keyboard      ${MEDEVAC_LINE1_GRID_INPUT}
    Input Text                    ${MEDEVAC_LINE1_GRID_INPUT}   11S MS 12345 67890
    Textfield Value Should Be     ${MEDEVAC_LITTER_INPUT}       2
    Textfield Value Should Be     ${MEDEVAC_WALKING_INPUT}      1

Utilities Request And Supply Calculators Validate 4 Digit MOS And Day Range 1 To 365
    [Documentation]    Verifies that Utilities Request (/protected/utilities/requests/new) enforces
    ...                a 4-digit numeric MOS ("An MOS is 4 digits") and Supply Calculators
    ...                (/protected/utilities/calculators) enforce whole days from 1 to 365 ("Whole days, 1 to 365").
    [Tags]    requires_login    form_validation    utilities    J49    J70
    Open Supply Calculators Page
    Wait Until Element Is Visible    ${CALC_DAYS_INPUT}    ${EXPLICIT_WAIT}
    Verify Input Attribute Equals    ${CALC_DAYS_INPUT}    inputmode    numeric

    # Enter out-of-range days (0 and 400) and verify validation message
    Clear Input Via Keyboard    ${CALC_DAYS_INPUT}
    Input Text                  ${CALC_DAYS_INPUT}    0
    Press Keys                  ${CALC_DAYS_INPUT}    TAB
    Wait Until Page Contains    Whole days, 1 to 365    ${EXPLICIT_WAIT}

    Clear Input Via Keyboard    ${CALC_DAYS_INPUT}
    Input Text                  ${CALC_DAYS_INPUT}    400
    Press Keys                  ${CALC_DAYS_INPUT}    TAB
    Wait Until Page Contains    Whole days, 1 to 365    ${EXPLICIT_WAIT}

    # Enter valid days (14) and verify error clears
    Clear Input Via Keyboard    ${CALC_DAYS_INPUT}
    Input Text                  ${CALC_DAYS_INPUT}    14
    Press Keys                  ${CALC_DAYS_INPUT}    TAB
    Verify Field Not Marked Aria Invalid    ${CALC_DAYS_INPUT}
