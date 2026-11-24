*** Settings ***
Documentation     Gunny AI Assistant & Team Chat Test Suite (Journeys J30, J34, and J35):
...               Verifies What Gunny can do (/protected/help/gunny), Gunny top-bar assistant panel
...               and map integration (J30, J34), and What's new & Team Chat links (J35).
Resource          ../resources/common.resource
Resource          ../resources/pages/login_page.resource
Resource          ../resources/pages/navigation_page.resource
Resource          ../resources/pages/gunny_chat_page.resource
Suite Setup       Open Authenticated Gunny Session
Suite Teardown    Close Test Browser

*** Keywords ***
Open Authenticated Gunny Session
    [Documentation]    Opens the browser, logs in once, and dismisses post-login popups.
    Open Test Browser
    Sign In To GLADM With Env Credentials
    Dismiss Post Login Popups If Present

*** Test Cases ***
J30-01 Verify What Gunny Can Do Help Page Loads
    [Documentation]    Navigates to What Gunny can do (/protected/help/gunny) and verifies the safety
    ...                explanation and example questions sections.
    [Tags]    j30    gunny    help    requires_login
    Open What Gunny Can Do Page

J30-02 And J34-01 Verify Gunny Assistant Panel Opens If Enabled
    [Documentation]    Checks if Gunny is enabled for the current site/user, opens the Gunny assistant
    ...                panel, skips the first-time tour if shown, and verifies the question input (J30, J34).
    [Tags]    j30    j34    gunny    assistant    requires_login
    Open Gunny Panel If Enabled

J35-01 Verify Whats New Page And Chat Release Notes Search
    [Documentation]    Navigates to What's new (/protected/help/whats-new) and searches release notes
    ...                for chat and team chat updates (J35).
    [Tags]    j35    team_chat    whats_new    requires_login
    Open Whats New Page And Search    chat
