import 'package:flutter/material.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/utils/CommonTextfield.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/navigator.dart';
import 'package:zaviato/components/screens/feedback/feedbackscreen.dart';
import 'package:zaviato/components/widgets/shared/buttons.dart';

class RegisterBusinessScreen extends StatefulWidget {
  @override
  _RegisterBusinessScreenState createState() => _RegisterBusinessScreenState();
}

class _RegisterBusinessScreenState extends State<RegisterBusinessScreen> {
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessEmailController = TextEditingController();
  TextEditingController businessMobileController = TextEditingController();
  TextEditingController businessDescController = TextEditingController();
  TextEditingController businessTypeController = TextEditingController();
  TextEditingController businessCateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F9FD),
      appBar: AppBar(
        backgroundColor: Color(0xffF8F9FD),
        elevation: 0,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: getSize(30)),
        children: [
          SizedBox(
            height: getSize(30),
          ),
          Text(
            "Registered Business",
            style: appTheme.black22BoldTextStyle,
          ),
          Padding(
            padding: EdgeInsets.only(right: getSize(50), top: getSize(5)),
            child: Text(
              "We do not charge for posting your Business or Products.",
              style: appTheme.black16RegularTextStyle
                  .copyWith(color: Color(0xffAFAFAF)),
            ),
          ),
          SizedBox(
            height: getSize(30),
          ),
          CommonTextfield(
              textOption: TextFieldOption(
                  hintText: "Business Name ",
                  hintStyleText: appTheme.black16BoldTextStyle,
                  inputController: businessNameController),
              textCallback: null),
          SizedBox(
            height: getSize(20),
          ),
          CommonTextfield(
              textOption: TextFieldOption(
                  hintText: "Business Email ",
                  hintStyleText: appTheme.black16BoldTextStyle,
                  inputController: businessEmailController),
              textCallback: null),
          SizedBox(
            height: getSize(20),
          ),
          CommonTextfield(
              textOption: TextFieldOption(
                  hintText: "Business Mobile ",
                  hintStyleText: appTheme.black16BoldTextStyle,
                  inputController: businessMobileController),
              textCallback: null),
          SizedBox(
            height: getSize(20),
          ),
          GestureDetector(
             onTap : (){
              showModalBottomSheet(context: context,
               builder: (context){
                  return Container(
                    height: getSize(100),
                    width: double.infinity,
                    child: Text("data"),
                  );
               });
            },
                      child: CommonTextfield(
               enable: false,
                textOption: TextFieldOption(
                    hintText: "Business type ",
                    hintStyleText: appTheme.black16BoldTextStyle,
                    inputController: businessTypeController),
                textCallback: null),
          ),
          SizedBox(
            height: getSize(20),
          ),
          GestureDetector(
            onTap : (){
              showModalBottomSheet(context: context,
               builder: (context){
                  return Container(
                    height: getSize(100),
                    width: double.infinity,
                    child: Text("data"),
                  );
               });
            },
                      child: CommonTextfield(
              enable: false,
                textOption: TextFieldOption(
                    hintText: "Business Category",
                    hintStyleText: appTheme.black16BoldTextStyle,
                    inputController: businessCateController),
                textCallback: null),
          ),
          SizedBox(
            height: getSize(20),
          ),
          CommonTextfield(
           
              textOption: TextFieldOption(
                  hintText: "Business Description ",
                  hintStyleText: appTheme.black16BoldTextStyle,
                  inputController: businessDescController),
              textCallback: null),
          SizedBox(
            height: getSize(50),
          ),
          AppButton.flat(
            onTap: () {
              // NavigationUtilities.push(FeedbackScreen());
            },
            backgroundColor: appTheme.colorPrimary,
            text: "Register",
            textColor: Colors.white,
            fitWidth: true,
          )
        ],
      ),
    );
  }
}
