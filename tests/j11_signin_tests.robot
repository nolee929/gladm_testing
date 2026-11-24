*** Settings ***
Documentation     J11: Sign-in, DoD Notice and Consent, and Session Tests.
...               NOTE: By default, only non-credential or single-attempt tests run to prevent account lockouts.
Resource          ../resources/common.resource
Resource          ../resources/pages/login_page.resource
Resource          ../resources/pages/navigation_page.resource

Test Setup        Open Test Browser
Test Teardown     Close Test Browser

*** Test Cases ***
Step 1: DoD Notice And Consent Should Appear Before Sign In
    [Documentation]    J11 Step 1 (R315): Verify the DoD Notice and Consent page, classification banners,
    ...                and 'I agree' button appear before any sign-in fields. (Does not attempt login).
    [Tags]    smoke    J11    R315    safe
    Verify DoD Notice And Consent Page

Step 1 To 2: Accepting DoD Notice Should Redirect To Keycloak Sign In
    [Documentation]    J11 Step 1-2 (R315, R458): Verify clicking 'I agree' redirects to 'Sign in to GLADM'
    ...                with Username, Password, Forgot password, and Request access links. (Does not submit credentials).
    [Tags]    smoke    J11    R315    R458    safe
    Accept DoD Notice And Consent
    Wait Until Element Is Visible    ${KC_USERNAME_INPUT}
    Title Should Be                  Sign in to GLADM
    Element Should Be Visible        ${KC_PASSWORD_INPUT}
    Element Should Be Visible        ${KC_SIGN_IN_BUTTON}
    Element Should Be Visible        ${KC_FORGOT_PASSWORD_LINK}
    Element Should Be Visible        ${KC_REQUEST_ACCESS_LINK}

Step 18 To 19: Request Account Workflow Is Accessible Without Login
    [Documentation]    J11 Steps 18-19 (R462, R464, R467): Verify users can reach the account request form.
    [Tags]    smoke    J11    R462    R464    safe
    Verify Request Account Page Accessible

Step 20: Forgot Password Workflow Is Accessible With Lost Authenticator Option
    [Documentation]    J11 Step 20 (R458): Verify users can reach the password recovery form and report a lost authenticator.
    [Tags]    smoke    J11    R458    safe
    Verify Forgot Password Page Accessible

Step 2 To 3: Sign In With Credentials And One Time Code
    [Documentation]    J11 Step 2-3 (R458): Signs in using .env credentials and prompts once for the 6-digit OTP code.
    [Tags]    J11    R458    requires_login
    Sign In To GLADM With Env Credentials
    Dismiss Post Login Popups If Present
