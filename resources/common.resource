*** Settings ***
Documentation     Shared keywords for browser lifecycle and common UI interactions.
Library           SeleniumLibrary
Resource          ../variables/config.resource

*** Keywords ***
Open Test Browser
    [Documentation]    Opens the configured browser and navigates to the base URL.
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    IF    ${HEADLESS}
        Call Method    ${options}    add_argument    --headless\=new
        Call Method    ${options}    add_argument    --no-sandbox
        Call Method    ${options}    add_argument    --disable-dev-shm-usage
    END
    IF    ${IGNORE_CERT_ERRORS}
        Call Method    ${options}    add_argument    --ignore-certificate-errors
    END
    ${use_proxy}=    Get Variable Value    ${PROXY_SERVER}    ${EMPTY}
    IF    '${use_proxy}' != '${EMPTY}'
        Call Method    ${options}    add_argument    --proxy-server\=${use_proxy}
    END
    Call Method    ${options}    add_argument    --window-size\=1920,1080
    Open Browser    ${BASE_URL}    ${BROWSER}    options=${options}
    Set Selenium Implicit Wait    ${IMPLICIT_WAIT}
    Set Selenium Timeout          ${SELENIUM_TIMEOUT}

Close Test Browser
    [Documentation]    Closes all open browsers at the end of a test or suite.
    Close All Browsers
