import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/utils/CommonTextfield.dart';
import 'package:zaviato/app/utils/CommonWidgets.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/components/widgets/shared/buttons.dart';

class CreatePasswordScreen extends StatefulWidget {
  static const route = "CreatePasswordScreen";

  @override
  _CreatePasswordScreenState createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  FocusNode emailFocus = new FocusNode();

  FocusNode passwordFocus = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
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
                focusNode: emailFocus,
                textOption: TextFieldOption(
                  hintText: "New password",
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
                  hintText: "Confirm Password",
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
                height: getSize(40),
              ),
              AppButton.flat(
                onTap: () {
                  // NavigationUtilities.pushRoute(
                  //   SignInScreen.route,
                  // );
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
    );
  }
}
