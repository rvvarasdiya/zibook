import 'dart:ui';

import 'package:flutter/material.dart';

class ColorConstants {
  static Color colorPrimary = fromHex("#7263B3");
  static Color colorAccent = fromHex("#EDFE03");

  //FONT
  static Color headFontColor = fromHex("#2F2F51");
  static Color lightFontColor = fromHex("#9797A8");
  static Color darkFontColor = fromHex("#474AD9");
  static Color blueFontColor = fromHex("#6F8FEA");
  static Color introgrey = fromHex("#999999");

  //Background
  static Color backGroundColor = fromHex("#FAFAFA");
  // static Color backGroundColor = fromHex("#f0eff7");

  //DIVIDER
  static Color getDividerColor = fromHex("#EAEEFC");

  //SHADOW
  static Color getShadowColor = fromHex("#6F8FEA");
  static Color bottomShadowColor = fromHex("#0000001A");

  static Color black = fromHex("#000000");
  static Color getGrayColor = fromHex("#9797A8");
  static Color achievementsBrown = fromHex("#FEB497");
  static Color achievementsLightBrown = fromHex("#F96C7C");
  static Color achievementsLightBlue = fromHex("#5A5DDD");
  static Color achievementsBlue = fromHex("#7D99EC");
  static Color needSupportColor = fromHex("#E3E9FF");
  static Color getProgressBarShadow = fromHex("#8FA8FF");
  static Color getProgressBarShadowLight = fromHex("#CCD7FF");
  static Color getWhiteColor = fromHex("#F4F5F8");
  static Color getGreenColor = fromHex("#28DA66");
  static Color getTimeLineList = fromHex("#6C63FF");
  static Color getAcdemyColor = fromHex("#B668FF");
  static Color getAcdemyShadowColor = fromHex("#599FFF");
  static Color textGray = fromHex("#7B7E84");
  static Color getLightButton = fromHex("#A0BAFF");

  //Report Color
  static Color commentBoxColor = fromHex("#C5C5C5");

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

Map<int, Color> color = {
  50: Color.fromRGBO(255, 206, 15, .1),
  100: Color.fromRGBO(255, 206, 15, .2),
  200: Color.fromRGBO(255, 206, 15, .3),
  300: Color.fromRGBO(255, 206, 15, .4),
  400: Color.fromRGBO(255, 206, 15, .5),
  500: Color.fromRGBO(255, 206, 15, .6),
  600: Color.fromRGBO(255, 206, 15, .7),
  700: Color.fromRGBO(255, 206, 15, .8),
  800: Color.fromRGBO(255, 206, 15, .9),
  900: Color.fromRGBO(255, 206, 15, 1),
};

MaterialColor colorCustom = MaterialColor(0xffffce0f, color);
