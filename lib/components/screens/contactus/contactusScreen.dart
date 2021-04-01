import 'package:flutter/material.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/constant/ImageConstant.dart';
import 'package:zaviato/app/network/NetworkCall.dart';
import 'package:zaviato/app/network/NetworkCall.dart';
import 'package:zaviato/app/network/ServiceModule.dart';
import 'package:zaviato/app/utils/CommonTextfield.dart';
import 'package:zaviato/app/utils/CustomDialog.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/navigator.dart';
import 'package:zaviato/app/utils/pref_utils.dart';
import 'package:zaviato/app/utils/string_utils.dart';
import 'package:zaviato/components/screens/feedback/feedbackscreen.dart';
import 'package:zaviato/components/widgets/shared/buttons.dart';
import 'package:zaviato/models/ContactUs/contactUsModel.dart';

import '../../../main.dart';

class ContactUsScreen extends StatefulWidget {
  static const route = "ContctUsScreen";
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isNameValid = true;
  bool _isMessageValid = true;
  bool _isMobileValid = true;
  bool _autoValidate = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      // backgroundColor: appTheme.colorPrimary,
      appBar: AppBar(
        // toolbarHeight: getSize(80),
        elevation: 0,
        backgroundColor: appTheme.colorPrimary,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
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
      body: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Stack(
          
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
                    textCallback: (value) {
                      if (_autoValidate) {
                        if (isNullEmptyOrFalse(value)) {
                          _isNameValid = false;
                        }
                      }
                    },
                    validation: (text) {
                      if (isNullEmptyOrFalse(text)) {
                        _isNameValid = false;
                        return "Enter Your Name";
                      } else
                        return null;
                    },
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
                      keyboardType: TextInputType.number,
                      formatter: [
                        ValidatorInputFormatter(
                          editingValidator:
                              DecimalNumberEditingRegexValidator(10),
                        ),
                      ],
                    ),
                    textCallback: (value) {
                      if (_autoValidate) {
                        if (isNullEmptyOrFalse(value)) {
                          _isMobileValid = false;
                        }
                      }
                    },
                    validation: (text) {
                      if (isNullEmptyOrFalse(text)) {
                        _isMobileValid = false;
                        return "Enter Mobile Number";
                      } else
                        return null;
                    },
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
                    textCallback: (value) {
                      if (_autoValidate) {
                        if (isNullEmptyOrFalse(value)) {
                          _isMessageValid = false;
                        }
                      }
                    },
                    validation: (text) {
                      if (isNullEmptyOrFalse(text)) {
                        _isMessageValid = false;
                        return "Enter Message";
                      } else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: getSize(130),
                  ),
                  AppButton.flat(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        callContactUsApi(context);
                      } else {
                        setState(() {
                          _autoValidate = true;
                        });
                      }
                    },
                    backgroundColor: appTheme.colorPrimary,
                    text: "Send",
                    textSize: 18,
                    textColor: Colors.white,
                    fitWidth: true,
                    icon: Icons.send,
                    padding: EdgeInsets.only(
                        left: getSize(120), right: getSize(120)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  callContactUsApi(BuildContext context) {
    ContactUsReq contactUsReq = ContactUsReq();
    contactUsReq.countryCode = "+91";
    contactUsReq.name = nameController.text;
    List<String> emails = [];
    for (var i in app.resolve<PrefUtils>().getUserDetails().emails) {
      emails.add(i.email);
    }
    if (!isNullEmptyOrFalse(emails)) contactUsReq.email = emails.first;

    contactUsReq.message = messageController.text;
    contactUsReq.phone = mobileController.text;

    NetworkCall<ContactUsRes>()
        .makeCall(
      () =>
          app.resolve<ServiceModule>().networkService().contactUs(contactUsReq),
      context,
      isProgress: true,
    )
        .then((contactUsRes) async {
      showToast(
        contactUsRes.message,
        context: context,
      );
      Navigator.pop(context);
      setState(() {});
    }).catchError((onError) {
      // if (page == DEFAULT_PAGE) {
      //   cateName.clear();
      //   fashionBaseListstate.listCount = cateName.length;
      //   diamondList.state.totalCount = cateName.length;
      //   manageDiamondSelection();
      // }
      print("error");

      // fashionBaseList.state.setApiCalling(false);
    });
  }
}
