*** Settings ***
Library     Collections
Library     RPA.Browser.Selenium
Variables   Variablesfiles/Variables_files.py
Resource    Keywordsfile/Omniparcelkeywords.robot
Library    Process


*** Test Cases ***
Login with InValid Credentials
    Open Chrome Browser  ${Login_url}[0]
    Maximize Browser Window
    LoginToApplaication  vikas@omniparcel.com    Vikas@1234
    Page Should Contain    Login was unsuccessful

Login with Valid Credentials
    LoginToApplaication  vikas@omniparcel.com    Vikas@123
    Page Should Contain    Outbound & Export

Verify User can be Swiched
    SwichedTousername
    Forloopforswitchuser
    User Switched Successfully
Create Outbound & Export
    FillReceiverandPackages
    Copy Cannot Number
Get Manifest for Shipment
    Reprint & Manifests
Fetch Shipment Report
    Open Chrome Browser       ${Shipingurlweb1}[0]
    Maximize Browser Window
    LoginToApplaication     vikas@omniparcel.com    Vikas@123
    SwichedTousername
    Forloopforswitchuser
    User Switched Successfully
    Shipment Report
Check Scan - Origin Scanning
    Check Scan - Origin Scanning
Check scanned and awaiting assignment to flight/vessel
    Consolidate to MAWB
    Wait For Process
Scan the international barcode to verify if goods are cleared by customs
    Import >> Customs Release Check



