import 'dart:collection';



import 'package:zaviato/app/utils/navigator.dart';
import 'package:zaviato/components/screens/Auth/SignInScreen.dart';
import 'package:zaviato/components/screens/dashboard/dashboard.dart';
import 'package:zaviato/components/screens/dashboard/homescreen.dart';

import '../app.export.dart';

// AppConfiguration Constant string
const CONFIG_LOGIN = "LOGIN";
const CONFIG_MOBILE_VERIFICATION = "MOBILE_VERIFICATION";
const CONFIG_BANK_DETAIL = "BANK_DETAIL";
const CONFIG_DOC_VERIFICATION = "DOC_VERIFICATION";

class AppNavigation {
  static final AppNavigation shared = AppNavigation();

  // Configuration _configuration;

  Future<void> init() async {
    // code
    // _configuration = AppConfiguration.shared.configuration;
  }

// Move To Home Scree
  void movetoHome({bool isPopAndSwitch = false}) {
    if (isPopAndSwitch) {
      NavigationUtilities.pushReplacementNamed(Dashboard.route,
          type: RouteType.fade);
      // NavigationUtilities.pushReplacementNamed(DiamondListScreen.route,
      // type: RouteType.fade);
    } else {
      NavigationUtilities.pushRoute(Dashboard.route, type: RouteType.fade);
    }
  }

  void movetoLogin({bool isPopAndSwitch = false}) {
    if (isPopAndSwitch) {
      NavigationUtilities.pushReplacementNamed(SignInScreen.route);
    } else {
      NavigationUtilities.pushRoute(SignInScreen.route);
    }
  }
}
