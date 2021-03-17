import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/constant/constants.dart';
import 'package:zaviato/app/utils/CommonWidgets.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/navigator.dart';
import 'package:zaviato/app/utils/string_utils.dart';
import 'package:zaviato/components/widgets/pinView_textFields/decoration/pin_decoration.dart';
import 'package:zaviato/components/widgets/pinView_textFields/pin_widget.dart';
import 'package:zaviato/components/widgets/pinView_textFields/style/obscure.dart';
import 'package:zaviato/components/widgets/shared/buttons.dart';

import 'CreatePasswordScreen.dart';

class OtpVerifyScreen extends StatefulWidget {
  static const route = "OtpVerifyScreen";

  @override
  _OtpVerifyScreenState createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final pinFormKey = GlobalKey<FormState>();
  bool isOtpCheck = true; // true when screen load first time for grey color
  bool isOtpTrue = false; //
  TextEditingController _pinEditingController = TextEditingController(text: '');

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
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "00:30",
                  style: appTheme.black14BoldTextStyle,
                ),
              ),
              SizedBox(
                height: getSize(40),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: RichText(
                  text: new TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "Didn't receive OTP code! Resend",
                        style: appTheme.black14RegularTextStyle,
                      ),
                      TextSpan(
                        text: ' Resend',
                        style: appTheme.colorPrimary14MediumTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: getSize(40),
              ),
              AppButton.flat(
                onTap: () {
                  NavigationUtilities.pushRoute(
                    CreatePasswordScreen.route,
                  );
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

  Widget getPinViewOTP() {
    return PinInputTextFormField(
      key: pinFormKey,
      pinLength: 4,
      decoration: BoxLooseDecoration(
        strokeColor: isOtpCheck
            ? appTheme.grayColor
            : isOtpTrue
                ? appTheme.colorPrimary.withOpacity(0.7)
                : appTheme.redColor.withOpacity(0.7),
        gapSpace: getSize(30),
        strokeWidth: getSize(1.5),
        radius: Radius.circular(
          getSize(10),
        ),
        solidColor: isOtpCheck
            ? appTheme.colorPrimary.withOpacity(0.2)
            : isOtpTrue
                ? appTheme.colorPrimary.withOpacity(0.7)
                : appTheme.redColor.withOpacity(0.7),
        textStyle: appTheme.getLabelStyle,
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
        hintText: '',
      ),
      controller: _pinEditingController,
      textInputAction: TextInputAction.done,
      enabled: true,
      inputFormatter: [
        BlacklistingTextInputFormatter(RegExp(RegexForEmoji)),
        ValidatorInputFormatter(
          editingValidator: DecimalNumberEditingRegexValidator(4),
        ),
      ],
      keyboardType: TextInputType.number,
      autovalidate: true,
      onSubmit: (pin) {
        setState(() {});
        // if (_formKey.currentState.validate()) {
        //   _formKey.currentState.save();
        //   if (pin.trim().length != 4) {
        //     isOtpTrue = false;
        //     isOtpCheck = false;
        //     showOTPMsg = R.string().errorString.pleaseEnterOTP;
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
        return "";
      },
      onChanged: (pin) {
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
