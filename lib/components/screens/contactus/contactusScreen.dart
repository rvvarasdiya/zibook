import 'package:flutter/material.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/constant/ImageConstant.dart';
import 'package:zaviato/app/utils/CommonTextfield.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/navigator.dart';
import 'package:zaviato/components/screens/feedback/feedbackscreen.dart';
import 'package:zaviato/components/widgets/shared/buttons.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: true,s
      // resizeToAvoidBottomInset: false,
      // backgroundColor: appTheme.colorPrimary,
      appBar: AppBar(
        // toolbarHeight: getSize(80),
        elevation: 0,
        backgroundColor: appTheme.colorPrimary,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        titleSpacing: 0,
        title: Text(
          "Contact Us",
          style: appTheme.white18RegularTextStyle,
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: getSize(80),
            color: appTheme.colorPrimary,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: getSize(30)),
            height: double.infinity,
            decoration: BoxDecoration(
                // color: Color(0xffFAFAFA),
                color: Colors.white,
                boxShadow: [
                  new BoxShadow(
                    // color: appTheme.colorPrimary
                    color: Color(0xff0000001A),
                    offset: Offset(0, -6),
                    blurRadius: 10.0,
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                )),
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: getSize(40),
                ),
                Text(
                  "Leave us a message, we will get contact with you as soon as possible.",
                  style: appTheme.black16RegularTextStyle
                      .copyWith(color: Color(0xffAFAFAF), height: 1.5),
                ),
                CommonTextfield(
                  textOption: TextFieldOption(
                    inputController: nameController,
                    hintText: "Your Name",
                    hintStyleText: appTheme.black16BoldTextStyle
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  textCallback: (Value) {},
                ),
                SizedBox(
                  height: getSize(30),
                ),
                CommonTextfield(
                  textOption: TextFieldOption(
                    inputController: mobileController,
                    hintText: "Mobile Number",
                    hintStyleText: appTheme.black16BoldTextStyle
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  textCallback: (Value) {},
                ),
                SizedBox(
                  height: getSize(30),
                ),
                CommonTextfield(
                  textOption: TextFieldOption(
                    inputController: messageController,
                    hintText: "Message",
                    labelText: "what do you want to tell us about?",
                    hintStyleText: appTheme.black16BoldTextStyle
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  textCallback: (Value) {},
                ),
                SizedBox(
                  height: getSize(130),
                ),
                AppButton.flat(
                  onTap: () {
                    NavigationUtilities.push(FeedbackScreen());
                  },
                  backgroundColor: appTheme.colorPrimary,
                  text: "Send",
                  textSize: 18,
                  textColor: Colors.white,
                  fitWidth: true,
                  icon: Icons.send,
                  padding:
                      EdgeInsets.only(left: getSize(120), right: getSize(120)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
