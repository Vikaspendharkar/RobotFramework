*** Settings ***
Library     Collections
#Library     RPA.Browser.Selenium
Library     SeleniumLibrary
#Library     Selenium2Library
Library     DateTime
Variables   ../Variablesfiles/Variables_files.py
Library    String


*** Keywords ***
LoginToApplaication
    [Arguments]      ${Username}    ${Password}
    Input Text       id:UserName    ${Username}
    Input Text       id:Password    ${Password}
    Click Element    xpath://button[@class='btn btn-lg btn-primary btn-block btn-signin']


SwichedTousername
    Input Text  iD:search-switch-site  Omni Test
    Sleep    1
    Press Keys  iD:search-switch-site   BACKSPACE
    Sleep    1
    Click Element  xpath:/html/body/div[1]/div[2]/div[1]/span/form/span/ul
    Sleep    1
#    Press Keys    iD:search-switch-site     ENTER

Forloopforswitchuser
    FOR    ${i}    IN RANGE    4
            ${selusername}      Get Text    xpath:/html/body/div[1]/div[1]/div/div[2]/div/a/span[1]/small
            Log To Console      \n\n====================\n ${selusername}
            Log To Console      ====================\n

        IF  '${actusername}' == '${selusername}'
                Log To Console      \n\n====================\n Switched User Successfully \n====================
                Exit For Loop If    '${actusername}' == '${selusername}'
        ELSE
                SwichedTousername
        END
    END

User Switched Successfully
    ${selusername_1}    Get Text    xpath:/html/body/div[1]/div[1]/div/div[2]/div/a/span[1]/small
    Log To Console      \n\n====================\n ${selusername_1}
    Log To Console      ====================\n

    IF  '${actusername}' != '${selusername_1}'
            Log To Console    \n\n====================\n Run Again Your User can't Switched Omni Parcel Master Account to Omni Test
            Log To Console    ====================\n
            Close Browser
    END


FillReceiverandPackages
    Select From List By Label    xpath://select[@id='Destination_CountryCode']  NEW ZEALAND
    Input Text    id:Destination_Name    test
    Sleep    1
    Press Keys    id:Destination_Name    ENTER
    Sleep    1
    Input Text    id:stock_length_1    1
    Input Text    id:stock_width_1    1
    Input Text    id:stock_height_1    1
    Input Text    id:stock_kg_1    1
    Sleep    1
#---------- Fill Data for Outbound & Export >> Packges ----------
    Input Text    id:commo_ItemSKU_0    NZ00012
    Press Keys    id:commo_kg_0    CONTROL+A
    Press Keys    id:commo_kg_0    DELETE
    Sleep    1
    Input Text    id:commo_kg_0    10
    Input Text    id:commo_units_0    5
    Input Text    id:commo_price_0    100
    Sleep    1
    Scroll Element Into View    id:btncalculate
    Click Element    id:btncalculate
    Sleep    3
    Scroll Element Into View    xpath://tbody/tr[1]/td[2]/button[1]
    Sleep    2
    Click Element    xpath://tbody[@id='tblrates-body']/tr[1]//button[@class='btn btn-primary']
    Sleep    5

Copy Cannot Number
    TRY
            ${connoteno}=       Get Text    xpath://*[@id="wrap"]/div[2]/div[2]/a
            ${connoteno1}=      Fetch From Right    ${connoteno}    C
            Log To Console      \n\n====================\n CONNOTE NO.....0 IS :- \n ${connoteno}
            Log To Console      ====================\n
            Append To List      ${cpyconnotenumber}  ${connoteno}
            Log To Console      \n\n====================\n ${cpyconnotenumber}
            Log To Console      ====================\n
    EXCEPT
            Log To Console      \n\n====================\n Try Next time...... \n====================\n
    END


Reprint & Manifests
    Click Element      xpath://a[.='Reprint & Manifests']
    Sleep    15

    ${length} =         Get Length  ${cpyconnotenumber}
    Run Keyword If  ${length} == 0
    ...    Copy Cannot Number
    ...  ELSE
    ...    Log To Console   \n\n====================\n Number copy successfully...1 \n====================\n

#    IF  '${cpyconnotenumber}' == '@{EMPTY}'
#            Copy Cannot Number
#    ELSE
#            Log To Console   \n\n====================\n Number copy successfully...1 \n====================\n
#    END
    Sleep    2

    Click Element    id:filter
    Sleep    1
    Select From List By Value    css:#filter    876|0
    Sleep    1

    ${length} =         Get Length  ${cpyconnotenumber}
    Run Keyword If  ${length} == 0
    ...    Copy Cannot Number
    ...  ELSE
    ...    Log To Console   \n\n====================\n Number copy successfully...2 \n====================\n


#    IF  '@{cpyconnotenumber}' == '@{EMPTY}'
#        Copy Cannot Number
#    ELSE
#        Log To Console   \n\n====================\n Number copy successfully...2 \n====================\n
#    END
    Sleep    1

    ${length} =         Get Length  ${cpyconnotenumber}
        IF  ${length} == 0
            ${conno}=  Get Text    xpath:/html/body/div[1]/div[2]/div[2]/div[1]/form[2]/div/div/table/tbody/tr[1]/td[2]
            ${Conno1}=  Fetch From Right    ${conno}    C
            Log To Console      \n\n====================\n CONNOTE NO.....1 IS :- \n ${conno}
            Log To Console      ====================\n
            Append To List      ${cpyconnotenumber}  ${conno}
            Log To Console      \n\n====================\n ${cpyconnotenumber}
            Log To Console      ====================\n
    ELSE
            Log To Console      \n\n====================\n Number copy successfully...3 \n====================\n
    END

    Select Checkbox  css:[value='${cpyconnotenumber}[0]']
    Scroll Element Into View    id:btnsendmanifest
    Click Element    id:btnsendmanifest


Shipment Report
    Input Text      id:ConnoteNumber    ${cpyconnotenumber}[0]
    Click Button    id:Search
    Sleep    1
    Scroll Element Into View    xpath://div[@id='myModal']//div[1]/table[@class='table table-bordered table-condensed col-md-12']//td[3]
    Sleep    1
    ${carriertrackno}  Get Text    xpath://div[@id='myModal']//div[1]/table[@class='table table-bordered table-condensed col-md-12']//td[3]
    Log To Console     \n\n====================\n Barcode No. Is :- \n ${carriertrackno}
    Log To Console     ====================\n

    Append To List    ${cpyconnotenumber}  ${carriertrackno}
    Log To Console    \n\n====================\n ${cpyconnotenumber}
    Log To Console    ====================\n
    Sleep    1
    ${ManifestBatchKey}  Get Text    xpath:/html/body/div[1]/div[2]/div[2]/div/div[2]/div[1]/div[3]/div/div/table[3]/tbody/tr/td[2]
    Log To Console       \n\n====================\n ManifestBatchKey Is :- \n ${ManifestBatchKey}
    Log To Console       ====================\n
    Append To List       ${cpyconnotenumber}  ${ManifestBatchKey}
    Log To Console       \n\n====================\n ${cpyconnotenumber}
    Log To Console       ====================\n


Check Scan - Origin Scanning
    Click Element    css:.nav > li:nth-of-type(3) > .dropdown-toggle
    Sleep    2
    Click Element    css:.nav > li:nth-of-type(3) > .dropdown-menu > li:nth-of-type(1) > a
    Sleep    2
    Input Text    id:barcode    ${cpyconnotenumber}[1]
    Click Button    id:btnsubmit
    Sleep    1
    ${Last_Scan_Barcode}  Get Text    xpath:/html/body/div[1]/div[2]/div[2]/div[1]/form/div[8]/div/div
    Log To Console        \n\n====================\n Last Scan Barcode Result Is :- \n ${Last_Scan_Barcode}
    Log To Console        ====================\n


Consolidate to MAWB
    Click Element    css:.nav > li:nth-of-type(3) > .dropdown-toggle
    Sleep    2
    Click Element    css:.nav > li:nth-of-type(3) li:nth-of-type(9) > a
    Sleep    2
    Click Element    id:ConsolidationHubId
    Select From List By Label     id:ConsolidationHubId    TEST
    Sleep    1
    Select Checkbox    css:[data-manifest="${cpyconnotenumber}[2]"][name='selected']
#    Select Checkbox    xpath://tr[15]//input[@name='selected']
    Scroll Element Into View    id:btnmwab
    Click Button     id:btnmwab
    Sleep    1
    Select From List By Label   id:OriginCountry          AUSTRALIA
    Sleep    0.5
    Select From List By Label   id:PortOfDischargeId      SYDNEY > SYD
    Sleep    0.5
    Select From List By Label   id:OriginAgent            SYDNEY > SYD > Seko
    Sleep    1
    Select From List By Label   id:DestinationCountry     NEW ZEALAND
    Sleep    0.5
    Select From List By Label   id:PortOfLadingId         AUCKLAND > AKL
    Sleep    0.5
    Select From List By Label   id:DestinationAgent       AUCKLAND > AKL > Seko
    Sleep    0.5
    Input Text       id:VesselNumber   4477777444
    Sleep    0.5
    Input Text       id:ThreeMAWB      ${MAWB}
    Append To List   ${cpyconnotenumber}  ${MAWB}
    Sleep    0.5
    Input Text       id:EightMAWB     ${MAWB_1}
    Append To List   ${cpyconnotenumber}  ${MAWB_1}
    Sleep    0.5
    Log To Console   \n\n====================\n ${cpyconnotenumber}
    Log To Console   ====================\n

#=============== Select Date and Time ===================

    ${Current_Date}=  Get Current Date  #result_format=%d-%b-%Y %H:%M
    Log To Console    ${Current_Date}
    ${Add_Day}=       Add Time To Date    ${Current_Date}     1 days
    ${Next_Date}      Convert Date    ${Add_Day}     result_format=%d-%b-%Y %H:%M
    Log To Console    ${Next_Date}
    Input Text        id:ETA    ${Next_Date}

    Sleep    2
    Click Button    css:.ui-datepicker-close
    Sleep    1
    Click Button    id:consolidateButton
    Sleep    2

    TRY
       ${message}=  Handle Alert   action=ACCEPT

       Log To Console  \n\n====================\n MAWB allocate Alert Msg Is :- \n ${message}
       Log To Console  ====================\n
       Sleep    5
    EXCEPT
       Log To Console   \n\n====================\n Alert not Display \n====================\n
    END



Import >> Customs Release Check
    Sleep    2
    Click Element    css:.nav > li:nth-of-type(4) > .dropdown-toggle
    Sleep    0.5
    Click Element    xpath://a[.='Customs Release Check']
    Sleep    2
    Click Element    xpath://span[.='Select']
    Input Text     xpath://div[@class='chosen-search']/input[1]    ${cpyconnotenumber}[3]${cpyconnotenumber}[4]
    Sleep    1
    Press Keys     xpath://div[@class='chosen-search']/input[1]  ENTER
    Sleep    2
    Input Text     id:barcode    ${cpyconnotenumber}[1]
    Sleep    0.5
    Click Element  id:btnsubmit
    
    TRY
        Click Element    xpath://button[@class='confirm']
    FINALLY
        ${Barcode_verify}=  Get Text    css:.form-horizontal > div:nth-of-type(4) > .col-sm-5 > div
        Log To Console  \n\n====================\n MAWB allocate Alert Msg Is :- \n ${Barcode_verify}
        Log To Console  ====================\n
    END


