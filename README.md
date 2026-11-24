# GLADM Web Testing Framework

Comprehensive **Robot Framework + SeleniumLibrary** end-to-end testing suite for **GLADM** (`https://gladm.defconai.dev`), structured using the **Page Object Model (POM)** and mapped across all **63 GLADM User Journeys (`J01`–`J70`)** and the Requirements Traceability Matrix (`R001`–`R483`).

---

## Project Structure

```text
├── .env                                            # Local credentials (USERNAME, PASSWORD) — gitignored
├── requirements.txt                                # Python dependencies (robotframework, seleniumlibrary)
├── docs/                                           # Offline mirror of all 63 GLADM user manuals & RTM (gitignored)
├── variables/
│   └── config.resource                             # Base URL, browser, timeout, and .env loader configuration
├── resources/
│   ├── common.resource                             # Browser lifecycle (Open Test Browser / Close Test Browser)
│   └── pages/                                      # 23 Page Object resource files
│       ├── form_validation_page.resource           # Form field type, maxLength, ARIA & invalid-input validation
│       ├── login_page.resource                     # J11: DoD Notice & Consent, Keycloak OIDC + TOTP, Public flows
│       ├── navigation_page.resource                # J10, J58: App shell, Today brief, Sidebar, Notices, Test As
│       ├── requests_page.resource                  # J01, J05, J16, J20: Requests list & TMR / GTR / LSR wizards
│       ├── missions_page.resource                  # J02: Missions list (8 bins), Create Mission, Overview & Tabs
│       ├── equipment_page.resource                 # J03: Equipment list, Vehicle profile (7 tabs), TAMCNs & Models
│       ├── personnel_page.resource                 # J04: Personnel roster, Person profile (7 tabs), Licenses
│       ├── capacity_page.resource                  # J06: Transportation Capacity Board (Trucks & Drivers views)
│       ├── availability_page.resource              # J07: 5-day Availability grid, Managers, Driver Availability
│       ├── dispatch_page.resource                  # J08: Daily Master Log, Trip Tickets (NAVMC 10627), Search Log
│       ├── reports_page.resource                   # J09: Report library, Comptroller, Cargo, GCSS, Operator Rollup
│       ├── admin_testing_page.resource             # J12, J13, J17, J22, J23, J25, J27, J59, J60, J65: Admin & System
│       ├── safety_page.resource                    # J14: Safety Mishaps & Citations lists and creation forms
│       ├── watchlog_page.resource                  # J15, J24: 24-Hour Watch Log, 9-Line MEDEVAC, Activity Log, Help
│       ├── supply_page.resource                    # J18, J38, J39, J70: LOGSTAT, Bulk Fuel, Ammunition, Calculators
│       ├── map_page.resource                       # J21, J26, J28, J31, J36: Route Planner, Operations Map, Tracks
│       ├── planning_page.resource                  # J29, J33, J64: Plan Moves, Solver Compare, Plan the Move
│       ├── gunny_chat_page.resource                # J30, J34, J35: Gunny AI Assistant, Gunny to Map, Team Chat
│       ├── settings_page.resource                  # J32, J47: Display Settings & Notification Settings
│       ├── motor_pool_page.resource                # J40: Motor Pool & Parking Lot Board and Lot Editor
│       ├── naval_page.resource                     # J41, J43, J44, J45, J66: ARG Presence, Offload, MEU, Fleet
│       ├── utilities_page.resource                 # J48–J57: Utilities Home, Ask, Handle/Plan/Lock, Ops, Board
│       └── logc2_page.resource                     # J61, J62, J63: Ground Troops, Orders In, Task Organization
└── tests/                                          # 26 Robot Test Suites (111 test cases)
    ├── form_field_validation_tests.robot
    ├── j01_tmr_lifecycle_tests.robot
    ├── j02_missions_tests.robot
    ├── j03_equipment_tests.robot
    ├── j04_personnel_tests.robot
    ├── j05_gtr_lifecycle_tests.robot
    ├── j06_capacity_tests.robot
    ├── j07_availability_tests.robot
    ├── j08_dispatch_tests.robot
    ├── j09_reports_tests.robot
    ├── j10_navigation_tests.robot
    ├── j11_signin_tests.robot
    ├── j12_j13_j17_j22_j23_j25_j27_j59_j60_j65_admin_tests.robot
    ├── j14_safety_tests.robot
    ├── j15_watchlog_activity_tests.robot
    ├── j16_lsr_lifecycle_tests.robot
    ├── j18_j38_j39_j70_supply_tests.robot
    ├── j20_requests_tests.robot
    ├── j21_j31_route_map_tests.robot
    ├── j29_j33_j64_planning_tests.robot
    ├── j30_j34_j35_gunny_chat_tests.robot
    ├── j32_j47_settings_tests.robot
    ├── j40_motor_pool_tests.robot
    ├── j41_j66_naval_tests.robot
    ├── j48_j57_utilities_tests.robot
    └── j61_j63_logc2_tests.robot
```

---

## Setup

1. Activate the virtual environment:
   ```bash
   source .venv/bin/activate
   ```

2. Ensure `.env` exists in the project root with your GLADM Keycloak credentials:
   ```dotenv
   USERNAME=your_username
   PASSWORD=your_password
   ```

---

## Running Tests

### 1. Dry-Run Validation (Syntax, Imports & Keyword Resolution)
Verify all 26 test suites and 111 test cases without opening a browser:
```bash
.venv/bin/robot --dryrun --outputdir results tests/
```

### 2. Run Unauthenticated (`safe`) Tests Only
Runs tests that verify the DoD Notice and Consent banner, Keycloak redirect, Request an Account, Forgot Password, and public form field validations without submitting a password (zero risk of account lockout):
```bash
.venv/bin/robot --include safe --outputdir results tests/j11_signin_tests.robot tests/form_field_validation_tests.robot
```

### 3. Run an Authenticated Test Suite
Each authenticated suite logs in **once** during `Suite Setup`. You can either pass a fresh 6-digit OTP on the command line (`-v OTP:123456`) or type the 6-digit code directly into the browser window when prompted (waits up to `120s`):
```bash
.venv/bin/robot --variable HEADLESS:False --variable OTP:123456 --outputdir results tests/j01_tmr_lifecycle_tests.robot
```
