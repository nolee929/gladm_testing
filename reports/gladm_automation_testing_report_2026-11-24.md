Hi all,

Here’s my GLADM automated testing and form validation update for November 19–24. If you have any questions please let me know.

---

## Automated Testing Framework Overview

Since the November 18 baseline, I built and published a comprehensive **Robot Framework + SeleniumLibrary** end-to-end test automation framework for GLADM (`https://github.com/nolee929/gladm_testing`) using the **Page Object Model (POM)**.

Across this effort, I mirrored all **63 GLADM user journey guides (`J01`–`J70`)** and the **Requirements Traceability Matrix (`R001`–`R483`)**, authored **23 Page Object resource modules**, and built **26 automated test suites** covering **111 test cases**. All **111 of 111 test cases** pass full Robot Framework dry-run verification, and the unauthenticated public access and form-validation suites have been executed live against `https://gladm.defconai.dev`.

---

## User Journey Test Coverage (`J01`–`J70`)

I mapped all **63 unique user guides** into **25 journey test suites (102 journey test cases)** plus **1 dedicated Form Field Validation suite (9 test cases)**, bringing total automated coverage to **26 suites / 111 test cases**.

### Transportation Requests & Movement (`4 suites — 16 test cases`)
* **J01 – TMR Lifecycle (`tests/j01_tmr_lifecycle_tests.robot`)**: 4/4 test cases completed. Covers creating and saving a complete draft TMR, submitting to a supporting unit and verifying the approval chain, recalling a submitted TMR back to draft, and verifying the Archive bin and Request Board view (`R002`, `R014`, `R016`, `R410`).
* **J05 – GTR Lifecycle (`tests/j05_gtr_lifecycle_tests.robot`)**: 3/3 test cases completed. Covers starting a new GTR, filling What/Where/Convoy/Route steps, saving a draft GTR, and verifying the GTR Review queue across Battlespace, MMCC, and FTB tabs.
* **J16 – LSR Lifecycle (`tests/j16_lsr_lifecycle_tests.robot`)**: 3/3 test cases completed. Covers starting a new LSR, adding Supply/Maintenance line items, saving a draft, submitting, and verifying the recall action.
* **J20 – Asking for Transport (`tests/j20_requests_tests.robot`)**: 6/6 test cases completed. Covers Requests list bins, search and More Filters, phone validation on the What step, Where and When route-choice help, cargo lines, optional funding, and review readiness.

### Missions, Capacity, Dispatch & Motor Pool (`4 suites — 13 test cases`)
* **J02 – Missions & Resource Assignment (`tests/j02_missions_tests.robot`)**: 3/3 test cases completed. Covers the 8 mission bins, creating a vehicles-only mission with duration validation, and verifying mission overview and tabs.
* **J06 – Transportation Capacity Board (`tests/j06_capacity_tests.robot`)**: 3/3 test cases completed. Covers scope bar, summary tiles, all-trucks table, Drivers view coverage, and the 30-day availability breakdown.
* **J08 – Dispatch & Master Log (`tests/j08_dispatch_tests.robot`)**: 4/4 test cases completed. Covers the Daily Master Log, This Day menu, NAVMC 10627 Trip Tickets, Master Log search/filters, and supervisor review/override views.
* **J40 – Motor Pool & Parking (`tests/j40_motor_pool_tests.robot`)**: 3/3 test cases completed. Covers the Motor Pool parking board, Find a Vehicle search, and the Set Up a Lot editor.

### Equipment, Personnel & Availability (`3 suites — 11 test cases`)
* **J03 – Equipment, TAMCNs & Models (`tests/j03_equipment_tests.robot`)**: 4/4 test cases completed. Covers Equipment list search/filters, all 7 vehicle profile tabs, Add a Vehicle required fields, and TAMCN/Model NSN and capacity checks.
* **J04 – Personnel & Licenses (`tests/j04_personnel_tests.robot`)**: 4/4 test cases completed. Covers Personnel roster search/filters, all 7 person profile tabs, Add a Person name/EDIPI validation, and Licenses lists/reports.
* **J07 – Availability Updates (`tests/j07_availability_tests.robot`)**: 3/3 test cases completed. Covers the 5-day Availability grid, Personnel/Equipment availability managers, and the Driver Availability report.

### Navigation, Sign-In, Settings, Reports & Safety (`5 suites — 21 test cases`)
* **J10 & J58 – Navigation, Today Brief & Test As (`tests/j10_navigation_tests.robot`)**: 5/5 test cases completed. Covers Today brief shell layout, sidebar toggle/groups, Notices bell, Display Settings menu, and Test As a Position role switching (`R163`, `R164`, `R449`).
* **J11 – Sign-In, DoD Notice & Session (`tests/j11_signin_tests.robot`)**: 5/5 test cases completed (4/4 unauthenticated tests verified live; 1/1 Keycloak + TOTP login flow). Covers DoD Notice and Consent (`R314`, `R315`), Keycloak OIDC redirect, public Request an Account (`R462`, `R464`, `R467`), and Forgot Password with lost authenticator checkbox (`R458`).
* **J09 – Reports & Exports (`tests/j09_reports_tests.robot`)**: 5/5 test cases completed. Covers Report Library categories/search, Comptroller and Cargo reports, Equipment Availability/Utilization/GCSS reports, Individual Operator Rollup/Driver Log, and Run Roster/Master Log/Data Summary reports.
* **J14 – Safety, Mishaps & Citations (`tests/j14_safety_tests.robot`)**: 4/4 test cases completed. Covers Mishaps list filters/search, Add a Mishap form fields, Citations current/archived views, and Add a Citation form fields (`R195`, `R256`).
* **J32 & J47 – Display & Notification Settings (`tests/j32_j47_settings_tests.robot`)**: 2/2 test cases completed. Covers Display Settings (theme, time format, map coordinates) and Notification Settings controls.

### Watch Log, Activity Log, Route/Map, Lift & Naval Planning (`4 suites — 18 test cases`)
* **J15 & J24 – Watch Log, Activity Log & Help (`tests/j15_watchlog_activity_tests.robot`)**: 5/5 test cases completed. Covers 24-hour Watch Log, 9-Line MEDEVAC entry form (`R170`), Watch Log summary and older entry search, Activity Log toolbar/chips, and Help/Capabilities/Glossary/Form Library.
* **J21, J26, J28, J31 & J36 – Route Planner, Operations Map & Tracks (`tests/j21_j31_route_map_tests.robot`)**: 5/5 test cases completed. Covers Route Planner trip form, Operations Map layers and Find/Lists panels, Report My Location check-in, Plan Network places, and Draw a Track.
* **J29, J33 & J64 – Lift & Move Planning (`tests/j29_j33_j64_planning_tests.robot`)**: 3/3 test cases completed. Covers Plan Moves builder, Solver Comparisons, and Plan the Move list/builder.
* **J41, J43, J44, J45 & J66 – Naval & MEU/ARG Planning (`tests/j41_j66_naval_tests.robot`)**: 5/5 test cases completed. Covers ARG Presence, Plan the Offload, MEU Sustainment, Plan MEU Resupply, and Fleet Schedule.

### Supply, Utilities, Gunny/Chat, LogC2 & Admin (`5 suites — 23 test cases`)
* **J18, J38, J39 & J70 – Supply App (`tests/j18_j38_j39_j70_supply_tests.robot`)**: 5/5 test cases completed. Covers LOGSTAT Stock/Views, Report LOGSTAT and spreadsheet upload, Bulk Fuel dashboard and Count Fuel, Ammunition dashboard (By DODIC / By location), and Supply Calculators.
* **J48–J57 – Utilities App (`tests/j48_j57_utilities_tests.robot`)**: 6/6 test cases completed. Covers Utilities Home, Ask for Utilities new request form, Utilities Requests queue, Utilities Operations, Utilities Board, and Dispatcher Activity / License Coverage reports.
* **J30, J34 & J35 – Gunny AI Assistant & Team Chat (`tests/j30_j34_j35_gunny_chat_tests.robot`)**: 3/3 test cases completed. Covers What Gunny Can Do help page, Gunny assistant panel, and What’s New / Chat release notes search.
* **J61, J62 & J63 – LogC2 (`tests/j61_j63_logc2_tests.robot`)**: 3/3 test cases completed. Covers Ground Troops operation status, Orders list and Receive Higher Order intake, and Task Organization phase board.
* **J12, J13, J17, J22, J23, J25, J27, J59, J60 & J65 – Admin & System Tools (`tests/j12_j13_j17_j22_j23_j25_j27_j59_j60_j65_admin_tests.robot`)**: 6/6 test cases completed. Covers Unit Settings, Unit Users, Account Management, System Health/Tools/Settings/Data Browser/Exercises, Bulk Imports, My Feedback, Data Feeds, Active Sessions, Time in GLADM, Practice Unit, Guide Checklists, and System Notices.

---

## Form Field & Input Type Validation (`tests/form_field_validation_tests.robot`)

I created a dedicated form validation Page Object (`resources/pages/form_validation_page.resource`) and test suite (`tests/form_field_validation_tests.robot`) with **9 test cases** to verify that GLADM form inputs declare the right HTML5/ARIA types (`type="email"`, `type="tel"`, `inputmode="numeric"`, `inputmode="decimal"`, `maxlength`, `aria-invalid="true"`) and reject invalid inputs based on their type:

### Public Forms — Executed Live (`3 of 3 passed`)
* **Request an Account (`/request-account`) — Field Types & MaxLength**: Verified `type="email"` and `inputmode="email"` on Work Email and Sponsor Email, `type="tel"` and `inputmode="tel"` on Phone, `rows="5"` on Reason, and character truncation at `maxLength` (`100` for First/Last/Sponsor Name, `30` for Phone, `200` for Unit).
* **Request an Account (`/request-account`) — Invalid Input Prevention**: Verified blank submission blocks and displays `"Fix 8 problems"`, rejects malformed emails (`"Enter an email address like name@example.mil."`), rejects invalid or too-short phone numbers (`"Enter a phone number using digits, spaces, +, - or brackets."`), rejects reasons over 1,000 characters (`"Use 1000 characters or fewer."`), marks invalid fields with `aria-invalid="true"`, and accepts valid inputs.
* **Forgot Password (`/forgot-password`) — Conditional & Length Validation**: Verified `maxLength` truncation (`64` for Username, `200` for Full Name, Unit, and Contact), verified empty submission blocks with `"Enter your user name, or your full name."`, `"Enter your unit."`, and `"Say how System Support can reach you..."`, and confirmed that entering a valid username dynamically clears the conditional Full Name and Unit errors.

### Protected Application Forms — Dry-Run Verified (`6 of 6 passed`)
* **Authentication Setup**: Single-login suite setup (`Sign In To GLADM With Env Credentials`) to prevent repeated login attempts and protect against account lockouts.
* **Transportation Request Wizard (`/protected/requests`)**: Validates `type="tel"` POC phone check (`"Enter a phone number with at least 7 digits (or a 4–5 digit DSN extension)."`), `dd MMM yyyy` date validation (rejecting non-dates, ambiguous slash dates like `10/11/2026`, and impossible calendar days like `31 Feb 2026`), and `HH:MM` 24-hour time validation (`00:00 to 23:59`).
* **Personnel Form (`/protected/records/personnel/new`)**: Validates rejection of digit-only names (`"A name needs at least one letter."`), numeric/multi-character middle initials (`"One letter only."`), non-10-digit EDIPIs (`"An EDIPI is 10 digits (on the back of the CAC)."`), malformed work emails (`"Enter an email address like name@usmc.mil."`), and future dates of birth (`"The date of birth must be in the past."`).
* **Equipment New Model Form (`/protected/records/models/new`)**: Validates `inputmode="decimal"` and `inputmode="numeric"` on vehicle capacity fields and rejects invalid NSNs (`"Enter a 13-digit NSN (like 2320-01-523-1234), or leave it blank."`).
* **Watch Log 9-Line MEDEVAC Form (`/protected/watchlog/create/medevac`)**: Validates `inputmode="numeric"` on patient count fields (Litter / Ambulatory) and rejects negative or decimal numbers (`"Enter a whole number, or 0."`), as well as MGRS grid input.
* **Utilities & Supply Calculators (`/protected/utilities/calculators`)**: Validates `inputmode="numeric"` on calculator Days and rejects out-of-range values (`0` and `400`) with `"Whole days, 1 to 365"`.

---

Thanks,  
Noah
