import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zaviato/app/Helper/SyncManager.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/base/BaseApiResp.dart';
import 'package:zaviato/app/constant/EnumConstant.dart';
import 'package:zaviato/app/constant/constants.dart';
import 'package:zaviato/app/localization/app_locales.dart';
import 'package:zaviato/app/network/NetworkCall.dart';
import 'package:zaviato/app/network/ServiceModule.dart';
import 'package:zaviato/app/utils/BaseDialog.dart';
import 'package:zaviato/app/utils/CommonWidgets.dart';
import 'package:zaviato/app/utils/CustomDialog.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/navigator.dart';
import 'package:zaviato/app/utils/string_utils.dart';
import 'package:zaviato/components/screens/Auth/SignInScreen.dart';
import 'package:zaviato/components/screens/dashboard/dashboard.dart';
import 'package:zaviato/components/widgets/pinView_textFields/decoration/pin_decoration.dart';
import 'package:zaviato/components/widgets/pinView_textFields/pin_widget.dart';
import 'package:zaviato/components/widgets/pinView_textFields/style/obscure.dart';
import 'package:zaviato/components/widgets/shared/buttons.dart';

import '../../../main.dart';
import 'CreatePasswordScreen.dart';

class   OtpVerifyScreen extends StatefulWidget {
  static const route = "OtpVerifyScreen";
  String value = "";
  OtpPage moduleType;

  OtpVerifyScreen({Map<String, dynamic> arguments}) {
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

      moduleType = arguments["moduleType"];
    }
  }
  @override
  _OtpVerifyScreenState createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final pinFormKey = GlobalKey<FormState>();
  bool isOtpCheck = true; // true when screen load first time for grey color
  bool isOtpTrue = false; //
  TextEditingController _pinEditingController = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();
  bool isOtpValid = true;
  // bool _isPasswordValid = false;
  // bool isButtonEnabled = true;
  bool _autoValidate = false;
  String showOTPMsg = "";
  Timer _timer;
  int _start = 30;
  bool isTimerCompleted = false;
  bool isResend = false;
  bool autoFocus = true;
  bool isApiCall = false;

  @override
  void initState() {
   if(this.mounted){
            setState(() {
          startTimer();
        });
        }
    super.initState();
    if (widget.moduleType == OtpPage.SignUP) {
      callSendOTP();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: getAppBar(
          context,
          '',
          backgroundColor: appTheme.whiteColor,
          leadingButton: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,), onPressed: ()=>Navigator.pop(context)),
          centerTitle: false,
        ),
        body: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: ListView(
            padding: EdgeInsets.only(
              right: getSize(30),
              left: getSize(30),
            ),
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getSize(40),
              ),
              Text(
                "Verify Phone Number",
                style: appTheme.black22BoldTextStyle,
              ),
              SizedBox(
                height: getSize(8),
              ),
              Text(
                "Please enter the verification code sent to +91 98563 25482",
                style: appTheme.gray16RegularTextStyle,
              ),
              SizedBox(
                height: getSize(40),
              ),
              getPinViewOTP(),
              _start > 0
                  ? Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        _start.toString(),
                        style: appTheme.black14BoldTextStyle,
                      ),
                    )
                  : Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          // Navigator.pop(context);
                          setState(() {
                            if (_start <= 0) {
                              if (widget.moduleType == OtpPage.ForgotPassword) {
                                callForgetApi(context);
                              } else {
                                if (widget.moduleType == OtpPage.SignUP)
                                  _pinEditingController.clear();
                                isOtpCheck = true;
                                isOtpTrue = false;
                                callSendOTP();
                              }
                            }
                          });
                        },
                        child: Text(
                          "Resend",
                          style: appTheme.colorPrimary14MediumTextStyle,
                        ),
                      ),
                    ),
              SizedBox(
                height: getSize(40),
              ),
              RichText(
                text: new TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "Didn't receive OTP code! Resend",
                      style: appTheme.black14RegularTextStyle,
                    ),
                    // TextSpan(
                    //   text: ' Resend',
                    //   style: appTheme.colorPrimary14MediumTextStyle,
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: getSize(40),
              ),
              AppButton.flat(
                onTap: () {
                  // setState(() {});
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    if (_pinEditingController.text.trim().length != 6) {
                      isOtpTrue = false;
                      isOtpCheck = false;
                      showOTPMsg = "Please Enter OTP";
                    } else if (_pinEditingController.text.trim().length == 6) {
                      FocusScope.of(context).unfocus();
                      if (widget.moduleType == OtpPage.ForgotPassword) {
                        callApiForVerifyOTP(context);
                      } else if (widget.moduleType == OtpPage.SignUP) {
                        callApipForVerifyOtpFromSignUpScreen(context);
                      }
                    }
                  } else {
                    setState(() {
                      isOtpCheck = false;
                      isOtpTrue = false;
                      _autoValidate = true;
                    });
                  }
                },
                text: "Verify",
                backgroundColor: appTheme.colorPrimary,
                textColor: appTheme.whiteColor,
                fitWidth: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  callForgetApi(BuildContext context, {bool isResend = false}) {
    Map<String, dynamic> req = {};

    if (!isNumeric(widget.value))
      req["email"] = widget.value;
    else {
      req["mobile"] = widget.value;
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
        // FocusScope.of(context).unfocus();
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
        FocusScope.of(context).unfocus();
        if (isResend) {
          if (isTimerCompleted) {
            _start = 30;
            isTimerCompleted = false;
            autoFocus = false;
          }
        }
        isTimerCompleted = false;
        isApiCall = true;
        _start = 30;
       if(this.mounted){
            setState(() {
          startTimer();
        });
        }
      },
    ).catchError((onError) {
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

  callSendOTP() {
    Map<String, dynamic> req = {};
    req["mobile"] = widget.value;

    NetworkCall<BaseApiResp>()
        .makeCall(
            () => app.resolve<ServiceModule>().networkService().sendOTPApi(req),
            context,
            isProgress: true)
        .then(
      (baseApiResp) async {
        FocusScope.of(context).unfocus();
        if (isResend) {
          if (isTimerCompleted) {
            _start = 30;
            isTimerCompleted = false;
            autoFocus = false;
          }
        }
        isTimerCompleted = false;
        isApiCall = true;
        _start = 30;
        if(this.mounted){
            setState(() {
          startTimer();
        });
        }
        
      },
    ).catchError((onError) {
      // isOtpTrue = false;
      // isOtpCheck = false;
      // setState(() {});
      // app.resolve<CustomDialogs>().confirmDialog(
      //       context,
      //       title: "Email is not exists",
      //       desc: onError.message,
      //       positiveBtnTitle: R.string().commonString.btnTryAgain,
      //     );
    });
  }

  callApiForVerifyOTP(BuildContext context) async {
    Map<String, dynamic> req = {};

    if (isNumeric(widget.value)) {
      req["mobile"] = widget.value;
    } else {
      req["email"] = widget.value;
    }

    req["otp"] = _pinEditingController.text;

    NetworkCall<BaseApiResp>()
        .makeCall(
            () =>
                app.resolve<ServiceModule>().networkService().verifyOTPApi(req),
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
      isOtpTrue = true;
      isOtpCheck = false;
      // showOTPMsg = null;
      if (widget.moduleType == OtpPage.ForgotPassword) {
        Map<String, dynamic> dict = new HashMap();
        if (!isNumeric(widget.value))
          dict["email"] = widget.value;
        else {
          dict["mobile"] = widget.value;
        }
        dict["otpNumber"] = _pinEditingController.text.trim();
        NavigationUtilities.pushRoute(CreatePasswordScreen.route, args: dict);
      } else if (widget.moduleType == OtpPage.SignUP) {
        NavigationUtilities.pushRoute(SignInScreen.route);
      }
    }).catchError((onError) {
      isOtpTrue = false;
      isOtpCheck = false;
      setState(() {});
      
      app.resolve<CustomDialogs>().confirmDialog(
            context,
            title: R.string().commonString.error,
            desc: onError.message,
            positiveBtnTitle: R.string().commonString.btnTryAgain,
            onClickCallback: (ButtonType tryagain){
                // isOtpTrue = false;
                isOtpCheck = true;
                _pinEditingController.clear();
                setState(() {});
            }
          );
    });
  }

  callApipForVerifyOtpFromSignUpScreen(BuildContext context) {
    Map<String, dynamic> req = {};

    if (isNumeric(widget.value)) {
      req["mobile"] = widget.value;
    } else {
      req["email"] = widget.value;
    }

    req["token"] = _pinEditingController.text;

    NetworkCall<BaseApiResp>()
        .makeCall(
            () => app
                .resolve<ServiceModule>()
                .networkService()
                .verifyMobileOtpApi(req),
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

       SyncManager.instance.callMasterSync(
          context,
          () async {
            //success
            // AppNavigation.shared.movetoHome(isPopAndSwitch: true);
            // Navigator.of(context).pop();
            NavigationUtilities.push(Dashboard());
          },
          () {},
          isNetworkError: false,
          isProgress: true,
          // id: loginResp.data.user.id,
        ).then((value) {});

      // NavigationUtilities.pushRoute(SignInScreen.route);
    }).catchError((onError) {
      isOtpTrue = false;
      isOtpCheck = false;
      setState(() {});
      app.resolve<CustomDialogs>().confirmDialog(
            context,
            title: R.string().commonString.error,
            desc: onError.message,
            positiveBtnTitle: R.string().commonString.btnTryAgain,
          );
    });
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            isTimerCompleted = true;
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  Widget getPinViewOTP() {
    return PinInputTextFormField(
        key: pinFormKey,
        pinLength: 6,
        decoration: BoxLooseDecoration(
    strokeColor: isOtpCheck
        ? appTheme.grayColor
        : isOtpTrue
            ? appTheme.colorPrimary.withOpacity(0.7)
            : appTheme.redColor.withOpacity(0.7),
    gapSpace: getSize(10),
    strokeWidth: getSize(1.5),
    radius: Radius.circular(
      getSize(10),
    ),
    
    solidColor: isOtpCheck
        ? appTheme.colorPrimary.withOpacity(0.1)
        : isOtpTrue
            ? appTheme.colorPrimary.withOpacity(0.7)
            : appTheme.redColor.withOpacity(0.7),
    textStyle: appTheme.getLabelStyle.copyWith(fontSize: getSize(20)),
    errorTextStyle: appTheme.errorLabelStyle.copyWith(
      color: isOtpCheck
          ? appTheme.grayColor
          : isOtpTrue
              ? appTheme.colorPrimary.withOpacity(0.7)
              : appTheme.redColor.withOpacity(0.7),
    ),

    obscureStyle: ObscureStyle(
      isTextObscure: false,
    ),
    hintText: '000000',
    // hintTextStyle: appTheme.black16RegularTextStyle
        ),
        controller: _pinEditingController,
        textInputAction: TextInputAction.done,
        enabled: true,
        inputFormatter: [
    BlacklistingTextInputFormatter(RegExp(RegexForEmoji)),
    ValidatorInputFormatter(
      editingValidator: DecimalNumberEditingRegexValidator(6),
    ),
        ],
        keyboardType: TextInputType.number,
        autovalidate: true,
        onSubmit: (pin) {
    // setState(() {});
    // if (_formKey.currentState.validate()) {
    //   _formKey.currentState.save();
    //   if (pin.trim().length != 4) {
    //     isOtpTrue = false;
    //     isOtpCheck = false;
    //     showOTPMsg = "Please enter OTP";
    //   } else if (pin.trim().length == 4) {
    //     FocusScope.of(context).unfocus();
    //     callApiForVerifyingOtp();
    //   }
    // } else {
    //   setState(() {
    //     isOtpCheck = false;
    //     isOtpTrue = false;
    //   });
    // }
        },
        validator: (text) {
    // if (text.isEmpty) {
    //   isOtpValid = false;
    //   return "Enter Otp";
    // }
    // /* else if(!validateStructure(text)) {
    //       return R.string().errorString.wrongPassword;
    //     } */
    // else {
    //   return null;
    // }
        },
        onChanged: (pin) {
    setState(() {
      isOtpCheck = true;
    });
    // if (pin.trim().length < 4) {
    //   showOTPMsg = null;
    //   isOtpTrue = false;
    // } else if (pin.trim().length == 4) {
    //   callApiForVerifyingOtp();
    // }
    // setState(() {});
        },
      );
  }
}
