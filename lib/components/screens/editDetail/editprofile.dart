import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/constant/ImageConstant.dart';
import 'package:zaviato/app/constant/constants.dart';
import 'package:zaviato/app/network/Uploadmanager.dart';
import 'package:zaviato/app/utils/CommonTextfield.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/string_utils.dart';
import 'package:zaviato/components/widgets/shared/buttons.dart';

class EditProfileScreen extends StatefulWidget {
  static const route = "EditProfileScreen";
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isProfileImageUpload = false;
  File profileImage;
  String image;

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
  bool autovalidate = false;
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

  String imgPath = "";
  File profile;

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
                                borderRadius:
                                    BorderRadius.circular(getSize(100)),
                                child: isNullEmptyOrFalse(profile)
                                    ? Image.asset(userIcon)
                                    :
                                    // isProfileImageUpload ?
                                    Image.file(
                                        profile,
                                        width: getSize(120),
                                        height: getSize(120),
                                        fit: BoxFit.cover,
                                      )
                                // : getImageView(
                                //     image ?? "",
                                //     width: getSize(120),
                                //     height: getSize(120),
                                //     placeHolderImage: placeHolder,
                                //     fit: BoxFit.cover,
                                //   ),
                                )),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              showprofileImageBottomSheet(context, (img) async {
                                await uploadDocument(img);
                              });
                            },
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
                          ),
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
                                errorBorder: _isFirstNameValid
                                    ? null
                                    : OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(11)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.red),
                                      ),
                              ),
                              textCallback: (text) {
                                if (_autoValidate) {
                                  if (text.isEmpty) {
                                    setState(() {
                                      _isFirstNameValid = false;
                                    });
                                  }
                                }
                              },
                              validation: (text) {
                                if (text.isEmpty) {
                                  _isFirstNameValid = false;
                                  return "Enter FirstName";
                                }
                              },
                            ),
                            Positioned(
                              bottom: 8,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    editFirstName = true;
                                    FocusScope.of(context)
                                        .requestFocus(firstNameFocus);
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
                                errorBorder: _isLastNameValid
                                    ? null
                                    : OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(11)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.red),
                                      ),
                              ),
                              textCallback: (text) {
                                if (_autoValidate) {
                                  if (text.isEmpty) {
                                    setState(() {
                                      _isLastNameValid = false;
                                    });
                                  }
                                }
                              },
                              validation: (text) {
                                if (text.isEmpty) {
                                  _isLastNameValid = false;
                                  return "Enter LastName";
                                }
                              },
                            ),
                            Positioned(
                              bottom: 8,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    editLastName = true;
                                    FocusScope.of(context)
                                        .requestFocus(lastNameFocus);
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
                          errorBorder: _isEmailValid
                              ? null
                              : OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(11)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.red),
                                ),
                        ),
                        textCallback: (text) {
                          if (_autoValidate) {
                            if (text.isEmpty) {
                              setState(() {
                                _isEmailValid = false;
                              });
                            }
                          }
                        },
                        validation: (text) {
                          if (text.isEmpty) {
                            _isEmailValid = false;
                            return "Enter Email Address";
                          }
                        },
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
                          errorBorder: _isMobileValid
                              ? null
                              : OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(11)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.red),
                                ),
                        ),
                        textCallback: (text) {
                          if (_autoValidate) {
                            if (text.isEmpty) {
                              setState(() {
                                _isMobileValid = false;
                              });
                            }
                          }
                        },
                        validation: (text) {
                          if (text.isEmpty) {
                            _isMobileValid = false;
                            return "Enter Mobile Number";
                          }
                        },
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
                    onTap: () {
                      FocusScope.of(context).unfocus();
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

  void showprofileImageBottomSheet(context, Function getImgFile) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
      builder: (BuildContext bc) {
        return Container(
          height: height * 0.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton.icon(
                onPressed: () async {
                  Navigator.pop(context, true);
                  var image = await ImagePicker.pickImage(
                      source: ImageSource.camera,
                      imageQuality: 50,
                      maxHeight: 2080,
                      maxWidth: 2080);

                  File cropImage = await ImageCropper.cropImage(
                    sourcePath: image.path,
                    maxHeight: 2080,
                    maxWidth: 2080,
                    aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
                    androidUiSettings: AndroidUiSettings(
                        statusBarColor: appTheme.colorPrimary,
                        backgroundColor: Colors.white,
//                                              toolbarTitle: 'Crop Image',
                        toolbarColor: appTheme.colorPrimary,
                        toolbarWidgetColor: Colors.white),
                  );
//

                  setState(() {
                    profile = cropImage;
                    getImgFile(cropImage);
                  });
                },
                icon: Icon(
                  Icons.camera_alt,
                  color: appTheme.colorPrimary.withOpacity(0.5),
                ),
                label: Text(
                  'Camera',
                  style: TextStyle(
                    fontFamily: "Segoe",
                    color: appTheme.colorPrimary,
                    fontWeight: FontWeight.w500,
                    fontSize: getSize(14),
                  ),
                ),
              ),
              FlatButton.icon(
                onPressed: () async {
                  Navigator.pop(context, true);
                  var image = await ImagePicker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 50,
                      maxHeight: 2080,
                      maxWidth: 2080);

                  File cropImage = await ImageCropper.cropImage(
                    sourcePath: image.path,
                    maxHeight: 2080,
                    maxWidth: 2080,
                    aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
                    androidUiSettings: AndroidUiSettings(
                        statusBarColor: appTheme.colorPrimary,
                        backgroundColor: Colors.white,
//                                              toolbarTitle: 'Crop Image',
                        toolbarColor: appTheme.colorPrimary,
                        toolbarWidgetColor: Colors.white),
                  );
//

                  setState(() {
                    profile = cropImage;
                  });
                },
                icon: Icon(
                  Icons.photo_library,
                  color: appTheme.colorPrimary.withOpacity(0.5),
                ),
                label: Text(
                  'Gallery',
                  style: TextStyle(
                    fontFamily: "Segoe",
                    color: appTheme.colorPrimary,
                    fontWeight: FontWeight.w500,
                    fontSize: getSize(14),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  uploadDocument(File profileImg) async {
    var imgProfile;
    if (!isProfileImageUpload) {
      await uploadProfileImage(profileImg, (imagePath) {
        imgProfile = imagePath;
      });
    }
  }

  uploadProfileImage(File imgFile, Function imagePath) async {
    uploadFile(
      context,
      "/",
      file: imgFile,
    ).then((result) {
      String imgPathdummy =
          result.detail.files != null && result.detail.files.length > 0
              ? result.detail.files.first.absolutePath
              : "";
      print(imgPathdummy +
          "--------------------------------------------------------");
      if (result.code == CODE_OK) {
        String imgPath =
            result.detail.files != null && result.detail.files.length > 0
                ? result.detail.files.first.absolutePath
                : "";
        if (isNullEmptyOrFalse(imgPath) == false) {
          imagePath(imgPath);
          // callPersonalInformationApi(imagePath: imgPath);
        }
      }
      return;
    });
  }
}
