// import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/material.dart';
import 'package:zaviato/app/Helper/SyncManager.dart';
import 'package:zaviato/app/utils/navigator.dart';
import 'package:zaviato/app/utils/pref_utils.dart';
// import 'package:page_transition/page_transition.dart';
import 'package:zaviato/components/screens/WelcomeScreen/WelcomeScreen.dart';
import 'package:zaviato/components/screens/dashboard/dashboard.dart';
import 'package:zaviato/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   Widget openNextScreen()  {
    if (app.resolve<PrefUtils>().isUserLogin()) {
      print(app.resolve<PrefUtils>().isUserLogin());
      return Dashboard();
      // NavigationUtilities.pushRoute(Dashboard.route);
//        NavigationUtilities.pushRoute(CompanyInformation.route);
//      NavigationUtilities.pushRoute(Notifications.route);
      // callVersionUpdateApi();
      // SyncManager().callVersionUpdateApi(context, VersionUpdateApi.splash,
      //     id: app.resolve<PrefUtils>().getUserDetails().id ?? "");
//      AppNavigation.shared.movetoHome(isPopAndSwitch: true);
      //  NavigationUtilities.pushRoute(ForgetPasswordScreen.route);
//      AppNavigation().movetoHome(isPopAndSwitch: true);
    } else {
      // AppNavigation.shared.movetoLogin(isPopAndSwitch: true);
     return WelcomeScreen();
    }
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedSplash(
              imagePath: 'assets/common/demo.jpg',
              home: (app.resolve<PrefUtils>().isUserLogin()) ? Dashboard() : WelcomeScreen(),
              duration: 2500,
              type: AnimatedSplashType.StaticDuration,
            );
  }
}
