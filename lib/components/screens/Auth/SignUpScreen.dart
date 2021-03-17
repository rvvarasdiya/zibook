import 'package:flutter/material.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/utils/CommonTextfield.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/navigator.dart';
import 'package:zaviato/components/widgets/shared/buttons.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          left: getSize(30),
          right: getSize(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      keyboardType: TextInputType.name,
                      inputController: firstNameController,
                    ),
                    inputAction: TextInputAction.next,
                    onNextPress: () {
                      // fieldFocusChange(context, _focusPassword);
                    },
                    // validation: Validator("Please enter a valid email").email,
                    textCallback: (value) {},
                  ),
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
                      keyboardType: TextInputType.name,
                      inputController: lastNameController,
                    ),
                    inputAction: TextInputAction.next,
                    onNextPress: () {
                      // fieldFocusChange(context, _focusPassword);
                    },
                    // validation: Validator("Please enter a valid email").email,
                    textCallback: (value) {},
                  ),
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
                keyboardType: TextInputType.name,
                inputController: emailController,
              ),
              inputAction: TextInputAction.next,
              onNextPress: () {
                // fieldFocusChange(context, _focusPassword);
              },
              // validation: Validator("Please enter a valid email").email,
              textCallback: (value) {},
            ),
            SizedBox(
              height: getSize(20),
            ),
            CommonTextfield(
              focusNode: mobileFocus,
              textOption: TextFieldOption(
                hintText: "Mobile number",
                maxLine: 1,
                keyboardType: TextInputType.name,
                inputController: mobileController,
              ),
              inputAction: TextInputAction.next,
              onNextPress: () {
                // fieldFocusChange(context, _focusPassword);
              },
              // validation: Validator("Please enter a valid email").email,
              textCallback: (value) {},
            ),
            SizedBox(
              height: getSize(20),
            ),
            CommonTextfield(
              focusNode: passwordFocus,
              textOption: TextFieldOption(
                hintText: "Password",
                maxLine: 1,
                keyboardType: TextInputType.name,
                inputController: passwordController,
              ),
              inputAction: TextInputAction.next,
              onNextPress: () {
                // fieldFocusChange(context, _focusPassword);
              },
              // validation: Validator("Please enter a valid email").email,
              textCallback: (value) {},
            ),
            SizedBox(
              height: getSize(70),
            ),
            AppButton.flat(
              onTap: () {
                NavigationUtilities.pushRoute(
                  OtpVerifyScreen.route,
                );
              },
              text: "Register",
              backgroundColor: appTheme.colorPrimary,
              textColor: appTheme.whiteColor,
              fitWidth: true,
            ),
            Spacer(),
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
    );
  }
}
