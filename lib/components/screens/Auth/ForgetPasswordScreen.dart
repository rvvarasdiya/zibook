import 'package:flutter/material.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/utils/CommonTextfield.dart';
import 'package:zaviato/app/utils/CommonWidgets.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/components/widgets/shared/buttons.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const route = "ForgetPasswordScreen";

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController passwordController = new TextEditingController();

  FocusNode passwordFocus = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(
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
                height: getSize(20),
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
                height: getSize(40),
              ),
              AppButton.flat(
                onTap: () {
                  // NavigationUtilities.pushRoute(
                  //   SignInScreen.route,
                  // );
                },
                text: "Register",
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
}
