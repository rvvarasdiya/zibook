import 'dart:async';
import 'dart:math';
import 'package:flutter/rendering.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:flutter/material.dart';
import 'package:zaviato/app/constant/ColorConstant.dart';
import 'package:zaviato/app/constant/ImageConstant.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/navigator.dart';
import 'package:zaviato/components/screens/Auth/SignInScreen.dart';
import 'package:zaviato/components/widgets/shared/buttons.dart';

class WelcomeScreen extends StatefulWidget {
  static const route = "WelcomeScreen ";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    // FocusScope.of(context).requestFocus(new FocusNode());
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: MathUtilities.screenHeight(context),
            width: MathUtilities.screenWidth(context),
            child: Image.asset(
              splashBgImage,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: getSize(30),
              right: getSize(30),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome to',
                  style: appTheme.white38RegularTextStyle,
                ),
                Text(
                  'Suratmart',
                  style: appTheme.white32BoldTextStyle,
                ),
                SizedBox(
                  height: getSize(20),
                ),
                Text(
                  "All your Business updates in one place",
                  style: appTheme.white18RegularTextStyle,
                ),
                SizedBox(
                  height: getSize(40),
                ),
                AppButton.flat(
                  onTap: () {
                    NavigationUtilities.pushReplacementNamed(
                      SignInScreen.route,
                    );
                  },
                  text: "Get started",
                  backgroundColor: appTheme.whiteColor,
                  textSize: getSize(18),
                  textColor: appTheme.colorPrimary,
                  fitWidth: true,
                ),
                SizedBox(
                  height: getSize(30),
                ),
                InkWell(
                  onTap: () {
                    NavigationUtilities.pushRoute(SignInScreen.route);
                  },
                  child: RichText(
                    text: new TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Already have an account ?',
                          style: appTheme.white14RegularTextStyle,
                        ),
                        TextSpan(
                          text: ' Sign In',
                          style: appTheme.white16BoldTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: getSize(40),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
