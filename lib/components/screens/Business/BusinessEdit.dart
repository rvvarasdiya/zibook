import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/constant/ColorConstant.dart';
import 'package:zaviato/app/constant/ImageConstant.dart';
import 'package:zaviato/app/utils/CommonTextfield.dart';
import 'package:zaviato/app/utils/CommonWidgets.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/string_utils.dart';
import 'package:zaviato/components/widgets/shared/buttons.dart';
import 'package:zaviato/models/mybusiness/MyBusinessRes.dart';

class BusinessEdit extends StatefulWidget {
  Business model;
  BusinessEdit({Map<String, dynamic> arguments}) {
    if (!isNullEmptyOrFalse(arguments)) {
      // if (!isNullEmptyOrFalse(arguments["moduleType"])) {
      //   moduleType = arguments["moduleType"];
      // }
      if (!isNullEmptyOrFalse(arguments["model"])) {
        model = arguments["model"];
      }
    }
  }
  static const route = "BusinessEdit";
  @override
  _BusinessEditState createState() => _BusinessEditState();
}

class _BusinessEditState extends State<BusinessEdit> {
  TextEditingController businessNameController = new TextEditingController();
  TextEditingController businessEmailController = new TextEditingController();
  TextEditingController businessMobileNumberController =
      new TextEditingController();
  TextEditingController businessDescriptionController =
      new TextEditingController();

  FocusNode businessNameNode = new FocusNode();
  FocusNode businessEmailNode = new FocusNode();
  FocusNode businessMobileNumberNode = new FocusNode();
  FocusNode businessDescriptionNode = new FocusNode();

  bool editBusinessName = false;
  bool editBusinessEmail = false;
  bool editBusinessMobile = false;
  bool editBusinessDesc = false;

  final _formKey = GlobalKey<FormState>();
  bool _isBusinessNameValid = true;
  bool _isBusinessEmailValid = false;
  bool _isBusinessMobileNumberValid = true;
  bool _isbusinessDescriptionValid = true;
  bool _autoValidate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    businessNameController.text = widget.model.name;
    businessEmailController.text = widget.model.getEmailName(widget.model);
    businessMobileNumberController.text =
        widget.model.getMobileName(widget.model);
    businessDescriptionController.text = "It is dummy description";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        backgroundColor: appTheme.colorPrimary,
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: getSize(20), left: 10, right: 30),
              height: getSize(100),
              width: double.infinity,
              decoration: BoxDecoration(color: appTheme.colorPrimary),
              child: Column(
                children: <Widget>[
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      getBackButton(context, isWhite: true),
                      SizedBox(
                        width: getSize(10),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Edit Business Detail",
                              style: appTheme.white18RegularTextStyle,
                            ),
                            Container(
                              // alignment: Alignment.center,
                              // margin: EdgeInsets.only(top: getSize(30)),
                              width: getSize(40),
                              height: getSize(40),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage(userIcon),
                                  fit: BoxFit.fill,
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  new BoxShadow(
                                    color: ColorConstants.getShadowColor,
                                    offset: Offset(0, 5),
                                    blurRadius: 5.0,
                                  ),
                                ],
                              ),

                              // NetworkImage('https://via.placeholder.com/150'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ) /* add child content here */,
            ),
            Padding(
              padding: EdgeInsets.only(top: getSize(100)),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    )),
                child: Form(
                  key: _formKey,
                  autovalidate: _autoValidate,
                  child: ListView(
                    cacheExtent: 1000,
                    padding: EdgeInsets.symmetric(
                        vertical: getSize(25), horizontal: getSize(25)),
                    children: <Widget>[
                      getProfilePhoto(),
                      Padding(
                        padding: EdgeInsets.only(top: getSize(40)),
                        child: Stack(
                          children: [
                            CommonTextfield(
                              enable: editBusinessName,
                              focusNode: businessNameNode,
                              textOption: TextFieldOption(
                                hintText: "Business Name",
                                maxLine: 1,
                                keyboardType: TextInputType.text,
                                inputController: businessNameController,
                                errorBorder: _isBusinessNameValid
                                    ? null
                                    : OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(11)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.red),
                                      ),

                                //   formatter: [ValidatorInputFormatter(
                                // editingValidator: DecimalNumberEditingRegexValidator(10)),]
                              ),
                              inputAction: TextInputAction.next,
                              // onNextPress: () {
                              //   FocusScope.of(context)
                              //       .requestFocus(businessEmailNode);
                              // },
                              // validation: Validator("Please enter a valid email").email,
                              textCallback: (text) {
                                if (_autoValidate) {
                                  if (text.isEmpty) {
                                    setState(() {
                                      _isBusinessNameValid = false;
                                    });
                                  } else {
                                    setState(() {
                                      _isBusinessNameValid = true;
                                    });
                                  }
                                }
                              },
                              validation: (text) {
                                if (text.isEmpty) {
                                  _isBusinessNameValid = false;
                                  return "Enter Business Name";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            Positioned(
                              bottom: 8,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    editBusinessName = true;
                                    FocusScope.of(context)
                                        .requestFocus(businessNameNode);
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.bottomRight,
                                  // color: Colors.green,
                                  width: getSize(30),
                                  height: getSize(30),
                                  child: Image.asset(
                                    editName,
                                    width: getSize(15),
                                    height: getSize(15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: getSize(40)),
                        child: Stack(
                          children: [
                            CommonTextfield(
                              enable: editBusinessEmail,
                              focusNode: businessEmailNode,
                              textOption: TextFieldOption(
                                hintText: "Business Email",
                                maxLine: 1,
                                keyboardType: TextInputType.text,
                                inputController: businessEmailController,
                                errorBorder: _isBusinessEmailValid
                                    ? null
                                    : OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(11)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.red),
                                      ),
                                // postfixWid: Icon(Icons.edit)
                                //   formatter: [ValidatorInputFormatter(
                                // editingValidator: DecimalNumberEditingRegexValidator(10)),]
                              ),
                              inputAction: TextInputAction.next,
                              // onNextPress: () {
                              //   FocusScope.of(context)
                              //       .requestFocus(businessMobileNumberNode);
                              // },
                              // validation: Validator("Please enter a valid email").email,
                              textCallback: (text) {
                                if (_autoValidate) {
                                  if (text.isEmpty) {
                                    setState(() {
                                      _isBusinessEmailValid = false;
                                    });
                                  } else {
                                    setState(() {
                                      _isBusinessEmailValid = true;
                                    });
                                  }
                                }
                              },
                              validation: (text) {
                                if (text.isEmpty) {
                                  _isBusinessEmailValid = false;
                                  return "Enter Business Email";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            Positioned(
                              bottom: 8,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    editBusinessEmail = true;
                                    FocusScope.of(context)
                                        .requestFocus(businessEmailNode);
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.bottomRight,
                                  // color: Colors.green,
                                  width: getSize(30),
                                  height: getSize(30),
                                  child: Image.asset(
                                    editName,
                                    width: getSize(15),
                                    height: getSize(15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: getSize(40)),
                        child: Stack(
                          children: [
                            CommonTextfield(
                              focusNode: businessMobileNumberNode,
                              enable: editBusinessMobile,
                              textOption: TextFieldOption(
                                hintText: "Business Mobile Number",
                                maxLine: 1,
                                keyboardType: TextInputType.number,
                                inputController: businessMobileNumberController,
                                errorBorder: _isBusinessMobileNumberValid
                                    ? null
                                    : OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(11)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.red),
                                      ),
                                formatter: [
                                  ValidatorInputFormatter(
                                      editingValidator:
                                          DecimalNumberEditingRegexValidator(
                                              10)),
                                ],
                                // postfixWid: Icon(Icons.edit),
                              ),
                              inputAction: TextInputAction.next,
                              // onNextPress: () {
                              //   FocusScope.of(context)
                              //       .requestFocus(businessDescriptionNode);
                              // },
                              // validation: Validator("Please enter a valid email").email,
                              textCallback: (text) {
                                if (_autoValidate) {
                                  if (text.isEmpty) {
                                    setState(() {
                                      _isBusinessMobileNumberValid = false;
                                    });
                                  } else {
                                    setState(() {
                                      _isBusinessMobileNumberValid = true;
                                    });
                                  }
                                }
                              },
                              validation: (text) {
                                if (text.isEmpty) {
                                  _isBusinessMobileNumberValid = false;
                                  return "Enter Business Mobile Number";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            Positioned(
                              bottom: 8,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    editBusinessMobile = true;
                                    FocusScope.of(context)
                                        .requestFocus(businessMobileNumberNode);
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.bottomRight,
                                  // color: Colors.green,
                                  width: getSize(30),
                                  height: getSize(30),
                                  child: Image.asset(
                                    editName,
                                    width: getSize(15),
                                    height: getSize(15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: getSize(40)),
                        child: Stack(
                          children: [
                            CommonTextfield(
                              enable: editBusinessDesc,
                              focusNode: businessDescriptionNode,
                              textOption: TextFieldOption(
                                hintText: "Business Description",
                                maxLine: 1,
                                keyboardType: TextInputType.text,
                                inputController: businessDescriptionController,
                                errorBorder: _isbusinessDescriptionValid
                                    ? null
                                    : OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(11)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.red),
                                      ),
                                // postfixWid: Icon(Icons.edit),
                                //   formatter: [ValidatorInputFormatter(
                                // editingValidator: DecimalNumberEditingRegexValidator(10)),]
                              ),
                              inputAction: TextInputAction.next,

                              // validation: Validator("Please enter a valid email").email,
                              textCallback: (text) {
                                if (_autoValidate) {
                                  if (text.isEmpty) {
                                    setState(() {
                                      _isbusinessDescriptionValid = false;
                                    });
                                  } else {
                                    setState(() {
                                      _isbusinessDescriptionValid = true;
                                    });
                                  }
                                }
                              },
                              validation: (text) {
                                if (text.isEmpty) {
                                  _isbusinessDescriptionValid = false;
                                  return "Enter Business Name";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            Positioned(
                              bottom: 8,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    editBusinessDesc = true;
                                    FocusScope.of(context)
                                        .requestFocus(businessDescriptionNode);
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.bottomRight,
                                  // color: Colors.green,
                                  width: getSize(30),
                                  height: getSize(30),
                                  child: Image.asset(
                                    editName,
                                    width: getSize(15),
                                    height: getSize(15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: getSize(20)),
                        child: AppButton.flat(
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              // callLoginApi(context);
                            } else {
                              setState(() {
                                _autoValidate = true;
                              });
                            }
                          },
                          backgroundColor: appTheme.colorPrimary,
                          text: "Okay",
                          textSize: 18,
                          fitWidth: true,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getProfilePhoto() {
    return Padding(
      padding: EdgeInsets.all(getSize(10)),
      child: Container(
        // alignment: Alignment.center,
        // margin: EdgeInsets.only(top: getSize(30)),
        width: getSize(100),
        height: getSize(100),
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(userIcon),
            fit: BoxFit.fitHeight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            new BoxShadow(
              color: ColorConstants.getShadowColor,
              offset: Offset(0, 5),
              blurRadius: 5.0,
            ),
          ],
        ),

        // NetworkImage('https://via.placeholder.com/150'),
      ),
    );
  }
}
