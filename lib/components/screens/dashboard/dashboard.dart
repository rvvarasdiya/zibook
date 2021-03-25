import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:rxbus/rxbus.dart';
import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/constant/ColorConstant.dart';
import 'package:zaviato/app/constant/ImageConstant.dart';
import 'package:zaviato/app/theme/app_theme.dart';
import 'package:zaviato/app/utils/BaseDialog.dart';
import 'package:zaviato/app/utils/CommonWidgets.dart';
import 'package:zaviato/app/utils/dialogs.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/navigator.dart';
import 'package:zaviato/app/utils/pref_utils.dart';
import 'package:zaviato/components/screens/contactus/contactusScreen.dart';
import 'package:zaviato/components/screens/dashboard/homescreen.dart';
import 'package:zaviato/components/screens/dashboard/BottomNavModel.dart';
import 'package:zaviato/components/screens/resgisterbusiness/registerBusinessScreen.dart';
import 'package:zaviato/components/widgets/shared/app_background.dart';
import 'package:zaviato/main.dart';

import '../../../app/app.export.dart';
import 'chatscreen.dart';
import 'notificationscreen.dart';
import 'settingscreen.dart';

class Dashboard extends StatefulWidget {
  int type;
  // static const route = "Dashboard";
  Dashboard() {
//    if (arguments !=  null){
    // this.type = arguments[Constants.tabType];
//    this.type = arguments[Constants.tabType];

//    }
  }

  static const route = "Dashboard";

  @override
  _DashboardState createState() => _DashboardState(); 
}

class _DashboardState extends State<Dashboard> {
  List<BottomNavModel> model;
  int _currentIndex = 0;
  List<Widget> _children;
  GlobalKey keyButton = GlobalKey();
  int bottom_index = 0;
  bool _useWhiteStatusBarForeground;
  bool _useWhiteNavigationBarForeground;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<bool> _onWillPop(BuildContext context) {
    if (!Navigator.of(context).canPop()) {
      return showModalBottomSheet(
        context: context,
        builder: (context) => CustomAlertDialog(
          // message: R.string().commonString.reallyExit,
          actions: [
            DialogAction<bool>(
              dense: false,
              isWhite: true,
              result: false,
              // text: R.string().commonString.no,
            ),
            DialogAction<bool>(
              dense: false,
              isWhite: false,
              result: true,
              // text: R.string().commonString.yes,
            )
          ],
        ),
      ).then((result) => result == true);
    } else {
      return Future.value(true);
    }
  }

  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  @override
  void initState() {
    super.initState();
    model = BottomNavModel.getBottomBar();
    changeStatusColor(darken(
      ColorConstants.colorPrimary,
    ));

    for (var j = 0; j < model.length; j++) {
      if (model[j].type == widget.type) {
        model[j].isSelected = true;
        _currentIndex = j;
      } else {
        model[j].isSelected = false;
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('dashboard context');
          //  _afterLayout;
    });

    _children = [
      HomeScreen(),
      NotificationScreen(),
      // ContactUsScreen(),
      RegisterBusinessScreen(),
      // SettingScreen(),
      // SettingScreen(),
      SettingScreen(),
    ];
//    ColorConstants.introgrey
    // RxBus.register<bool>(tag: Constants.eventBus).listen((event) {
    //   if (!app.resolve<PrefUtils>().isUserLogin()) {
    //     print("jkgrbjhhb");
    //     NavigationUtilities.pushRoute(Login.route, type: RouteType.fade);
    //   } else {
    //     if (_currentIndex != 4) {
    //       setState(() {
    //         for (var j = 0; j < model.length; j++) {
    //           if (model[j].type == 4) {
    //             _currentIndex = j;
    //             model[j].isSelected = true;
    //           } else {
    //             model[j].isSelected = false;
    //           }
    //         }
    //       });
    //     }
    //   }
    // }
    // );
  }

  changeStatusColor(Color color) async {
    try {
      await FlutterStatusbarcolor.setStatusBarColor(color, animate: true);
      if (useWhiteForeground(color)) {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
        _useWhiteStatusBarForeground = true;
        _useWhiteNavigationBarForeground = true;
      } else {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
        _useWhiteStatusBarForeground = false;
        _useWhiteNavigationBarForeground = false;
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  bool useWhiteForeground(Color backgroundColor) =>
      1.05 / (backgroundColor.computeLuminance() + 0.05) > 4.5;
  getProfilePhoto() {
    return Padding(
      padding: EdgeInsets.all(getSize(10)),
      child: Container(
        // alignment: Alignment.center,
        // margin: EdgeInsets.only(top: getSize(30)),
        width: getSize(130),
        height: getSize(130),
        decoration: BoxDecoration(
          color: ColorConstants.backGroundColor,
          image: DecorationImage(
            image: AssetImage(userIcon),
            fit: BoxFit.fitHeight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            new BoxShadow(
              // color: Color(0xff00000033),
              color: Colors.black12,
              offset: Offset(0, 5),
              blurRadius: 15.0,
            ),
          ],
        ),

        // NetworkImage('https://via.placeholder.com/150'),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
//    ThemeSettingsModel.of(context).updateSystemUi(isLogin: false);
    return SafeArea(
      child: WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: AppBackground(
          colors: [Colors.white],
          child: Scaffold(
            resizeToAvoidBottomInset: false,
           endDrawer: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            bottomLeft: Radius.circular(40),
          ),
          child: Drawer(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: getSize(80),
                  ),
                  getProfilePhoto(),
                   SizedBox(
                    height: getSize(20),
                  ),
                  Text("Marcin Kohut",
                  style: appTheme.black22BoldTextStyle.copyWith(fontSize: getFontSize(28))
                  ),
                  Text("marcinkohut26@gmail.com",
                  style: appTheme.black14RegularTextStyle,
                  )
                ],
              ),
            ),
          ),
        ),
            // appBar: AppBar(
            //   toolbarHeight: getSize(100),
            //   elevation: 0,
            //   title: Column(
            //     children: [
            //       Text("app bar"),
            //       Text("app bar"),
            //     ],
            //   ),
            // ),
            body: Container(
              color: Colors.white,
              // color: AppTheme.of(context).accentColor,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: getSize(60)),
                    child: _children[_currentIndex],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: getBoxShadow(context),
                        color: AppTheme.of(context).theme.primaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(getSize(20)),
                            topRight: Radius.circular(getSize(20))),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: getSize(62),
                            margin: EdgeInsets.all(getSize(7)),
                            padding: EdgeInsets.all(getSize(10)),
                            decoration: new BoxDecoration(
                              color: AppTheme.of(context)
                                  .theme
                                  .dividerColor
                                  .withOpacity(0.03),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(getSize(16))),
                            ),
                            child: GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: model.length,
                                padding: EdgeInsets.all(getSize(0)),
                                gridDelegate:
                                    new SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (!app
                                                .resolve<PrefUtils>()
                                                .isUserLogin() &&
                                            (model[index].type == 2 ||
                                                model[index].type == 3)) {
                                          Map<String, dynamic> map =
                                              new HashMap();
                                          // map[Constants.loginFlow] = false;
                                          // NavigationUtilities.pushRoute(
                                          //   Login.route,
                                          //   type: RouteType.fade,
                                          //   args: map,
                                          // );
                                        } else {
                                          for (var i in model) {
                                            i.isSelected = false;

                                            _currentIndex = index;
                                            model[index].isSelected = true;
                                          }
                                        }
                                      });
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(
                                                  bottom: getSize(5),
                                                  top: getSize(8),
                                                ),
                                                child: Image.asset(
                                                    model[index].image,
                                                    height: getSize(20),
                                                    width: getSize(20),
                                                    color: model[index]
                                                            .isSelected
                                                        ? AppTheme.of(context)
                                                            .theme
                                                            .accentColor
                                                        : AppTheme.of(context)
                                                            .theme
                                                            .textTheme
                                                            .body1
                                                            .color),
                                              ),
                                            ]),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                getSize(2.5),
                                              ),
                                            ),
                                            color: (model[index].isSelected)
                                                ? AppTheme.of(context)
                                                    .theme
                                                    .accentColor
                                                : Colors.transparent,
                                          ),
                                          width: getSize(5),
                                          height: getSize(5),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(
                              height:
                                  MathUtilities.safeAreaBottomHeight(context))
                        ],
                      ),
                    ),
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
