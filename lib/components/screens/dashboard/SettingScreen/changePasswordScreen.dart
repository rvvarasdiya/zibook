import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zaviato/app/AppConfiguration/AppNavigation.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/base/BaseApiResp.dart';
import 'package:zaviato/app/localization/app_locales.dart';
import 'package:zaviato/app/network/NetworkCall.dart';
import 'package:zaviato/app/network/ServiceModule.dart';
import 'package:zaviato/app/utils/CommonTextfield.dart';
import 'package:zaviato/app/utils/CommonWidgets.dart';
import 'package:zaviato/app/utils/CustomDialog.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/pref_utils.dart';
import 'package:zaviato/app/utils/string_utils.dart';
import 'package:zaviato/components/widgets/shared/buttons.dart';
import 'package:zaviato/models/Auth/ChangePasswordModel.dart';

import '../../../../main.dart';


class ChangePasswordScreen extends StatefulWidget {
  static const route = "CreatePasswordScreen";


  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController newPasswordController = new TextEditingController();
  TextEditingController currentPasswordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  FocusNode newPasswordFocus = new FocusNode();
  FocusNode confirmPasswordFocus = new FocusNode();
  FocusNode currentPasswordFocus = new FocusNode();

  final _formKey = GlobalKey<FormState>();
  bool _isnewPasswordValid = true;
  bool _isconfirmPasswordValid = false;
  bool _iscurrentPasswordValid = false;
  // bool isButtonEnabled = true;
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          autovalidate: _autoValidate,
          key: _formKey,
          child: Container(
            padding: EdgeInsets.only(
              right: getSize(30),
              left: getSize(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: getSize(40),
                ),
                getBackButton(
                  context,
                ),
                SizedBox(
                  height: getSize(40),
                ),
                Text(
                  "Change Password",
                  style: appTheme.black22BoldTextStyle,
                ),
                SizedBox(
                  height: getSize(8),
                ),
                Text(
                  "You new password must be different from previously used password.",
                  style: appTheme.gray16RegularTextStyle,
                ),
                SizedBox(
                  height: getSize(40),
                ),
                CommonTextfield(
                  focusNode: currentPasswordFocus,
                  textOption: TextFieldOption(
                    hintText: "Current password",
                    maxLine: 1,
                    isSecureTextField: true,
                    keyboardType: TextInputType.text,
                    inputController: currentPasswordController,
                    errorBorder: _iscurrentPasswordValid
                        ? null
                        : OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                            borderSide: BorderSide(width: 1, color: Colors.red),
                          ),
                  ),
                  inputAction: TextInputAction.next,
                  onNextPress: () {
                    FocusScope.of(context).requestFocus(newPasswordFocus);
                  },
                  // validation: Validator("Please enter a valid email").email,
                  textCallback: (text) {
                    if (_autoValidate) {
                      if (text.isEmpty) {
                        setState(() {
                          _iscurrentPasswordValid = false;
                        });
                      } else {
                        setState(() {
                          _iscurrentPasswordValid = true;
                        });
                      }
                    }
                  },
                  validation: (text) {
                    if (text.isEmpty) {
                      _iscurrentPasswordValid = false;
                      return "Enter Current Password";
                    } else {
                      return null;
                    }
                  },
                ),
              
                SizedBox(
                  height: getSize(30),
                ),
                CommonTextfield(
                  focusNode: newPasswordFocus,
                  textOption: TextFieldOption(
                    hintText: "New password",
                    maxLine: 1,
                    isSecureTextField: true,
                    keyboardType: TextInputType.text,
                    inputController: newPasswordController,
                    errorBorder: _isnewPasswordValid
                        ? null
                        : OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                            borderSide: BorderSide(width: 1, color: Colors.red),
                          ),
                  ),
                  inputAction: TextInputAction.next,
                  onNextPress: () {
                    FocusScope.of(context).requestFocus(confirmPasswordFocus);
                  },
                  // validation: Validator("Please enter a valid email").email,
                  textCallback: (text) {
                    if (_autoValidate) {
                      if (text.isEmpty) {
                        setState(() {
                          _isnewPasswordValid = false;
                        });
                      } else {
                        setState(() {
                          _isnewPasswordValid = true;
                        });
                      }
                    }
                  },
                  validation: (text) {
                    if (text.isEmpty) {
                      _isnewPasswordValid = false;
                      return "Enter New Password";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: getSize(30),
                ),
                CommonTextfield(
                  focusNode: confirmPasswordFocus,
                  textOption: TextFieldOption(
                    hintText: "Confirm Password",
                    maxLine: 1,
                    isSecureTextField: true,
                    keyboardType: TextInputType.text,
                    inputController: confirmPasswordController,
                    errorBorder: _isconfirmPasswordValid
                        ? null
                        : OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                            borderSide: BorderSide(width: 1, color: Colors.red),
                          ),
                  ),
                  inputAction: TextInputAction.next,
                  onNextPress: () {
                    // fieldFocusChange(context, _focusPassword);
                  },
                  // validation: Validator("Please enter a valid email").email,
                  textCallback: (text) {
                    if (_autoValidate) {
                      if (text.isEmpty) {
                        setState(() {
                          _isconfirmPasswordValid = false;
                        });
                      } else {
                        setState(() {
                          _isconfirmPasswordValid = true;
                        });
                      }
                    }
                  },
                  validation: (text) {
                    if (text.isEmpty) {
                      _isconfirmPasswordValid = false;
                      return "Enter Confirm Password";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: getSize(40),
                ),
                AppButton.flat(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      if (newPasswordController.text ==
                          confirmPasswordController.text)
                          // print(" ");
                        callChangePasswordApi();
                      else {
                        setState(
                          () {
                            _autoValidate = true;
                            app.resolve<CustomDialogs>().confirmDialog(
                                  context,
                                  title: "Confirm password should be same as New password..",
                                  desc: "Confirm password should be same as New password..",
                                  positiveBtnTitle:
                                      R.string().commonString.btnTryAgain,
                                );
                          },
                        );
                      }
                    } else {
                      setState(() {
                        _autoValidate = true;
                      });
                    }
                  },
                  text: "Save",
                  backgroundColor: appTheme.colorPrimary,
                  textColor: appTheme.whiteColor,
                  fitWidth: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  callChangePasswordApi() {
   ChangePassReq req = ChangePassReq();
    req.currentPassword = currentPasswordController.text;
    for(int i=0;i<app.resolve<PrefUtils>().getUserDetails().emails.length;i++){
      if(app.resolve<PrefUtils>().getUserDetails().emails[i].isPrimary){
        req.username =  app.resolve<PrefUtils>().getUserDetails().emails[i].email.toString();
        break;
      }
    }
    req.newPassword = newPasswordController.text;
    
    print(req.username );

    NetworkCall<BaseApiResp>()
        .makeCall(
            () => app
                .resolve<ServiceModule>()
                .networkService()
                .ChangePassword(req),
            context,
            isProgress: true)
        .then((resp) async {
      // FocusScope.of(context).unfocus();
      // if (isResend) {
      //   if (isTimerCompleted) {
      //     _start = 30;
      //     isTimerCompleted = false;
      //     autoFocus = false;
      //   }
      // }
      // isTimerCompleted = false;
      // isApiCall = true;
      // _start = 30;
      // startTimer();
      // setState(() {});

      FocusScope.of(context).unfocus();
      Navigator.pop(context);
      // AppNavigation().movetoLogin();
      // isOtpTrue = true;
      // isOtpCheck = false;
      // // showOTPMsg = null;
      // Map<String, dynamic> dict = new HashMap();
      // if (!isNumeric(widget.value))
      //   req["email"] = widget.value;
      // else {
      //   req["mobile"] = widget.value;
      // }
      // dict["otpNumber"] = _pinEditingController.text.trim();
      // NavigationUtilities.pushRoute(CreatePasswordScreen.route, args: dict);
    }).catchError((onError) {
      setState(() {});
      app.resolve<CustomDialogs>().confirmDialog(
            context,
            title: R.string().commonString.error,
            desc: onError.message,
            positiveBtnTitle: R.string().commonString.btnTryAgain,
          );
    });
  }

}
