import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zaviato/app/AppConfiguration/AppNavigation.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/base/BaseApiResp.dart';
import 'package:zaviato/app/constant/EnumConstant.dart';
import 'package:zaviato/app/localization/app_locales.dart';
import 'package:zaviato/app/network/NetworkCall.dart';
import 'package:zaviato/app/network/ServiceModule.dart';
import 'package:zaviato/app/utils/CommonTextfield.dart';
import 'package:zaviato/app/utils/CommonWidgets.dart';
import 'package:zaviato/app/utils/CustomDialog.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/navigator.dart';
import 'package:zaviato/app/utils/string_utils.dart';
import 'package:zaviato/components/screens/Auth/OtpVerifyScreen.dart';
import 'package:zaviato/components/screens/Business/BusinessDetail.dart';
import 'package:zaviato/components/widgets/shared/buttons.dart';

import '../../../main.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const route = "ForgetPasswordScreen";

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController passwordController = new TextEditingController();
  FocusNode passwordFocus = new FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _isEmailOrMobileValid = true;
  bool _autoValidate = false;

  String showOTPMsg = "";
  Timer _timer;
  int _start = 30;
  bool isTimerCompleted = false;
  bool autoFocus = true;
  bool isApiCall = false;

  @override
  void initState() {
    super.initState();
    passwordController.text = "1234567890";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: getAppBar(
          context,
          '',
          backgroundColor: appTheme.whiteColor,
          leadingButton: getBackButton(context),
          centerTitle: false,
        ),
        body: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Container(
            margin: EdgeInsets.only(
              right: getSize(30),
              left: getSize(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: getSize(38),
                ),
                Text(
                  "Forget Password?",
                  style: appTheme.black22BoldTextStyle,
                ),
                SizedBox(
                  height: getSize(8),
                ),
                Text(
                  "Enter the email address associated with your account.",
                  style: appTheme.gray16RegularTextStyle,
                ),
                SizedBox(
                  height: getSize(60),
                ),
                CommonTextfield(
                  focusNode: passwordFocus,
                  textOption: TextFieldOption(
                    hintText: "Email/Mobile Number",
                    maxLine: 1,
                    keyboardType: TextInputType.text,
                    inputController: passwordController,
                    errorBorder: _isEmailOrMobileValid
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
                  textCallback: (text) {
                    if (_autoValidate) {
                      if (text.isEmpty) {
                        setState(() {
                          _isEmailOrMobileValid = false;
                        });
                      } else if (isNumeric(text) && !validateMobile(text)) {
                        setState(() {
                          _isEmailOrMobileValid = false;
                        });
                      } else if (!isNumeric(text) && !validateEmail(text)) {
                        setState(() {
                          _isEmailOrMobileValid = false;
                        });
                      } else {
                        setState(() {
                          _isEmailOrMobileValid = true;
                        });
                      }
                    }
                  },
                  validation: (text) {
                    if (text.isEmpty) {
                      _isEmailOrMobileValid = false;
                      return "Enter email/mobile";
                    } else if (isNumeric(text) && !validateMobile(text)) {
                      _isEmailOrMobileValid = false;
                      return "Enter valid mobile";
                    } else if (!isNumeric(text) && !validateEmail(text)) {
                      return "Enter valid Email";
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
                      callForgetApi(context);

                      // NavigationUtilities.pushRoute(BusinessDetailScreen.route);
                    } else {
                      setState(() {
                        _autoValidate = true;
                      });
                    }
                  },
                  text: "Reset",
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

  callForgetApi(BuildContext context, {bool isResend = false}) {
    Map<String, dynamic> req = {};

    if (!isNumeric(passwordController.text))
      req["email"] = passwordController.text;
    else {
      req["mobile"] = passwordController.text;
    }

    NetworkCall<BaseApiResp>()
        .makeCall(
            () => app
                .resolve<ServiceModule>()
                .networkService()
                .forgetPasswordApi(req),
            context,
            isProgress: true)
        .then(
      (baseApiResp) async {
        Map<String, dynamic> req = {};
        if (!isNumeric(passwordController.text))
          req["email"] = passwordController.text;
        else {
          req["mobile"] = passwordController.text;
        }
        req["moduleType"] = OtpPage.ForgotPassword;
        // callSendOTP(context);
        NavigationUtilities.pushRoute(OtpVerifyScreen.route, args: req);
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
      },
    ).catchError((onError) {

       Map<String, dynamic> req = {};
        if (!isNumeric(passwordController.text))
          req["email"] = passwordController.text;
        else {
          req["mobile"] = passwordController.text;
        }
        req["moduleType"] = OtpPage.ForgotPassword;
        // callSendOTP(context);
        NavigationUtilities.pushRoute(OtpVerifyScreen.route, args: req);

      // isOtpTrue = false;
      // isOtpCheck = false;
      setState(() {});
      app.resolve<CustomDialogs>().confirmDialog(
            context,
            title: "Email is not exists",
            desc: onError.message,
            positiveBtnTitle: R.string().commonString.btnTryAgain,
          );
    });
    ;
  }

  // void startTimer() {
  //   const oneSec = const Duration(seconds: 1);
  //   _timer = new Timer.periodic(
  //     oneSec,
  //     (Timer timer) => setState(
  //       () {
  //         if (_start < 1) {
  //           timer.cancel();
  //           isTimerCompleted = true;
  //         } else {
  //           _start = _start - 1;
  //         }
  //       },
  //     ),
  //   );
  // }
}
