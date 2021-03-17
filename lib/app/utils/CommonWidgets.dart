import 'dart:io';

import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/constant/ImageConstant.dart';
import 'package:zaviato/app/utils/pref_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:intl/intl.dart' as intl;
import 'package:rxbus/rxbus.dart';
import 'package:zaviato/app/localization/app_locales.dart';

import '../../main.dart';
import '../app.export.dart';
import '../constant/ColorConstant.dart';
import '../theme/app_theme.dart';
import 'math_utils.dart';

getBackButton(BuildContext context, {bool isWhite = false}) {
  return InkWell(
    onTap: () {
      Navigator.pop(context);
    },
    child: Padding(
      padding: EdgeInsets.all(getSize(12)),
      child: Container(
        child: Image.asset(
          backButton,
          color: isWhite == true ? Colors.white : Colors.black,
          width: getSize(24),
          height: getSize(24),
          
        ),
      ),
    ),
  );
}

Widget getDividerContainer() {
  return Container(
    child: Divider(
      color: appTheme.dividerColor,
    ),
  );
}

getBarButton(
  BuildContext context,
  String imageName,
  VoidCallback onPressed, {
  bool isBlack = false,
  GlobalKey navigation_key,
}) {
  return IconButton(
    key: navigation_key,
    padding: EdgeInsets.all(3),
    onPressed: onPressed,
    icon: Image.asset(
      imageName,
      color: isBlack == true ? Colors.black : Colors.white,
      width: getSize(22),
      height: getSize(22),
    ),
  );
}

getDrawerButton(BuildContext context, bool isBlack) {
  return IconButton(
    padding: EdgeInsets.all(3),
    onPressed: () {
      // RxBus.post(DrawerEvent(DrawerConstant.OPEN_DRAWER, false),
      //     tag: eventBusTag);
    },
    icon: Image.asset(
      "menu",
      color: isBlack == true ? Colors.black : Colors.white,
      width: getSize(26),
      height: getSize(26),
    ),
  );
}

getBarButtonWithColor(
    BuildContext context, String imageName, VoidCallback onPressed,
    {bool isBlack = false}) {
  return Padding(
    padding: EdgeInsets.only(
      top: getSize(15),
      right: getSize(20),
      bottom: getSize(10),
    ),
    child: Container(
      height: getSize(30),
      width: getSize(30),
      decoration: BoxDecoration(
        color: appTheme.whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(getSize(3))),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(getSize(6)),
          child: Image.asset(
            imageName,
            height: getSize(18),
            width: getSize(18),
            color: isBlack ? Colors.black : Colors.white,
          ),
        ),
      ),
    ),
  );
}

getNavigationTheme(BuildContext context) {
  return TextTheme(
    title: TextStyle(
        color: AppTheme.of(context).buttonTextColor,
        fontFamily: "Gilroy",
        fontWeight: FontWeight.w700,
        fontSize: getSize(20)),
  );
}

fieldFocusChange(BuildContext context, FocusNode nextFocus) {
  FocusScope.of(context).requestFocus(nextFocus);
}

List<BoxShadow> getBoxShadow(BuildContext context, {Offset offset}) {
  return [
    BoxShadow(
      color: appTheme.shadowColor,
      blurRadius: getSize(13),
      spreadRadius: getSize(5),
      offset: offset ?? Offset(0, 0),
    )
  ];
}

Widget getAppBar(BuildContext context, String title,
    {Widget leadingButton,
    List<Widget> actionItems,
    bool isTitleShow = true,
    TextAlign textalign,
    PreferredSize widget,
    Color backgroundColor,
    bool centerTitle}) {
  return AppBar(
    iconTheme: IconThemeData(
      color: appTheme.whiteColor,
    ),
    centerTitle: true,
    elevation: 0.0,
    title: isTitleShow
        ? Text(
            title,
            style: AppTheme.of(context).theme.textTheme.body1.copyWith(
                  color: ColorConstants.blueFontColor,
                  fontWeight: FontWeight.w600,
                  fontSize: getFontSize(20),
                ),
            textAlign: textalign ?? TextAlign.center,
          )
        : Container(),
    textTheme: getNavigationTheme(context),
    leading: leadingButton,
    automaticallyImplyLeading: leadingButton != null,
    backgroundColor: backgroundColor ?? appTheme.whiteColor,
    actions: actionItems == null ? null : actionItems,
    bottom: widget,
  );
}

// double getTableAndMobileSize() {
//   if (app.resolve<PrefUtils>().isTableView) {
//     return 768;
//   } else if (app.resolve<PrefUtils>().isWebView) {
//     return 1244;
//   } else {
//     return 414;
//   }
// }

getTitleText(
  BuildContext context,
  String text, {
  Color color,
  double fontSize,
  TextAlign alignment = TextAlign.left,
  FontWeight fontweight,
  Overflow overflow,
}) {
  return Text(
    text,
    style: AppTheme.of(context).theme.textTheme.display2.copyWith(
          color: color,
          fontFamily: 'Poppins',
          fontSize: fontSize == null ? getSize(16) : fontSize,
          fontWeight: fontweight == null ? FontWeight.w600 : fontweight,
        ),
    textAlign: alignment,
  );
}

Text getBodyText(BuildContext context, String text,
    {Color color,
    double fontSize,
    double letterSpacing,
    bool underline = false,
    alignment: TextAlign.left,
    FontWeight fontweight,
    TextOverflow textoverflow,
    int maxLines = 1}) {
  return Text(
    text,
    style: AppTheme.of(context).theme.textTheme.body2.copyWith(
        color: color,
        fontSize: fontSize == null ? getSize(14) : fontSize,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
        fontWeight: fontweight == null ? FontWeight.normal : fontweight,
        letterSpacing: letterSpacing),
    overflow: textoverflow,
    maxLines: maxLines,
    //overflow: TextOverflow.fade,
    //maxLines: 1,
    textAlign: alignment,
  );
}

bool useWhiteForeground(Color backgroundColor) =>
    1.05 / (backgroundColor.computeLuminance() + 0.05) > 4.5;

changeStatusColor(Color color) async {
  try {
    await FlutterStatusbarcolor.setStatusBarColor(color, animate: false);
    if (useWhiteForeground(color)) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    } else {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    }
  } on PlatformException catch (e) {
    debugPrint(e.toString());
  }
}

changeNavigationColor(Color color) async {
  if (Platform.isAndroid) {
    try {
      await FlutterStatusbarcolor.setNavigationBarColor(color, animate: false);
      if (useWhiteForeground(color)) {
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
      } else {
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }
}
