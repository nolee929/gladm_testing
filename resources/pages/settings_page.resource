*** Settings ***
Documentation     Page Object for GLADM User Settings (J32 Display Settings & J47 Notification Settings):
...               Display settings (/protected/settings/display) and Notifications
...               (/protected/settings/notifications).
Library           SeleniumLibrary
Resource          ../../variables/config.resource

*** Variables ***
${DISPLAY_SETTINGS_URL}             ${BASE_URL}/protected/settings/display
${NOTIFICATION_SETTINGS_URL}        ${BASE_URL}/protected/settings/notifications

# Display Settings Locators (J32)
${DISPLAY_SETTINGS_HEADING}         xpath=//h1[normalize-space()='Display settings']
${DISPLAY_SAVED_BADGE}              css=[data-slot='display-saved']
${DISPLAY_RESET_DEFAULTS_BTN}       xpath=//button[normalize-space()='Reset to defaults']

# Notification Settings Locators (J47)
${NOTIFICATIONS_HEADING}            xpath=//h1[normalize-space()='Notifications' or normalize-space()='Notification settings']
${NOTIF_INBOX_SECTION}              id=notif-inbox
${NOTIF_SAVED_BADGE}                css=[data-slot='notif-saved']
${NOTIF_RESET_DEFAULTS_BTN}         xpath=//button[normalize-space()='Reset to defaults']

*** Keywords ***
Open Display Settings Page
    [Documentation]    Navigates directly to Display settings (/protected/settings/display).
    Go To    ${DISPLAY_SETTINGS_URL}
    Wait Until Element Is Visible    ${DISPLAY_SETTINGS_HEADING}    timeout=${SELENIUM_TIMEOUT}

Verify Display Settings Sections
    [Documentation]    Verifies Grid format, Distances, Speeds, Second time zone, and Reset to defaults.
    Wait Until Element Is Visible    ${DISPLAY_SETTINGS_HEADING}    timeout=${SELENIUM_TIMEOUT}
    Page Should Contain              Grid format
    Page Should Contain              Distances
    Page Should Contain              Speeds
    Page Should Contain              Second time zone
    Element Should Be Visible        ${DISPLAY_RESET_DEFAULTS_BTN}

Open Notification Settings Page
    [Documentation]    Navigates directly to Notification settings (/protected/settings/notifications).
    Go To    ${NOTIFICATION_SETTINGS_URL}
    Wait Until Element Is Visible    ${NOTIFICATIONS_HEADING}    timeout=${SELENIUM_TIMEOUT}

Verify Notification Settings Sections
    [Documentation]    Verifies Waiting on you task switches, Daily e-mail summary, and Reset to defaults.
    Wait Until Element Is Visible    ${NOTIFICATIONS_HEADING}    timeout=${SELENIUM_TIMEOUT}
    Page Should Contain              Waiting on you
    Page Should Contain              E-mail me a daily summary
    Element Should Be Visible        ${NOTIF_RESET_DEFAULTS_BTN}
