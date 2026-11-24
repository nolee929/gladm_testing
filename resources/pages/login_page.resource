*** Settings ***
Documentation     Page Object for the GLADM DoD Notice and Consent wrapper and Keycloak OIDC Sign-In (J11).
Library           SeleniumLibrary
Library           OperatingSystem
Library           String
Resource          ../../variables/config.resource

*** Variables ***
# Step 1: DoD Notice and Consent (/login)
${CLASSIFICATION_BANNER}        css:[data-testid="classification-banner"]
${DOD_CONSENT_HEADING}          xpath://main/h1[contains(text(), 'DoD Notice and Consent')]
${DOD_AGREE_BUTTON}             css:button[name="consent"][value="agree"]
${REQUEST_ACCOUNT_NOTICE_LINK}  css:a[href="/request-account"]

# Step 2: Keycloak Username & Password (login.ftl)
${KC_PAGE_TITLE}                id:kc-page-title
${KC_USERNAME_INPUT}            id:username
${KC_PASSWORD_INPUT}            id:password
${KC_PASSWORD_TOGGLE}           id:password-show-password
${KC_SIGN_IN_BUTTON}            id:kc-login
${KC_FORGOT_PASSWORD_LINK}      id:gladm-forgot-password-link
${KC_REQUEST_ACCESS_LINK}       id:gladm-request-access-link

# Public Request Account & Forgot Password Pages (J11 Steps 18-20)
${REQUEST_ACCOUNT_URL}          ${BASE_URL}/request-account
${FORGOT_PASSWORD_URL}          ${BASE_URL}/forgot-password
${REQUEST_ACCOUNT_HEADING}      xpath://h1[contains(text(), 'Request an account') or contains(text(), 'Ask for a GLADM account')]
${FORGOT_PASSWORD_HEADING}      xpath://h1[contains(text(), 'Forgot your password?')]
${LOST_AUTHENTICATOR_CHECKBOX}  css:input[name="lostAuthenticator"], [data-slot="lost-authenticator"]
${SEND_REQUEST_BUTTON}          xpath://button[contains(., 'Send request')]
${BACK_TO_SIGNIN_LINK}          xpath://a[contains(text(), 'Back to sign in')]

*** Keywords ***
Verify Request Account Page Accessible
    [Documentation]    Verifies that the Request Account page loads and displays registration fields (J11 Steps 18-19 / R462).
    Go To                            ${REQUEST_ACCOUNT_URL}
    ${has_consent}=                  Run Keyword And Return Status    Wait Until Element Is Visible    ${DOD_AGREE_BUTTON}    timeout=5s
    IF    ${has_consent}
        Click Button                 ${DOD_AGREE_BUTTON}
    END
    Wait Until Page Contains Element    ${SEND_REQUEST_BUTTON}
    Element Should Be Visible        ${BACK_TO_SIGNIN_LINK}

Verify Forgot Password Page Accessible
    [Documentation]    Verifies that Forgot Password loads with the 'lost authenticator' option (J11 Step 20 / R458).
    Go To                            ${FORGOT_PASSWORD_URL}
    ${has_consent}=                  Run Keyword And Return Status    Wait Until Element Is Visible    ${DOD_AGREE_BUTTON}    timeout=5s
    IF    ${has_consent}
        Click Button                 ${DOD_AGREE_BUTTON}
    END
    Wait Until Page Contains Element    ${SEND_REQUEST_BUTTON}
    Page Should Contain              I also lost my authenticator app
    Element Should Be Visible        ${BACK_TO_SIGNIN_LINK}

Verify Classification Banners Present
    [Documentation]    Verifies that the top and bottom UNCLASSIFIED banners are visible (J11).
    Wait Until Element Is Visible    ${CLASSIFICATION_BANNER}
    Element Should Contain           ${CLASSIFICATION_BANNER}    UNCLASSIFIED

Verify DoD Notice And Consent Page
    [Documentation]    Verifies the DoD Notice and Consent wrapper is displayed (J11 Step 1 / R315).
    Wait Until Element Is Visible    ${DOD_CONSENT_HEADING}
    Title Should Be                  GLADM: DoD Notice and Consent
    Verify Classification Banners Present
    Element Should Be Visible        ${DOD_AGREE_BUTTON}
    Element Should Be Visible        ${REQUEST_ACCOUNT_NOTICE_LINK}

Accept DoD Notice And Consent
    [Documentation]    Clicks 'I agree' on the DoD Notice and Consent wrapper (J11 Step 1).
    Verify DoD Notice And Consent Page
    Click Button                     ${DOD_AGREE_BUTTON}

Load Credentials From Env File
    [Documentation]    Loads USERNAME, PASSWORD, and optional OTP from the local .env file.
    File Should Exist                ${ENV_FILE}    msg=Please create a .env file with USERNAME and PASSWORD.
    ${content}=                      Get File       ${ENV_FILE}
    @{lines}=                        Split To Lines    ${content}
    ${user}=                         Set Variable    ${EMPTY}
    ${pass}=                         Set Variable    ${EMPTY}
    ${otp}=                          Set Variable    ${EMPTY}
    FOR    ${line}    IN    @{lines}
        ${stripped}=    Strip String    ${line}
        IF    '${stripped}' != '' and not $stripped.startswith('#')
            @{parts}=    Split String    ${stripped}    separator==    max_split=1
            ${key}=      Strip String    ${parts}[0]
            ${val}=      Strip String    ${parts}[1]
            IF    '${key}' == 'USERNAME'
                ${user}=    Set Variable    ${val}
            ELSE IF    '${key}' == 'PASSWORD'
                ${pass}=    Set Variable    ${val}
            ELSE IF    '${key}' == 'OTP'
                ${otp}=     Set Variable    ${val}
            END
        END
    END
    Should Not Be Empty    ${user}    msg=USERNAME is missing in .env
    Should Not Be Empty    ${pass}    msg=PASSWORD is missing in .env
    RETURN    ${user}    ${pass}    ${otp}

Submit Keycloak Username And Password
    [Documentation]    Submits username and password on the Sign in to GLADM page (J11 Step 2 / R458).
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible    ${KC_USERNAME_INPUT}
    Title Should Be                  Sign in to GLADM
    Input Text                       ${KC_USERNAME_INPUT}    ${username}
    Input Password                   ${KC_PASSWORD_INPUT}    ${password}
    Click Button                     ${KC_SIGN_IN_BUTTON}

Submit One Time Code
    [Documentation]    Submits the 6-digit authenticator code, or waits for the user to type it in the browser/console (J11 Step 2b).
    [Arguments]    ${otp_code}=${EMPTY}
    Wait Until Element Is Visible    ${KC_OTP_INPUT}
    IF    '${otp_code}' != ''
        Input Text      ${KC_OTP_INPUT}    ${otp_code}
        Click Button    ${KC_SIGN_IN_BUTTON}
    ELSE
        Log To Console    \n[OTP REQUIRED] Please enter the 6-digit code in the browser window and click Sign In (waiting up to ${OTP_TIMEOUT})...
        Wait Until Element Is Not Visible    ${KC_OTP_INPUT}    timeout=${OTP_TIMEOUT}
    END

Sign In To GLADM With Env Credentials
    [Documentation]    Completes the full J11 sign-in flow (DoD Consent -> Username/Password -> 6-digit OTP).
    [Arguments]    ${otp_override}=${EMPTY}
    ${user}    ${pass}    ${env_otp}=    Load Credentials From Env File
    ${otp_to_use}=    Set Variable If    '${otp_override}' != ''    ${otp_override}    ${env_otp}
    Accept DoD Notice And Consent
    Submit Keycloak Username And Password    ${user}    ${pass}
    Submit One Time Code                     ${otp_to_use}
