import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';

import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/constant/ColorConstant.dart';
import 'package:zaviato/app/constant/constants.dart';
import 'package:zaviato/app/theme/app_theme.dart';
import 'package:zaviato/app/utils/CommonWidgets.dart';
import 'package:zaviato/app/utils/string_utils.dart';
import 'package:zaviato/components/widgets/shared/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:rxbus/rxbus.dart';
import 'package:zaviato/app/app.export.dart';
import 'package:zaviato/app/constant/ApiConstants.dart';
import 'package:zaviato/app/localization/app_locales.dart';
import 'package:zaviato/app/utils/BaseDialog.dart';
import 'package:zaviato/app/utils/BottomSheet.dart';
import 'package:zaviato/app/utils/date_utils.dart';
import 'package:zaviato/components/widgets/rounded_datePicker/rounded_picker.dart';
import "package:zaviato/components/widgets/rounded_datePicker/src/material_rounded_date_picker_style.dart";
import "package:zaviato/components/widgets/rounded_datePicker/src/material_rounded_year_picker_style.dart";
import 'package:webview_flutter/webview_flutter.dart';

import 'math_utils.dart';
import 'navigator.dart';

showToast(
  String msg, {
  BuildContext context,
  ToastGravity gravity,
}) {
  Widget toast = Container(
    padding:
        EdgeInsets.symmetric(horizontal: getSize(16), vertical: getSize(16)),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        getSize(40),
      ),
      color: appTheme.textColor.withOpacity(0.5),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: getTitleText(
              context, isStringEmpty(msg) ? SOMETHING_WENT_WRONG : msg,
              color: Colors.white,
              fontSize: getSize(16),
              alignment: TextAlign.center),
        ),
      ],
    ),
  );

  FlutterToast(context != null ? context : key.currentState.overlay.context)
      .showToast(
          child: toast,
          gravity: gravity != null ? gravity : ToastGravity.BOTTOM,
          toastDuration: Duration(seconds: 2));
}

class CustomDialogs {
  void showToast(String msg) {
    showToast(msg);
  }

  void showProgressDialog(
    BuildContext context,
    String message,
  ) {
    ProgressDialog2.showLoadingDialog(key.currentState.overlay.context, message,
        isCancellable: false);
  }

  void hideProgressDialog() {
    Navigator.pop(key.currentState.overlay.context);
  }

  Future openConfirmationDialog(BuildContext context,
      {OnClickCallback onClickCallback}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(getSize(8)))),
            content: Container(
              width: MathUtilities.screenWidth(context),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    R.string().authStrings.logout,
                    textAlign: TextAlign.center,
                    style: AppTheme.of(context).theme.textTheme.body1.copyWith(
                        fontWeight: FontWeight.w500,
                        color: appTheme.whiteColor),
                  ),
                  SizedBox(
                    height: getSize(20),
                  ),
                  Text(
                    R.string().authStrings.logoutConfirmationMsg,
                    textAlign: TextAlign.center,
                    style: AppTheme.of(context)
                        .theme
                        .textTheme
                        .display2
                        .copyWith(color: ColorConstants.textGray),
                  ),
                  // SizedBox(height: getSize(20),),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          child: Text(
                            R.string().commonString.no,
                            textAlign: TextAlign.center,
                            style: AppTheme.of(context)
                                .theme
                                .textTheme
                                .display2
                                .copyWith(color: ColorConstants.textGray),
                          ),
                        ),
                      ),
                      Container(
                        width: MathUtilities.screenWidth(context) / 2,
                        margin: EdgeInsets.only(top: getSize(30)),
                        child: AppButton.flat(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          borderRadius: 14,
                          fitWidth: true,
                          text: R.string().commonString.yes,
                          //isButtonEnabled: enableDisableSigninButton(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  void logoutDialog(BuildContext context, VoidCallback callback) {
    openConfirmationDialog(context, onClickCallback: (type) {
      if (type == ButtonType.PositveButtonClick) {
        callback();
      }
    });
  }

  void errorDialog(BuildContext context, String title, String disc,
      {String btntitle, VoidCallback voidCallBack}) {
    OpenErrorDialog(context, title, disc,
        btntitle: btntitle, voidCallback: voidCallBack ?? null);
  }

  void confirmDialog(BuildContext context,
      {String title,
      String desc,
      String positiveBtnTitle,
      String negativeBtnTitle,
      OnClickCallback onClickCallback,
      bool dismissPopup: true,
      bool barrierDismissible: false,
      RichText richText}) {
    OpenConfirmationPopUp(context,
        title: title,
        desc: desc,
        positiveBtnTitle: positiveBtnTitle,
        negativeBtnTitle: negativeBtnTitle,
        onClickCallback: onClickCallback,
        dismissPopup: dismissPopup,
        barrierDismissible: barrierDismissible,
        richText: richText);
  }
}

class ProgressDialog2 {
  static Future<void> showLoadingDialog(BuildContext context, String message,
      {bool isCancellable = true}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: isCancellable,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return isCancellable;
          },
          child: SpinKitFadingCircle(
            color: appTheme.whiteColor,
            size: 50.0,
          ),
        );
      },
    );
  }
}

Future OpenErrorDialog(BuildContext context, String title, String disc,
    {String btntitle, VoidCallback voidCallback}) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        //SystemChrome.setEnabledSystemUIOverlays([]);

        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(getSize(8)))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTheme.of(context).theme.textTheme.body1.copyWith(
                    fontWeight: FontWeight.w600, color: appTheme.whiteColor),
              ),
              SizedBox(
                height: getSize(20),
              ),
              Text(
                disc,
                textAlign: TextAlign.center,
                style: AppTheme.of(context).theme.textTheme.display1.copyWith(
                    color: ColorConstants.textGray,
                    fontWeight: FontWeight.normal),
              ),
              // SizedBox(height: getSize(20),),
              btntitle != null
                  ? Container(
                      margin: EdgeInsets.only(top: getSize(30)),
                      child: AppButton.flat(
                        onTap: voidCallback ??
                            () {
                              Navigator.pop(context);
                            },
                        borderRadius: 14,
                        fitWidth: true,
                        text: btntitle,
                        //isButtonEnabled: enableDisableSigninButton(),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        );
      });
}

Future<String> get _localPath async {
  //get local directory path
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> _localFile(String filename) async {
  //save as local file
  final path = await _localPath;
  return File('$path/' + filename + '.pdf');
}

Future<File> writeCounter(Uint8List stream, String filename) async {
  //create file from response
  final file = await _localFile(filename);

  // Write the file
  return file.writeAsBytes(stream);
}

Future<bool> existsFile(String filename) async {
  final file = await _localFile(filename);
  return file.exists();
}

Future<Uint8List> fetchPost(String url) async {
  //get data from url
  final response = await http.get(url);
  final responseJson = response.bodyBytes;

  return responseJson;
}

Future<String> loadPdf(String url, String filename) async {
  await writeCounter(await fetchPost(url), filename);
  await existsFile(filename);
  return (await _localFile(filename)).path;
}

bool isFilePDF(String url) {
  if (url != null && url.split('.').last == 'pdf') return true;

  return false;
}

Future OpenConfirmationPopUp(BuildContext context,
    {String title,
    String desc,
    String positiveBtnTitle,
    String negativeBtnTitle,
    OnClickCallback onClickCallback,
    bool dismissPopup: true,
    bool barrierDismissible: false,
    RichText richText}) {
  Future<bool> _onBackPressed() {
    if (dismissPopup) {
      Navigator.pop(context);
    }
  }

  return showDialog(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: _onBackPressed,
        child: StatefulBuilder(
          builder: (context, setState) {
            //SystemChrome.setEnabledSystemUIOverlays([]);

            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(getSize(8)))),
              child: Container(
                width: MathUtilities.screenWidth(context),
                padding: EdgeInsets.symmetric(
                    horizontal: getSize(10), vertical: getSize(20)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: AppTheme.of(context)
                          .theme
                          .textTheme
                          .body1
                          .copyWith(
                              fontWeight: FontWeight.w600,
                              color: appTheme.whiteColor),
                    ),
                    SizedBox(
                      height: getSize(15),
                    ),
                    desc.isEmpty
                        ? richText
                        : Text(
                            desc,
                            textAlign: TextAlign.center,
                            style: AppTheme.of(context)
                                .theme
                                .textTheme
                                .display1
                                .copyWith(
                                    color: ColorConstants.textGray,
                                    fontWeight: FontWeight.normal),
                          ),
                    // SizedBox(height: getSize(20),),
                    Container(
                      margin: EdgeInsets.only(top: getSize(30)),
                      child: Row(
                        children: <Widget>[
                          negativeBtnTitle != null
                              ? InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    if (onClickCallback != null) {
                                      onClickCallback(
                                          ButtonType.NagativeButtonClick);
                                    }
                                  },
                                  child: Container(
                                    child: Padding(
                                      padding: EdgeInsets.all(getSize(16)),
                                      child: Text(
                                        negativeBtnTitle,
                                        style: appTheme
                                            .colorPrimary14MediumTextStyle,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          negativeBtnTitle != null
                              ? SizedBox(
                                  width: getSize(20),
                                )
                              : SizedBox(),
                          Expanded(
                            child: AppButton.flat(
                              backgroundColor: appTheme.colorPrimary,
                              onTap: () {
                                if (dismissPopup) {
                                  Navigator.pop(context);
                                }
                                if (onClickCallback != null) {
                                  onClickCallback(
                                      ButtonType.PositveButtonClick);
                                }
                              },
                              borderRadius: 14,
                              fitWidth: true,
                              text: positiveBtnTitle,
                              //isButtonEnabled: enableDisableSigninButton(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
