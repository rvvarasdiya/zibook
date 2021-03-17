import 'dart:io';

import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/constant/ColorConstant.dart';
import 'package:zaviato/app/constant/ColorConstant.dart';
import 'package:zaviato/app/utils/CommonWidgets.dart';
import 'package:zaviato/components/widgets/shared/app_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class StatefulScreenWidget extends StatefulWidget {
  StatefulScreenWidget({
    Key key,
  }) : super(key: key);
}

abstract class StatefulScreenWidgetState extends State<StatefulScreenWidget> {
  @override
  void initState() {
    super.initState();
    changeNavigationandBottomBarColor();
  }

//  @override
//  void dispose() {
//    // TODO: implement dispose
//    super.dispose();.
//    changeNavigationandBottomBarColor();
//  }

  @override
  Widget build(BuildContext context) {
    return AppBackground();
  }

  changeNavigationandBottomBarColor(
      {bool isCustomColor,
        bool isWhiteTheme = false,
        Color statusBarColor,
        Color bottomBarColor}) {
    if (isCustomColor != null && isCustomColor == true) {
      changeStatusColor(statusBarColor);
      changeNavigationColor(bottomBarColor);
    } else if (isWhiteTheme) {
      changeStatusColor(Colors.white);
      changeNavigationColor(Colors.grey[100]);
    } else {
      // if (Platform.isIOS) {
      changeStatusColor(
        appTheme.colorPrimary,
      );
      // } else {
      //   changeStatusColor(
      //     darken(appTheme.colorPrimary),
      //   );
      // }
      changeNavigationColor(Colors.grey[100]);
    }
  }

  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}
