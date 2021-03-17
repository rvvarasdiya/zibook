import 'package:flutter/material.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/utils/CommonTextfield.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/navigator.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          right: getSize(30),
          left: getSize(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            SizedBox(
              height: getSize(40),
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
              height: getSize(30),
            ),
            CommonTextfield(
              focusNode: passwordFocus,
              textOption: TextFieldOption(
                hintText: "Password",
                maxLine: 1,
                isSecureTextField: true,
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
            Spacer(),
            AppButton.flat(
              onTap: () {
                // NavigationUtilities.pushRoute(
                //   SignInScreen.route,
                // );
              },
              text: "Sign In",
              backgroundColor: appTheme.colorPrimary,
              textColor: appTheme.whiteColor,
              fitWidth: true,
            ),
            Spacer(),
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
    );
  }
}
