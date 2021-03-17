import 'package:flutter/material.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/utils/CommonTextfield.dart';
import 'package:zaviato/app/utils/CommonWidgets.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/navigator.dart';
import 'package:zaviato/app/utils/string_utils.dart';
import 'package:zaviato/components/screens/Auth/OtpVerifyScreen.dart';
import 'package:zaviato/components/widgets/shared/buttons.dart';

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
                      NavigationUtilities.pushRoute(OtpVerifyScreen.route);
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
}
