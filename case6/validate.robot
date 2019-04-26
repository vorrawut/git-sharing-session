*** Settings ***
Resource              ../../Resource/keywords.robot
Suite Setup           Open Blank Browser With Remote URL
Suite Teardown        Close All Browsers
Test Setup            Go To Page Login

*** Variables ***
${USERNAME_NUMBER_ONLY}                 12313
${USERNAME_THAI_ONLY}                   บัณฑิต
${USERNAME_SPECIAL_CHARACTER_ONLY}      @&*^#(
${USERNAME_ALL_TYPE}                    aก#123
${USERNAME_TEXT_INPUT_ID}               login-username-text-input
${PASSWORD_TEXT_INPUT_ID}               login-password-text-input
${USERNAME_CORRECT}                     10006
${USERNAME_MORE_THAN_SIX_CHARACTER}     1000007
${USERNAME_NO_PERMISSION}               100013
${PASSWORD_CORRECT}                     password
${PASSWORD_INCORRECT}                   false
${LOGIN_BUTTON_ID}                      login-login-button
${LOGOUT_BUTTON_ID}                     user-profile-logout-button
${LOGIN_VISIBILTY_ID}                   login-visibility-icon
${USER_PROFILE_BUTTON_ID}               header-user-profile-button
${LOGIN_USERNAME_MAX_LENGTH_ERROR_ID}   login-username-max-length-error
${LOGO_IMAGE_ID}                        header-logo-image
${LOGIN_LOGIN_ID}                       login-login-logo
${DIALOG_ERROR_MESSAGE_ID}              dialog-error-msg-description
${DIALOG_ERROR_MESSAGE_BOTTON_ID}       dialog-error-msg-button
${MESSAGE_ERROR_INCORRECT}              ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง
${MESSAGE_ERROR_NOT_TO_ACCESS}          ไม่มีสิทธ์เข้าใช้งานระบบ
${LOGIN_USERNAME_REQUIRED_ERROR_ID}     login-username-required-error
${LOGIN_PASSWORD_REQUIRED_ERROR_ID}     login-password-required-error
${MESSAGE_ERROR_REQUIRED_USERNAME}      โปรดระบุชื่อผู้ใช้
${MESSAGE_ERROR_REQUIRED_PASSWORD}      โปรดระบุรหัสผ่าน
${MESSAGE_ERROR_LESS_THAN_6_DIGIT}      ชื่อผู้ใช้ต้องไม่เกิน 6 ตัวอักษร


*** Test Cases ***
Login Button Should Be Disble When Username And Password Are Empty
    Login Button Should Be Disabled

Login Button Should Be Disble When Insert Username Input Only
    Fill In Username   ${USERNAME_CORRECT}
    Login Button Should Be Disabled

Login Button Should Be Disble When Insert Password Input Only
    Fill In Password   ${PASSWORD_CORRECT}
    Login Button Should Be Disabled

Display Error Message
    [Template]    Display Error Message Username And Password Incorrect With Input Text
    ${USERNAME_NUMBER_ONLY}
    ${USERNAME_THAI_ONLY}
    ${USERNAME_SPECIAL_CHARACTER_ONLY}
    ${USERNAME_ALL_TYPE}

Display Error Message When Input Username Valid But Password Invalid
    Given Fill In Username   ${USERNAME_CORRECT}
    And Fill In Password   ${PASSWORD_INCORRECT}
    When Click Button Login
    Then Display Error Message Username And Password Incorrect

Login Button Should be Disabled When Input Username More Than 6 Length
    When Fill In Username   ${USERNAME_MORE_THAN_SIX_CHARACTER}
    And Fill In Password   ${PASSWORD_CORRECT}
    Then Login Button Should Be Disabled

Display Error Message When Input Username More Than 6 Length
    When Fill In Username   ${USERNAME_MORE_THAN_SIX_CHARACTER}
    And Fill In Password   ${PASSWORD_CORRECT}
    Then Display Error Message Max Length More Than 6 Character

Login Should Be Successful When Insert Username And Password Correctly With Press Eye Symbol Icon
    Given Fill In Username And Password Correctly
    And Click Visibility Icon
    When Click Button Login
    Then Display Header Logo

Logout Should Be Successful When Insert Username And Password Correctly
    Given Login Successful
    And Click Header User Profile
    When Click Button Logout
    Then Display Logo MMS At Login Page

Display Error Message When User Do Not Have Permission
    Given Fill In Username   ${USERNAME_NO_PERMISSION}
    And Fill In Password     ${PASSWORD_CORRECT}
    When Click Button Login
    Then Display Error Message No Permission To Access

Display Error Message When Click Usename Input And Focus Out
    When Click Username Input Then Focus Out
    Then Display Error Message Required Username

Display Error Message When Click Password Input And Focus Out
    When Click Password Input Then Focus Out
    Then Display Error Message Required Password

*** Keywords ***
Login Button Should Be Disabled
    Element Should Be Disabled    ${LOGIN_BUTTON_ID}

Fill In Username And Password Correctly
    Fill In Username   ${USERNAME_CORRECT}
    Fill In Password   ${PASSWORD_CORRECT}

Fill In Username
    [Arguments]    ${VALUE}
    Input Text     ${USERNAME_TEXT_INPUT_ID}    ${VALUE}

Fill In Password
    [Arguments]    ${VALUE}
    Input Text     ${PASSWORD_TEXT_INPUT_ID}    ${VALUE}

Click Button Logout
    Display Logout Button
    Wait    Click Button     ${LOGOUT_BUTTON_ID}

Click Button Login
    Click Button    ${LOGIN_BUTTON_ID}

Click Visibility Icon
    Click Element    ${LOGIN_VISIBILTY_ID}

Click Username Input Then Focus Out
    Click Element    ${USERNAME_TEXT_INPUT_ID}
    Click Element    ${PASSWORD_TEXT_INPUT_ID}

Click Password Input Then Focus Out
    Click Element    ${PASSWORD_TEXT_INPUT_ID}
    Click Element    ${USERNAME_TEXT_INPUT_ID}

Click Header User Profile
    Click Button     ${USER_PROFILE_BUTTON_ID}

Display Error Message Max Length More Than 6 Character
    Element Should Contain    ${LOGIN_USERNAME_MAX_LENGTH_ERROR_ID}    ${MESSAGE_ERROR_LESS_THAN_6_DIGIT}

Display Header Logo
    Wait    Element Should Be Visible    ${LOGO_IMAGE_ID}

Display Logo MMS At Login Page
    Wait    Element Should Be Visible    ${LOGIN_LOGIN_ID}

Display Logout Button
    Wait    Element Should Be Visible    ${LOGOUT_BUTTON_ID}

Display Error Message Username And Password Incorrect With Input Text
    [Arguments]    ${USERNAME}
    Fill In Username   ${USERNAME}
    Fill In Password   ${PASSWORD_CORRECT}
    Click Button Login
    Wait    Element Should Contain    ${DIALOG_ERROR_MESSAGE_ID}    ${MESSAGE_ERROR_INCORRECT}
    Click Button    ${DIALOG_ERROR_MESSAGE_BOTTON_ID}

Display Error Message Username And Password Incorrect
    Wait    Element Should Contain    ${DIALOG_ERROR_MESSAGE_ID}    ${MESSAGE_ERROR_INCORRECT}

Display Error Message No Permission To Access
    Wait    Element Should Contain        ${DIALOG_ERROR_MESSAGE_ID}    ${MESSAGE_ERROR_NOT_TO_ACCESS}

Display Error Message Required Username
    Element Should Contain    ${LOGIN_USERNAME_REQUIRED_ERROR_ID}    ${MESSAGE_ERROR_REQUIRED_USERNAME}

Display Error Message Required Password
    Wait    Element Should Contain    ${LOGIN_PASSWORD_REQUIRED_ERROR_ID}    ${MESSAGE_ERROR_REQUIRED_PASSWORD}

Login Successful
    Fill In Username And Password Correctly
    Click Button Login
    Display Header Logo
