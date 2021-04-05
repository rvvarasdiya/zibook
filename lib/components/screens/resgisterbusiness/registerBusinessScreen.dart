import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/base/BaseApiResp.dart';
import 'package:zaviato/app/constant/ColorConstant.dart';
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
import 'package:zaviato/models/Master/MasterResponse.dart';
import 'package:zaviato/models/RegisterBusiness/RegisterBusiness.dart';
import 'package:zaviato/models/cities/citiesModel.dart' as city;
import 'package:zaviato/models/cities/citiesModel.dart';

import '../../../main.dart';

class RegisterBusinessScreen extends StatefulWidget {
  static const route = "RegisterBusinessScreen";
  @override
  _RegisterBusinessScreenState createState() => _RegisterBusinessScreenState();
}

class _RegisterBusinessScreenState extends State<RegisterBusinessScreen> {
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();
  TextEditingController businessPostcodeController = TextEditingController();
  TextEditingController businessEmailController = TextEditingController();
  TextEditingController businessMobileController = TextEditingController();
  TextEditingController businessDescController = TextEditingController();
  TextEditingController businessStateController = TextEditingController();
  TextEditingController businessCateController = TextEditingController();
  TextEditingController businessCityController = TextEditingController();

  FocusNode businessNameFocus = FocusNode();
  FocusNode businessAddressFocus = FocusNode();
  FocusNode businessPostcodeFocus = FocusNode();
  FocusNode businessEmailFocus = FocusNode();
  FocusNode businessMobileFocus = FocusNode();
  FocusNode businessDescFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  bool _isBusinessNameValid = true;
  bool _isBusinessAddressValid = true;
  bool _isBusinessPostcodeValid = true;
  bool _isBusinessEmailValid = false;
  bool _isBusinessMobileNumberValid = true;
  bool _isbusinessDescriptionValid = true;
  bool _autoValidate = false;

  List<States> stateLists = [];
  List<city.Data> cityLists = [];
  List<Categories> categoriesList = [];
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";

  @override
  void initState() {
    super.initState();
    stateLists = app.resolve<PrefUtils>().getMaster().data.states;
    categoriesList = app.resolve<PrefUtils>().getMaster().data.categories;
    print(stateLists.length);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: ColorConstants.backGroundColor,
        appBar: AppBar(
          backgroundColor: ColorConstants.backGroundColor,
          elevation: 0,
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: ListView(
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
                  onNextPress: () {
                    FocusScope.of(context).requestFocus(businessEmailFocus);
                  },
                  focusNode: businessNameFocus,
                  inputAction: TextInputAction.next,
                  textOption: TextFieldOption(
                    hintText: "Business Name ",
                    hintStyleText: appTheme.black16BoldTextStyle,
                    inputController: businessNameController,
                    keyboardType: TextInputType.text,
                    errorBorder: _isBusinessNameValid
                        ? null
                        : OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                            borderSide: BorderSide(width: 1, color: Colors.red),
                          ),
                  ),
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
                      return "Enter businessname";
                    } else {
                      return null;
                    }
                  }),
              SizedBox(
                height: getSize(20),
              ),
              CommonTextfield(
                  focusNode: businessEmailFocus,
                  inputAction: TextInputAction.next,
                  onNextPress: () =>
                      FocusScope.of(context).requestFocus(businessMobileFocus),
                  textOption: TextFieldOption(
                      hintText: "Business Email ",
                      hintStyleText: appTheme.black16BoldTextStyle,
                      keyboardType: TextInputType.text,
                      inputController: businessEmailController),
                  textCallback: (text) {
                    if (_autoValidate) {
                      if (text.isEmpty) {
                        setState(() {
                          _isBusinessEmailValid = false;
                        });
                      } else if (!validateEmail(text)) {
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
                      return "Enter businessemail";
                    } else {
                      return null;
                    }
                  }),
              SizedBox(
                height: getSize(20),
              ),
              CommonTextfield(
                  focusNode: businessMobileFocus,
                  inputAction: TextInputAction.next,
                  onNextPress: () =>
                      FocusScope.of(context).requestFocus(businessDescFocus),
                  textOption: TextFieldOption(
                      keyboardType: TextInputType.number,
                      hintText: "Business Mobile ",
                      formatter: [
                        ValidatorInputFormatter(
                            editingValidator:
                                DecimalNumberEditingRegexValidator(10)),
                      ],
                      hintStyleText: appTheme.black16BoldTextStyle,
                      errorBorder: _isBusinessMobileNumberValid
                          ? null
                          : OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.red),
                            ),
                      inputController: businessMobileController),
                  textCallback: (text) {
                    if (_autoValidate) {
                      if (text.isEmpty) {
                        setState(() {
                          _isBusinessMobileNumberValid = false;
                        });
                      } else if (!validateMobile(text)) {
                        print("mobile lenghth  --");
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
                      return "Enter business mobile";
                    } else {
                      return null;
                    }
                  }),
              SizedBox(
                height: getSize(20),
              ),
              CommonTextfield(
                  focusNode: businessDescFocus,
                  onNextPress: () =>
                      FocusScope.of(context).requestFocus(new FocusNode()),
                  textOption: TextFieldOption(
                      hintText: "Business Description ",
                      hintStyleText: appTheme.black16BoldTextStyle,
                      inputController: businessDescController),
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
                      return "Enter business description";
                    } else {
                      return null;
                    }
                  }),
              SizedBox(
                height: getSize(20),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        getSize(20),
                      ),
                      topRight: Radius.circular(
                        getSize(20),
                      ),
                    )),
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: getSize(8.0)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: categoriesList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      businessCateController.text =
                                          categoriesList[index].name;
                                      // callApiForCityList(stateLists[index].sId);
                                      Navigator.pop(context);
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(getSize(10)),
                                          child:
                                              Text(categoriesList[index].name),
                                        ),
                                        (index != categoriesList.length - 1)
                                            ? Divider()
                                            : Container()
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: CommonTextfield(
                  enable: false,
                  inputAction: TextInputAction.next,
                  textOption: TextFieldOption(
                    hintText: "Business Category",
                    keyboardType: TextInputType.text,
                    hintStyleText: appTheme.black16BoldTextStyle,
                    inputController: businessCateController,
                  ),
                  textCallback: (value) {},
                ),
              ),
              SizedBox(
                height: getSize(20),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          getSize(20),
                        ),
                        topRight: Radius.circular(
                          getSize(20),
                        ),
                      )),
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: getSize(8.0)),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: stateLists.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    businessStateController.text =
                                        stateLists[index].name;
                                    callApiForCityList(stateLists[index].sId);
                                    Navigator.pop(context);
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(getSize(10)),
                                        child: Text(stateLists[index].name),
                                      ),
                                      (index != stateLists.length - 1)
                                          ? Divider()
                                          : Container()
                                    ],
                                  ),
                                );
                              }),
                        );
                      });
                },
                child: CommonTextfield(
                  enable: false,
                  textOption: TextFieldOption(
                    hintText: "State",
                    hintStyleText: appTheme.black16BoldTextStyle,
                    inputController: businessStateController,
                  ),
                  textCallback: (value) {},
                ),
              ),
              SizedBox(
                height: getSize(20),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          getSize(20),
                        ),
                        topRight: Radius.circular(
                          getSize(20),
                        ),
                      )),
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: getSize(8.0)),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: cityLists.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    businessCityController.text =
                                        cityLists[index].name;
                                    Navigator.pop(context);
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(getSize(10)),
                                        child: Text(cityLists[index].name),
                                      ),
                                      (index != cityLists.length - 1)
                                          ? Divider()
                                          : Container()
                                    ],
                                  ),
                                );
                              }),
                        );
                      });
                },
                child: CommonTextfield(
                  enable: false,
                  textOption: TextFieldOption(
                    hintText: "City",
                    hintStyleText: appTheme.black16BoldTextStyle,
                    inputController: businessCityController,
                  ),
                  textCallback: null,

                ),
              ),
               SizedBox(
                height: getSize(20),
              ),
              CommonTextfield(
                  onNextPress: () {
                    FocusScope.of(context).requestFocus(businessAddressFocus);
                  },
                  focusNode: businessAddressFocus,
                  inputAction: TextInputAction.next,
                  textOption: TextFieldOption(
                    hintText: "Business Address",
                    hintStyleText: appTheme.black16BoldTextStyle,
                    inputController: businessAddressController,
                    keyboardType: TextInputType.text,
                    errorBorder: _isBusinessAddressValid
                        ? null
                        : OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                            borderSide: BorderSide(width: 1, color: Colors.red),
                          ),
                  ),
                  textCallback: (text) {
                    if (_autoValidate) {
                      if (text.isEmpty) {
                        setState(() {
                          _isBusinessAddressValid = false;
                        });
                      } else {
                        setState(() {
                          _isBusinessAddressValid = true;
                        });
                      }
                    }
                  },
                  validation: (text) {
                    if (text.isEmpty) {
                      _isBusinessAddressValid = false;
                      return "Enter business address";
                    } else {
                      return null;
                    }
                  }),
              SizedBox(
                height: getSize(20),
              ),
               
              CommonTextfield(
                  focusNode: businessPostcodeFocus,
                  inputAction: TextInputAction.next,
                  onNextPress: () =>
                      FocusScope.of(context).requestFocus(businessPostcodeFocus),
                  textOption: TextFieldOption(
                      keyboardType: TextInputType.number,
                      hintText: "Business Postal Code",
                      formatter: [
                        ValidatorInputFormatter(
                            editingValidator:
                                DecimalNumberEditingRegexValidator(6)),
                      ],
                      hintStyleText: appTheme.black16BoldTextStyle,
                      errorBorder: _isBusinessPostcodeValid
                          ? null
                          : OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.red),
                            ),
                      inputController: businessPostcodeController),
                  textCallback: (text) {
                    if (_autoValidate) {
                      if (text.isEmpty) {
                        setState(() {
                          _isBusinessPostcodeValid = false;
                        });
                      } else if (!validateMobile(text)) {
                        print("mobile lenghth  --");
                        setState(() {
                          _isBusinessPostcodeValid = false;
                        });
                      } else {
                        setState(() {
                          _isBusinessPostcodeValid = true;
                        });
                      }
                    }
                  },
                  validation: (text) {
                    if (text.isEmpty) {
                      _isBusinessPostcodeValid = false;
                      return "Enter business Postal code";
                    } else {
                      return null;
                    }
                  }),
              
              SizedBox(
                height: getSize(50),
              ),
              AppButton.flat(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    callRegisterBusinessApi(context);
                  } else {
                    setState(() {
                      _autoValidate = true;
                    });
                  }
                },
                backgroundColor: appTheme.colorPrimary,
                text: "Register",
                textSize: 18,
                textColor: Colors.white,
                fitWidth: true,
              ),
              SizedBox(
                height: getSize(50),
              ),
            ],
          ),
        ),
      ),
    );
  }

  callApiForCityList(String stateId) {
    NetworkCall<Cities>()
        .makeCall(
      () => app.resolve<ServiceModule>().networkService().getAllCity(stateId),
      context,
      isProgress: true,
    )
        .then((citiesRes) async {
      cityLists.clear();
      cityLists.addAll(citiesRes.data);
      setState(() {});
      // showToast(contactUsRes.message,context:context,);
      // Navigator.pop(context);
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

  callRegisterBusinessApi(BuildContext context) {
    RegisterBusinessReq contactUsReq = RegisterBusinessReq();
    contactUsReq.countryCode = "+91";
    contactUsReq.name = businessNameController.text;
    contactUsReq.mobile = businessMobileController.text;

    // List<String> emails = [];
    // for(var i in app.resolve<PrefUtils>().getUserDetails().emails){
    //   emails.add(i.email);
    // }
    // if(!isNullEmptyOrFalse(emails))
    //   contactUsReq.email = emails.first;

    // contactUsReq.message = messageController.text;
    // contactUsReq.phone = mobileController.text;
    for (var cate in categoriesList) {
      if (cate.name == businessCateController.text) {
        contactUsReq.category = cate.sId;
        break;
      }
    }

    for (var state in stateLists) {
      if (state.name == businessStateController.text) {
        contactUsReq.state = state.sId;
        break;
      }
    }

    for (var city in cityLists) {
      if (city.name == businessCityController.text) {
        contactUsReq.city = city.sId;
        break;
      }
    }

    contactUsReq.address = businessAddressController.text;
    contactUsReq.postalCode = businessPostcodeController.text;

    NetworkCall<BaseApiResp>()
        .makeCall(
      () => app
          .resolve<ServiceModule>()
          .networkService()
          .registerBusiness(contactUsReq),
      context,
      isProgress: true,
    )
        .then((contactUsRes) async {
      showToast(
        "your business has been added.",
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
      print(onError.runtimeType);
      // fashionBaseList.state.setApiCalling(false);
    });
  }
}
