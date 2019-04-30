*** Settings ***
Resource              ../../../Resource/keywords.robot
Suite Teardown      Close All Browsers

*** Test Case ***
Display Message Duplicate Phone No In Channel QR
    Given Login With Full Authorized To Home Page
    And Click Menu Create Application
    When Search Tax ID
    And Go To QR List Page
    And Create QR Paotung
    Then Display Message Duplicate Phone

# Display Message Duplicate Phone No In Channel Edonation
#     Given Login With Full Authorized To Home Page
#     And Click Menu Create Application
#     When Search Tax ID
#     And Go To QR List Page
#     And Create Edonation
#     Then Display Message Duplicate Phone

# *** Keyword ***
# Create Biller
#     Wait    Click Biller Tab
#     Wait    Scroll To       biller-aggregator-list-create-button
#     Wait    Click Button    biller-aggregator-list-create-button
#     Text Should Contain Element     biller-aggregator-title     เป๋าตุง Biller - Tag 30
#     Wait    Input Text    biller-aggregator-channel-name-text         พัชราพรรณ
#     Wait    Input Text    biller-aggregator-email-text            phat.pan@gmail.com
#     Wait    Input Text    biller-aggregator-phone-number-text     0846936551
#     Wait    Click Element    biller-aggregator-account-select
#     Wait    Click Element    biller-aggregator-account-option-0000418471
#     Wait    Click Button     biller-aggregator-save-button


