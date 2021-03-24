import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/constant/ImageConstant.dart';
import 'package:zaviato/app/utils/CommonTextfield.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/components/widgets/shared/buttons.dart';

class EditProfileScreen extends StatefulWidget {
  static const route = "EditProfileScreen";
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController firstNameController =
      TextEditingController(text: "Tome");
  TextEditingController lastNameController =
      TextEditingController(text: "Latham");
  TextEditingController emailController =
      TextEditingController(text: "tomelatham@gmail.com");
  TextEditingController mobileController =
      TextEditingController(text: "+91 98256 23569");

  bool editFirstName = false;
  bool editLastName = false;
  bool editEmail = false;
  bool editMobile = false;
  FocusNode emailFocus = new FocusNode();
  FocusNode mobileFocus = new FocusNode();
  FocusNode firstNameFocus = new FocusNode();
  FocusNode lastNameFocus = new FocusNode();
  // FocusNode passwordFocus = new FocusNode();

  final _formKey = GlobalKey<FormState>();

  bool _isFirstNameValid = true;
  bool _isLastNameValid = true;
  bool _isEmailValid = true;
  bool _isMobileValid = true;
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colorPrimary,
      appBar: AppBar(
        // toolbarHeight: getSize(80),
        elevation: 0,
        backgroundColor: appTheme.colorPrimary,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Text(
          "Profile Edit",
          style: appTheme.white18RegularTextStyle,
        ),
      ),
      body: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Container(
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
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(firstNameFocus),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: getSize(30),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Stack(
                      children: [
                        CircleAvatar(
                            radius: getSize(
                              50,
                            ),
                            backgroundColor: Colors.white,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(getSize(100)),
                              child: Image.asset(
                                userIcon,
                                height: getSize(100),
                                width: getSize(100),
                              ),
                            )),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                              alignment: Alignment.center,
                              width: getSize(100),
                              height: getSize(20),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(editImage))),
                              child: Text(
                                "Edit",
                                style: appTheme.white14RegularTextStyle,
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: getSize(30),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            CommonTextfield(
                              enable: editFirstName,
                              focusNode: firstNameFocus,
                              textOption: TextFieldOption(
                                inputController: firstNameController,
                                hintText: "First Name",
                                hintStyleText: appTheme.black16BoldTextStyle
                                    .copyWith(fontWeight: FontWeight.bold),
                                // postfixWidOnFocus: Image.asset(
                                //   editName,
                                //   width: getSize(15),
                                //   height: getSize(15),
                                // ),
                              ),
                              textCallback: (Value) {},
                            ),
                            Positioned(
                              bottom: 8,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    editFirstName = true;
                                     FocusScope.of(context).requestFocus(firstNameFocus);
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
                      SizedBox(
                        width: getSize(30),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            CommonTextfield(
                              enable: editLastName,
                              focusNode: lastNameFocus,
                              textOption: TextFieldOption(
                                inputController: firstNameController,
                                hintText: "Last Name",
                                hintStyleText: appTheme.black16BoldTextStyle
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              textCallback: (Value) {},
                            ),
                            Positioned(
                              bottom: 8,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    editLastName = true;
                                     FocusScope.of(context).requestFocus(lastNameFocus);
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
                    ],
                  ),
                  SizedBox(
                    height: getSize(40),
                  ),
                  Stack(
                    children: [
                      CommonTextfield(
                        enable: editEmail,
                        focusNode: emailFocus,
                        textOption: TextFieldOption(
                          inputController: emailController,
                          hintText: "Email",
                          hintStyleText: appTheme.black16BoldTextStyle
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        textCallback: (Value) {},
                      ),
                      Positioned(
                        bottom: 8,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            print("edit email -- ");
                            setState(() {
                              editEmail = true;
                              FocusScope.of(context).requestFocus(emailFocus);
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
                  SizedBox(
                    height: getSize(40),
                  ),
                  Stack(
                    children: [
                      CommonTextfield(
                        enable: editMobile,
                        // autoFocus: editMobile,
                        focusNode: mobileFocus,
                        textOption: TextFieldOption(
                          inputController: mobileController,
                          hintText: "Mobile Number",
                          hintStyleText: appTheme.black16BoldTextStyle
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        textCallback: (Value) {},
                      ),
                      Positioned(
                        bottom: 8,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            print("mobile edit - ");
                            setState(() {
                              editMobile = true;
                              FocusScope.of(context).requestFocus(mobileFocus);
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
                  SizedBox(
                    height: getSize(100),
                  ),
                  AppButton.flat(
                    onTap: () {},
                    backgroundColor: appTheme.colorPrimary,
                    text: "Save",
                    textSize: 18,
                    textColor: Colors.white,
                    fitWidth: true,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
