import 'package:flutter/material.dart';
import 'package:zaviato/app/AppConfiguration/AppNavigation.dart';
import 'package:zaviato/app/Helper/SyncManager.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/base/ErrorResp.dart';
import 'package:zaviato/app/localization/app_locales.dart';
import 'package:zaviato/app/network/NetworkCall.dart';
import 'package:zaviato/app/network/ServiceModule.dart';
import 'package:zaviato/app/utils/CommonTextfield.dart';
import 'package:zaviato/app/utils/CustomDialog.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/navigator.dart';
import 'package:zaviato/app/utils/navigator.dart';
import 'package:zaviato/app/utils/navigator.dart';
import 'package:zaviato/app/utils/pref_utils.dart';
import 'package:zaviato/app/utils/string_utils.dart';
import 'package:zaviato/components/screens/Auth/SignUpScreen.dart';
import 'package:zaviato/components/screens/dashboard/dashboard.dart';
import 'package:zaviato/components/widgets/shared/buttons.dart';
import 'package:zaviato/models/Auth/LogInResponseModel.dart';

import '../../../main.dart';
import 'ForgetPasswordScreen.dart';

class SignInScreen extends StatefulWidget {
  static const route = "SignInScreen";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  FocusNode emailFocus = new FocusNode();
  FocusNode passwordFocus = new FocusNode();

  final _formKey = GlobalKey<FormState>();
  bool _isUserNameValid = true;
  bool _isPasswordValid = false;
  bool isButtonEnabled = true;
  bool _autoValidate = false;

  @override
  void initState() {
    super.initState();
    emailController.text = "test1@yahoo.com";
    passwordController.text = "soni";
  }

@override
void dispose(){
  emailController.dispose();
  passwordController.dispose();
  emailFocus.dispose();
  passwordFocus.dispose();
  super.dispose();
  // dispose
}
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          body: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: ListView(
              padding: EdgeInsets.only(
                right: getSize(30),
                left: getSize(30),
              ),
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Spacer(),
                SizedBox(
                  height: getSize(100),
                ),
                Text(
                  "Welcome Back,",
                  style: appTheme.black22BoldTextStyle,
                ),
                SizedBox(
                  height: getSize(8),
                ),
                Text(
                  "Sign in to continue",
                  style: appTheme.gray16RegularTextStyle,
                ),
                SizedBox(
                  height: getSize(60),
                ),
                CommonTextfield(
                  focusNode: emailFocus,
                  textOption: TextFieldOption(
                    hintText: "Email/Mobile Number",
                    maxLine: 1,
                    keyboardType: TextInputType.text,
                    inputController: emailController,
                    errorBorder: _isUserNameValid
                        ? null
                        : OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                            borderSide: BorderSide(width: 1, color: Colors.red),
                          ),
                    //   formatter: [ValidatorInputFormatter(
                    // editingValidator: DecimalNumberEditingRegexValidator(10)),]
                  ),
                  inputAction: TextInputAction.next,
                  onNextPress: () {
                    FocusScope.of(context).requestFocus(passwordFocus);
                  },
                  // validation: Validator("Please enter a valid email").email,
                  textCallback: (text) {
                    if (_autoValidate) {
                      if (text.isEmpty) {
                        setState(() {
                          _isUserNameValid = false;
                        });
                      } else if (isNumeric(text) && !validateMobile(text)) {
                        setState(() {
                          _isUserNameValid = false;
                        });
                      } else if (!isNumeric(text) && !validateEmail(text)) {
                        setState(() {
                          _isUserNameValid = false;
                        });
                      } else {
                        setState(() {
                          _isUserNameValid = true;
                        });
                      }
                    }
                  },
                  validation: (text) {
                    if (text.isEmpty) {
                      _isUserNameValid = false;
                      return "Enter email/mobile";
                    } else if (isNumeric(text) && !validateMobile(text)) {
                      _isUserNameValid = false;
                      return "Enter valid mobile";
                    } else if (!isNumeric(text) && !validateEmail(text)) {
                      return "Enter valid Email";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: getSize(40),
                ),
                buildCommonTextfield(),
                SizedBox(
                  height: getSize(20),
                ),
                InkWell(
                  onTap: () {
                    NavigationUtilities.pushRoute(
                      ForgetPasswordScreen.route,
                    );
                  },
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "Forget password?",
                      style: appTheme.getHintTextCommonTextStyle,
                    ),
                  ),
                ),
                // Spacer(),
                SizedBox(
                  height: getSize(60),
                ),
                AppButton.flat(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      callLoginApi(context);
                    } else {
                      setState(() {
                        _autoValidate = true;
                      });
                    }
                  },
                  text: "Sign In",
                  backgroundColor: appTheme.colorPrimary,
                  textSize: getSize(18),
                  textColor: appTheme.whiteColor,
                  fitWidth: true,
                ),
                SizedBox(
                  height: getSize(93),
                ),
                InkWell(
                  onTap: () {
                    NavigationUtilities.pushRoute(
                      SignUpScreen.route,
                    );
                  },
                  child: Center(
                    child: RichText(
                      text: new TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "Don't have an account ?",
                            style: appTheme.black14RegularTextStyle,
                          ),
                          TextSpan(
                            text: ' Create',
                            style: appTheme.colorPrimary14MediumTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getSize(30),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future callLoginApi(BuildContext context) async {
    Map<String, dynamic> req = {};
    req["username"] = emailController.text;
    req["password"] = passwordController.text;

    NetworkCall<LogInResponseModel>()
        .makeCall(
            () => app.resolve<ServiceModule>().networkService().logInApi(req),
            context,
            isProgress: true)
        .then((loginResp) async {
      // save Logged In user
      if (loginResp.data != null) {
        app.resolve<PrefUtils>().saveUser(loginResp.data.user);
        await app.resolve<PrefUtils>().saveUserToken(
              loginResp.data.token.jwt,
            );
        // NavigationUtilities.push(Dashboard());
        //  AppNavigation.shared.movetoHome(isPopAndSwitch: false);
        // await app.resolve<PrefUtils>().saveUserPermission(
        //       loginResp.data.userPermissions,
        //     );
        // await app
        //     .resolve<PrefUtils>()
        //     .saveBoolean("rememberMe", isCheckBoxSelected);
        // await app
        //     .resolve<PrefUtils>()
        //     .saveString("userName", userNameController.text);
        // await app
        //     .resolve<PrefUtils>()
        //     .saveString("passWord", _passwordController.text);
      }

      SyncManager.instance.callMasterSync(
        context,
        () async {
          //success
          // AppNavigation.shared.movetoHome(isPopAndSwitch: true);
          Navigator.of(context).pop();
          NavigationUtilities.push(Dashboard());
        },
        () {},
        isNetworkError: false,
        isProgress: true,
        // id: loginResp.data.user.id,
      ).then((value) {});
    }).catchError((onError) {
      if (onError is ErrorResp) {
        app.resolve<CustomDialogs>().confirmDialog(
              context,
              title: R.string().commonString.error,
              desc: onError.message,
              positiveBtnTitle: R.string().commonString.ok,
            );
      }
    });
  }

  // callLoginApi(BuildContext context) {

  //   Map<String, dynamic> req = {};

  //   NetworkCall<SignUpResponseModel>()
  //       .makeCall(
  //           () => app.resolve<ServiceModule>().networkService().login(req),
  //           context,
  //           isProgress: true)
  //       .then((loginResp) async {

  //       });
  // }

  CommonTextfield buildCommonTextfield() {
    return CommonTextfield(
      focusNode: passwordFocus,
      textOption: TextFieldOption(
        hintText: "Password",
        maxLine: 1,
        isSecureTextField: true,
        keyboardType: TextInputType.text,
        inputController: passwordController,
      ),
      inputAction: TextInputAction.next,
      onNextPress: () {
        // fieldFocusChange(context, _focusPassword);
      },
      // validation: Validator("Please enter a valid email").email,
      textCallback: (text) {
        if (_autoValidate) {
          if (text.isEmpty) {
            setState(() {
              _isPasswordValid = false;
            });
          } else {
            setState(() {
              _isPasswordValid = true;
            });
          }
        }
      },
      validation: (text) {
        if (text.isEmpty) {
          _isPasswordValid = false;
          return "Enter Password";
        }
        /* else if(!validateStructure(text)) {
              return R.string().errorString.wrongPassword;
            } */
        else {
          return null;
        }
      },
    );
  }
}
