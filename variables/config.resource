*** Settings ***
Documentation     Global configuration variables for the GLADM test suite.

*** Variables ***
${BASE_URL}             https://gladm.defconai.dev
${DOCS_URL}             ${BASE_URL}/sgen-tcp/docs/index.html
${BROWSER}              chrome
${HEADLESS}             ${False}
${IGNORE_CERT_ERRORS}   ${True}
${IMPLICIT_WAIT}        5s
${EXPLICIT_WAIT}        15s
${SELENIUM_TIMEOUT}     15s
${OTP_TIMEOUT}          120s
${ENV_FILE}             ${CURDIR}/../.env
