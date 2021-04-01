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
import 'package:zaviato/app/utils/string_utils.dart';
import 'package:zaviato/components/widgets/shared/buttons.dart';

import '../../../main.dart';

class CreatePasswordScreen extends StatefulWidget {
  static const route = "CreatePasswordScreen";

  String value = "";
  String otp = "";
  CreatePasswordScreen({Map<String, dynamic> arguments}) {
    if (arguments != null) {
      // if (arguments[ArgumentConstant.ModuleType] != null) {
      //   moduleType = arguments[ArgumentConstant.ModuleType];
      // }
      // if (arguments[ArgumentConstant.IsFromDrawer] != null) {
      //   isFromDrawer = arguments[ArgumentConstant.IsFromDrawer];
      // }
      if (!isNullEmptyOrFalse(arguments["email"])) {
        value = arguments["email"];
      } else if (!isNullEmptyOrFalse(arguments["mobile"])) {
        value = arguments["mobile"];
      }
      otp = arguments["otpNumber"];
    }
  }

  @override
  _CreatePasswordScreenState createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  TextEditingController newPasswordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  FocusNode newPasswordFocus = new FocusNode();
  FocusNode confirmPasswordFocus = new FocusNode();

  final _formKey = GlobalKey<FormState>();
  bool _isnewPasswordValid = true;
  bool _isconfirmPasswordValid = false;
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
                  "Create New Password",
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
                        callCreateNewPasswordApi(context);
                      else {
                        setState(
                          () {
                            _autoValidate = true;
                            app.resolve<CustomDialogs>().confirmDialog(
                                  context,
                                  title: "Both password should be same...",
                                  desc: "Both password should be same...",
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

  callCreateNewPasswordApi(BuildContext context) {
    Map<String, dynamic> req = {};

    if (isNumeric(widget.value)) {
      req["mobile"] = widget.value;
    } else {
      req["email"] = widget.value;
    }

    req["otp"] = widget.otp;
    req["password"] = newPasswordController.text;

    NetworkCall<BaseApiResp>()
        .makeCall(
            () => app
                .resolve<ServiceModule>()
                .networkService()
                .resetPasswordApi(req),
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
      AppNavigation().movetoLogin();
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
