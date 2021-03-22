import 'package:flutter/material.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/utils/CommonTextfield.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/navigator.dart';
import 'package:zaviato/app/utils/string_utils.dart';
import 'package:zaviato/components/screens/Auth/SignUpScreen.dart';
import 'package:zaviato/components/widgets/shared/buttons.dart';

import 'ForgetPasswordScreen.dart'; 

class SignInScreen extends StatefulWidget {
  static const route = "SignInScreen";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  FocusNode emailFocus = new FocusNode();
  FocusNode passwordFocus = new FocusNode();

  final _formKey = GlobalKey<FormState>();
  bool _isUserNameValid = true;
  bool _isPasswordValid = false;
  bool isButtonEnabled = true;
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(emailFocus);
      },
      child: SafeArea(
        child: Scaffold(
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
                // Spacer(),
                SizedBox(
                  height: getSize(100),
                ),
                Text(
                  "Welcome Back,",
                  style: appTheme.black22BoldTextStyle,
                ),
                SizedBox(
                  height: getSize(8),
                ),
                Text(
                  "Sign in to continue",
                  style: appTheme.gray16RegularTextStyle,
                ),
                SizedBox(
                  height: getSize(60),
                ),
                CommonTextfield(
                  focusNode: emailFocus,
                  textOption: TextFieldOption(
                    hintText: "Email/Mobile Number",
                    maxLine: 1,
                    keyboardType: TextInputType.text,
                    inputController: emailController,
                    errorBorder: _isUserNameValid
                        ? null
                        : OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                            borderSide: BorderSide(width: 1, color: Colors.red),
                          ),
                    //   formatter: [ValidatorInputFormatter(
                    // editingValidator: DecimalNumberEditingRegexValidator(10)),]
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
                          _isUserNameValid = false;
                        });
                      } else if (isNumeric(text) && !validateMobile(text)) {
                        setState(() {
                          _isUserNameValid = false;
                        });
                      } else if (!isNumeric(text) && !validateEmail(text)) {
                        setState(() {
                          _isUserNameValid = false;
                        });
                      } else {
                        setState(() {
                          _isUserNameValid = true;
                        });
                      }
                    }
                  },
                  validation: (text) {
                    if (text.isEmpty) {
                      _isUserNameValid = false;
                      return "Enter email/mobile";
                    } else if (isNumeric(text) && !validateMobile(text)) {
                      _isUserNameValid = false;
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
                buildCommonTextfield(),
                SizedBox(
                  height: getSize(20),
                ),
                InkWell(
                  onTap: () {
                    NavigationUtilities.pushRoute(
                      ForgetPasswordScreen.route,
                    );
                  },
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "Forget password?",
                      style: appTheme.getHintTextCommonTextStyle,
                    ),
                  ),
                ),
                // Spacer(),
                SizedBox(
                  height: getSize(60),
                ),
                AppButton.flat(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      // callLoginApi(context);
                    } else {
                      setState(() {
                        _autoValidate = true;
                      });
                    }
                  },
                  text: "Sign In",
                  backgroundColor: appTheme.colorPrimary,
                  textColor: appTheme.whiteColor,
                  fitWidth: true,
                ),
                SizedBox(
                  height: getSize(93),
                ),
                InkWell(
                  onTap: () {
                    NavigationUtilities.pushRoute(
                      SignUpScreen.route,
                    );
                  },
                  child: Center(
                    child: RichText(
                      text: new TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "Don't have an account ?",
                            style: appTheme.black14RegularTextStyle,
                          ),
                          TextSpan(
                            text: ' Create',
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

  CommonTextfield buildCommonTextfield() {
    return CommonTextfield(
                focusNode: passwordFocus,
                textOption: TextFieldOption(
                  hintText: "Password",
                  maxLine: 1,
                  isSecureTextField: true,
                  keyboardType: TextInputType.text,
                  inputController: passwordController,
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
                    return "Enter Password";
                  }
                  /* else if(!validateStructure(text)) {
              return R.string().errorString.wrongPassword;
            } */
                  else {
                    return null;
                  }
                },
              );
  }
}
