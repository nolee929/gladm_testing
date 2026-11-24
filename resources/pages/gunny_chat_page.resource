*** Settings ***
Documentation     Page Object for GLADM Gunny AI Assistant & Team Chat (J30, J34, J35):
...               Gunny top-bar assistant panel, What Gunny can do (/protected/help/gunny),
...               Gunny-to-Map links, Team Chat links, and What's new (/protected/help/whats-new).
Library           SeleniumLibrary
Resource          ../../variables/config.resource

*** Variables ***
${WHAT_GUNNY_CAN_DO_URL}            ${BASE_URL}/protected/help/gunny
${WHATS_NEW_URL}                    ${BASE_URL}/protected/help/whats-new

# Gunny Assistant Locators (J30, J34)
${GUNNY_TOP_BAR_BTN}                xpath=//*[@data-slot='assistant-button'] | //button[contains(@aria-label,'Gunny')]
${GUNNY_PANEL}                      xpath=//*[@aria-label='Gunny (AI assistant)' or @aria-label='Conversation']
${GUNNY_QUESTION_INPUT}             xpath=//textarea[contains(@placeholder,'Ask Gunny')] | //input[contains(@placeholder,'Ask Gunny')]
${GUNNY_SKIP_TOUR_BTN}              xpath=//button[normalize-space()='Skip tour' or normalize-space()='Start asking']
${GUNNY_CHATS_BTN}                  xpath=//button[normalize-space()='Chats' or @aria-label='Your chats']
${WHAT_GUNNY_HEADING}               xpath=//h1[normalize-space()='What Gunny can do']
${GUNNY_SAFETY_HEADING}             id=gunny-safety-title
${GUNNY_ASK_HEADING}                id=gunny-ask-title

# Team Chat & What's New Locators (J35)
${WHATS_NEW_HEADING}                xpath=//h1[normalize-space()="What's new"]
${WHATS_NEW_SEARCH_INPUT}           xpath=//input[@placeholder='For example: missions, export, phone']
${WHATS_NEW_RELEASE_DAY}            css=[data-slot='release-day']
${CHAT_TOP_BAR_LINK}                xpath=//a[contains(@aria-label,'Chat') or normalize-space()='Chat'] | //button[contains(@aria-label,'Chat')]

*** Keywords ***
Open What Gunny Can Do Page
    [Documentation]    Navigates directly to What Gunny can do (/protected/help/gunny).
    Go To    ${WHAT_GUNNY_CAN_DO_URL}
    Wait Until Element Is Visible    ${WHAT_GUNNY_HEADING}     timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${GUNNY_SAFETY_HEADING}   timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${GUNNY_ASK_HEADING}      timeout=${SELENIUM_TIMEOUT}

Open Gunny Panel If Enabled
    [Documentation]    Opens the Gunny panel from the top bar if Gunny is enabled for the user/site,
    ...                and skips the first-time tour if shown.
    ${has_gunny}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${GUNNY_TOP_BAR_BTN}    timeout=5s
    IF    ${has_gunny}
        Click Element    ${GUNNY_TOP_BAR_BTN}
        Wait Until Element Is Visible    ${GUNNY_PANEL}    timeout=${SELENIUM_TIMEOUT}
        ${has_tour}=    Run Keyword And Return Status    Element Should Be Visible    ${GUNNY_SKIP_TOUR_BTN}
        IF    ${has_tour}
            Click Element    ${GUNNY_SKIP_TOUR_BTN}
        END
    END

Open Whats New Page And Search
    [Documentation]    Navigates to What's new (/protected/help/whats-new) and filters release notes.
    [Arguments]    ${search_term}
    Go To    ${WHATS_NEW_URL}
    Wait Until Element Is Visible    ${WHATS_NEW_HEADING}         timeout=${SELENIUM_TIMEOUT}
    Wait Until Element Is Visible    ${WHATS_NEW_SEARCH_INPUT}    timeout=${SELENIUM_TIMEOUT}
    Clear Element Text               ${WHATS_NEW_SEARCH_INPUT}
    Input Text                       ${WHATS_NEW_SEARCH_INPUT}    ${search_term}
