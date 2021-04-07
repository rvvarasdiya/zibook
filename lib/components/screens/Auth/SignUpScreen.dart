import 'package:flutter/material.dart';
import 'package:zaviato/app/AppConfiguration/AppNavigation.dart';
import 'package:zaviato/app/Helper/SyncManager.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/constant/EnumConstant.dart';
import 'package:zaviato/app/localization/app_locales.dart';
import 'package:zaviato/app/network/NetworkCall.dart';
import 'package:zaviato/app/network/ServiceModule.dart';
import 'package:zaviato/app/utils/CommonTextfield.dart';
import 'package:zaviato/app/utils/CommonWidgets.dart';
import 'package:zaviato/app/utils/CustomDialog.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/navigator.dart';
import 'package:zaviato/app/utils/pref_utils.dart';
import 'package:zaviato/app/utils/string_utils.dart';
import 'package:zaviato/components/widgets/shared/buttons.dart';
import 'package:zaviato/main.dart';
import 'package:zaviato/models/Auth/SignUpModel.dart';
import 'package:zaviato/models/Auth/SignUpResponseModel.dart';

import 'OtpVerifyScreen.dart';

class SignUpScreen extends StatefulWidget {
  static const route = "SignUpScreen";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FocusNode emailFocus = new FocusNode();
  FocusNode mobileFocus = new FocusNode();
  FocusNode firstNameFocus = new FocusNode();
  FocusNode lastNameFocus = new FocusNode();
  FocusNode passwordFocus = new FocusNode();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isFirstNameValid = true;
  bool _isLastNameValid = true;
  bool _isEmailValid = true;
  bool _isMobileValid = true;
  bool _isPasswordValid = false;
  bool _autoValidate = false;

  // @override
  // void initState() {
  //   super.initState();
  //   FocusScope.of(context).requestFocus(firstNameFocus);
  // }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    mobileController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    firstNameFocus.dispose();
    lastNameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    FocusScope.of(context).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(firstNameFocus);
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          resizeToAvoidBottomPadding: true,
          appBar: getAppBar(
            context,
            "",
            leadingButton: Padding(
              padding: EdgeInsets.all(getSize(15)),
              child: getBackButton(context),
            ),
          ),
          body: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(
                left: getSize(30),
                right: getSize(30),
              ),
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: getSize(100),
                ),
                Text(
                  "Welcome",
                  style: appTheme.black22BoldTextStyle,
                ),
                SizedBox(
                  height: getSize(8),
                ),
                Text(
                  "Sign up to New account",
                  style: appTheme.gray16RegularTextStyle,
                ),
                SizedBox(
                  height: getSize(40),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextfield(
                          focusNode: firstNameFocus,
                          textOption: TextFieldOption(
                            hintText: "First name",
                            maxLine: 1,
                            keyboardType: TextInputType.text,
                            inputController: firstNameController,
                            errorBorder: _isFirstNameValid
                                ? null
                                : OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(11)),
                                    borderSide:
                                        BorderSide(width: 1, color: Colors.red),
                                  ),
                          ),
                          inputAction: TextInputAction.next,
                          onNextPress: () {
                            FocusScope.of(context).requestFocus(lastNameFocus);
                          },
                          // validation: Validator("Please enter a valid email").email,
                          textCallback: (text) {
                            if (_autoValidate) {
                              if (text.isEmpty) {
                                setState(() {
                                  _isFirstNameValid = false;
                                });
                              } else {
                                setState(() {
                                  _isFirstNameValid = true;
                                });
                              }
                            }
                          },
                          validation: (text) {
                            if (text.isEmpty) {
                              _isFirstNameValid = false;
                              return "Enter firstname";
                            } else {
                              return null;
                            }
                          }),
                    ),
                    SizedBox(
                      width: getSize(36),
                    ),
                    Expanded(
                      child: CommonTextfield(
                          focusNode: lastNameFocus,
                          textOption: TextFieldOption(
                            hintText: "Last name",
                            maxLine: 1,
                            keyboardType: TextInputType.text,
                            inputController: lastNameController,
                            errorBorder: _isLastNameValid
                                ? null
                                : OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(11)),
                                    borderSide:
                                        BorderSide(width: 1, color: Colors.red),
                                  ),
                          ),
                          inputAction: TextInputAction.next,
                          onNextPress: () {
                            FocusScope.of(context).requestFocus(emailFocus);
                          },
                          // validation: Validator("Please enter a valid email").email,
                          textCallback: (text) {
                            if (_autoValidate) {
                              if (text.isEmpty) {
                                setState(() {
                                  _isLastNameValid = false;
                                });
                              } else {
                                setState(() {
                                  _isLastNameValid = true;
                                });
                              }
                            }
                          },
                          validation: (text) {
                            if (text.isEmpty) {
                              _isLastNameValid = false;
                              return "Enter lastname";
                            } else {
                              return null;
                            }
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  height: getSize(20),
                ),
                CommonTextfield(
                    focusNode: emailFocus,
                    textOption: TextFieldOption(
                      hintText: "Email address",
                      maxLine: 1,
                      keyboardType: TextInputType.text,
                      inputController: emailController,
                      errorBorder: _isEmailValid
                          ? null
                          : OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.red),
                            ),
                    ),
                    inputAction: TextInputAction.next,
                    onNextPress: () {
                      FocusScope.of(context).requestFocus(mobileFocus);
                    },
                    // validation: Validator("Please enter a valid email").email,
                    textCallback: (text) {
                      if (_autoValidate) {
                        if (text.isEmpty) {
                          setState(() {
                            _isEmailValid = false;
                          });
                        } else if (!validateEmail(text)) {
                          setState(() {
                            _isEmailValid = false;
                          });
                        } else {
                          setState(() {
                            _isEmailValid = true;
                          });
                        }
                      }
                    },
                    validation: (text) {
                      if (text.isEmpty) {
                        _isEmailValid = false;
                        return "Enter email";
                      } else if (!validateEmail(text)) {
                        return "Enter valid Email";
                      } else {
                        return null;
                      }
                    }),
                SizedBox(
                  height: getSize(20),
                ),
                CommonTextfield(
                    focusNode: mobileFocus,
                    textOption: TextFieldOption(
                      hintText: "Mobile number",
                      maxLine: 1,
                      keyboardType: TextInputType.number,
                      inputController: mobileController,
                      errorBorder: _isMobileValid
                          ? null
                          : OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.red),
                            ),
                      formatter: [
                        ValidatorInputFormatter(
                            editingValidator:
                                DecimalNumberEditingRegexValidator(10)),
                      ],
                    ),
                    inputAction: TextInputAction.next,
                    onNextPress: () {
                      FocusScope.of(context).requestFocus(passwordFocus);
                    },
                    // validation: Validator("Please enter a valid email").email,
                    textCallback: (text) {
                      if (_autoValidate) {
                        if (text.isEmpty) {
                          setState(() {
                            _isMobileValid = false;
                          });
                        } else if (!validateMobile(text)) {
                          setState(() {
                            _isMobileValid = false;
                          });
                        } else {
                          setState(() {
                            _isMobileValid = true;
                          });
                        }
                      }
                    },
                    validation: (text) {
                      if (text.isEmpty) {
                        _isMobileValid = false;
                        return "Enter mobile";
                      } else if (!validateMobile(text)) {
                        _isMobileValid = false;
                        return "Enter valid mobile";
                      } else {
                        return null;
                      }
                    }),
                SizedBox(
                  height: getSize(20),
                ),
                CommonTextfield(
                    focusNode: passwordFocus,
                    textOption: TextFieldOption(
                      isSecureTextField: true,
                      hintText: "Password",
                      maxLine: 1,
                      keyboardType: TextInputType.text,
                      inputController: passwordController,
                      errorBorder: _isPasswordValid
                          ? null
                          : OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.red),
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
                            _isPasswordValid = false;
                          });
                        } else {
                          setState(() {
                            _isPasswordValid = true;
                          });
                        }
                      }
                    },
                    validation: (text) {
                      if (text.isEmpty) {
                        _isPasswordValid = false;
                        return "Enter password";
                      } else {
                        return null;
                      }
                    }),
                SizedBox(
                  height: getSize(70),
                ),
                AppButton.flat(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      callSignUpApi(context);
                    } else {
                      setState(() {
                        _autoValidate = true;
                      });
                    }
                  },
                  text: "Register",
                  backgroundColor: appTheme.colorPrimary,
                  textColor: appTheme.whiteColor,
                  fitWidth: true,
                ),
                SizedBox(
                  height: getSize(65),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: RichText(
                      text: new TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Already have an account ?',
                            style: appTheme.black14RegularTextStyle,
                          ),
                          TextSpan(
                            text: ' Sign In',
                            style: appTheme.colorPrimary14MediumTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getSize(30),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  callSignUpApi(BuildContext context) {
    SignUpModel req = SignUpModel();
    req.firstName = firstNameController.text;
    req.lastName = lastNameController.text;
    req.email = emailController.text;
    req.mobile = mobileController.text;
    req.password = passwordController.text;

    NetworkCall<SignUpResponseModel>()
        .makeCall(
            () => app.resolve<ServiceModule>().networkService().signUpApi(req),
            context,
            isProgress: true)
        .then(
      (signUpResp) async {
        // AppNavigation().movetoLogin();

        await app.resolve<PrefUtils>().saveUserToken(
              signUpResp.data.token.jwt,
            );

        // SyncManager.instance.callMasterSync(
        //   context,
        //   () async { 
        //     //success
        //     // AppNavigation.shared.movetoHome(isPopAndSwitch: true);
        //     Navigator.of(context).pop();
        //     NavigationUtilities.push(Dashboard());
        //   },
        //   () {},
        //   isNetworkError: false,
        //   isProgress: true,
        //   // id: loginResp.data.user.id,
        // ).then((value) {});

        Map<String, dynamic> arguments = {};
        arguments["mobile"] = mobileController.text;
        arguments["moduleType"] = OtpPage.SignUP;

        NavigationUtilities.pushRoute(OtpVerifyScreen.route, args: arguments);
      },
    ).catchError((onError) {
      app.resolve<CustomDialogs>().confirmDialog(
            context,
            title: "Email is not exists",
            desc: onError.message,
            positiveBtnTitle: R.string().commonString.btnTryAgain,
          );
      setState(() {});
    });
  }
}
