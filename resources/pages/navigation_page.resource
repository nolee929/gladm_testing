*** Settings ***
Documentation     Page Object for GLADM main navigation, Today brief, and Test As position bar (J10, J11, J58).
Library           SeleniumLibrary

*** Variables ***
# Top Bar Navigation & Actions (J10)
${TOP_BAR}                      xpath://*[@data-slot="app-shell"]//header | //header
${SEARCH_INPUT_BUTTON}          xpath://button[contains(@aria-label, 'Search') or contains(., 'Search') or @data-slot="search-input"]
${NOTICES_BELL_BUTTON}          xpath://button[contains(@aria-label, 'Notifications') or @data-slot="notifications-badge"]
${NOTICES_PANEL}                xpath://*[@data-slot="notifications-panel"]
${FEEDBACK_BUTTON}              xpath://button[contains(@aria-label, 'Feedback') or contains(., 'Send feedback')]

# Account Menu Details (J10 Step 27, J11 Step 4-5)
${DISPLAY_SETTINGS_MENU_ITEM}   xpath://*[contains(text(), 'Display settings')]
${NOTIFICATION_SETTINGS_ITEM}   xpath://*[contains(text(), 'Notification settings')]
${CONTACT_INFO_MENU_ITEM}       xpath://*[contains(text(), 'Contact')]
${QUICK_SETTINGS_DRAWER}        xpath://*[@data-slot="quick-settings"]

# Left Rail & Sidebar (J10 Steps 4-5)
${LEFT_RAIL}                    xpath://*[@data-slot="rail"]
${SIDEBAR_BUTTON}               xpath://*[@data-slot="rail-sidebar"] | //button[contains(., 'Sidebar')]
${COLLAPSE_ALL_BUTTON}          xpath://*[@data-slot="nav-collapse-all"]

# Post-Login Popups (J11 Step 3a)
${ACCOUNT_MENU_BUTTON}          xpath://button[contains(@aria-label, 'Account') or contains(@aria-label, 'account') or @data-testid="account-menu"]
${TEST_AS_MENU_ITEM}            xpath://*[contains(text(), 'Test as')]
${NOTICES_POLICIES_MENU_ITEM}   xpath://*[contains(text(), 'Notices and policies')]
${SIGN_OUT_MENU_ITEM}           xpath://*[contains(text(), 'Sign out')]

# Post-Login Popups (J11 Step 3a)
${TOUR_NO_THANKS_BUTTON}        xpath://button[contains(., 'No thanks')]
${ANNOUNCEMENT_LATER_BUTTON}    xpath://button[contains(., 'Later') or contains(., "I've read this")]
${WHATS_NEW_GOT_IT_BUTTON}      xpath://button[contains(., 'Got it')]

# Test As Bar & Sheet (J58)
${START_TESTING_BUTTON}         xpath://button[contains(., 'Start testing')]
${TESTING_AS_BAR}               xpath://*[contains(text(), 'Testing as')]
${SWITCH_POSITION_BUTTON}       xpath://button[contains(., 'Switch')]
${STOP_TESTING_BUTTON}          xpath://button[contains(., 'Stop')]

*** Keywords ***
Open Display Settings
    [Documentation]    Opens Display settings from the Account menu and verifies the quick-settings panel (J10 Step 27).
    Open Account Menu
    Wait Until Element Is Visible    ${DISPLAY_SETTINGS_MENU_ITEM}
    Click Element                    ${DISPLAY_SETTINGS_MENU_ITEM}
    Wait Until Element Is Visible    ${QUICK_SETTINGS_DRAWER}

Open Notifications Bell
    [Documentation]    Opens the notifications bell dropdown (J10 Step 11 / R449).
    Wait Until Element Is Visible    ${NOTICES_BELL_BUTTON}
    Click Element                    ${NOTICES_BELL_BUTTON}
    Wait Until Element Is Visible    ${NOTICES_PANEL}

Dismiss Post Login Popups If Present
    [Documentation]    Closes optional post-sign-in popups (Tour offer, Site announcements, What's new - J11 Step 3a).
    ${has_announcement}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${ANNOUNCEMENT_LATER_BUTTON}    timeout=3s
    IF    ${has_announcement}
        Click Button    ${ANNOUNCEMENT_LATER_BUTTON}
    END
    ${has_whats_new}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${WHATS_NEW_GOT_IT_BUTTON}    timeout=2s
    IF    ${has_whats_new}
        Click Button    ${WHATS_NEW_GOT_IT_BUTTON}
    END
    ${has_tour}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${TOUR_NO_THANKS_BUTTON}    timeout=2s
    IF    ${has_tour}
        Click Button    ${TOUR_NO_THANKS_BUTTON}
    END

Open Account Menu
    [Documentation]    Opens the top-right user account menu.
    Wait Until Element Is Visible    ${ACCOUNT_MENU_BUTTON}
    Click Element                    ${ACCOUNT_MENU_BUTTON}

Start Test As Position
    [Documentation]    Uses 'Test as...' to switch into a target position (e.g., Dispatcher, Unit supervisor (S-4)) per J58.
    [Arguments]    ${position_name}
    Open Account Menu
    Wait Until Element Is Visible    ${TEST_AS_MENU_ITEM}
    Click Element                    ${TEST_AS_MENU_ITEM}
    ${position_locator}=             Set Variable    xpath://*[contains(text(), '${position_name}')]
    Wait Until Element Is Visible    ${position_locator}
    Click Element                    ${position_locator}
    Click Button                     ${START_TESTING_BUTTON}
    Wait Until Element Is Visible    ${TESTING_AS_BAR}

Stop Test As Position
    [Documentation]    Stops the active 'Test as' session and restores the user's normal roles (J58 Step 5).
    Wait Until Element Is Visible    ${STOP_TESTING_BUTTON}
    Click Button                     ${STOP_TESTING_BUTTON}
    Wait Until Element Is Not Visible    ${TESTING_AS_BAR}

Sign Out Of GLADM
    [Documentation]    Signs out via the Account menu and verifies return to the DoD Notice and Consent page (J11 Step 9).
    Open Account Menu
    Wait Until Element Is Visible    ${SIGN_OUT_MENU_ITEM}
    Click Element                    ${SIGN_OUT_MENU_ITEM}
