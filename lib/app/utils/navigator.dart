import 'package:zaviato/app/utils/BottomToUpTransit.dart';
import 'package:zaviato/app/utils/ScaleInOutAnimation.dart';
import 'package:zaviato/app/utils/SlideTransit.dart';
import 'package:flutter/material.dart';
import 'package:zaviato/components/screens/Auth/CreatePasswordScreen.dart';
import 'package:zaviato/components/screens/Auth/ForgetPasswordScreen.dart';
import 'package:zaviato/components/screens/Auth/OtpVerifyScreen.dart';
import 'package:zaviato/components/screens/Auth/SignInScreen.dart';
import 'package:zaviato/components/screens/Auth/SignUpScreen.dart';
import 'package:zaviato/components/screens/Business/BusinessDetail.dart';
import 'package:zaviato/components/screens/Business/BusinessEdit.dart';
import 'package:zaviato/components/screens/Business/BusinessFullDetail.dart';
import 'package:zaviato/components/screens/Business/BusinessView.dart';
import 'package:zaviato/components/screens/Business/HelpScreen.dart';
import 'package:zaviato/components/screens/Business/businessDetail1.dart';
import 'package:zaviato/components/screens/WelcomeScreen/WelcomeScreen.dart';
import 'package:zaviato/components/screens/editDetail/editprofile.dart';
import 'package:zaviato/components/screens/editDetail/favoritescreen.dart';
import 'fade_route.dart';

/// The [RouteType] determines what [PageRoute] is used for the new route.
/// This determines the transition animation for the new route.
enum RouteType {
  defaultRoute,
  fade,
  slideIn,
  InOut,
  bottomUp,
}

/// A convenience class to wrap [Navigator] functionality.
///
/// Since a [GlobalKey] is used for the [Navigator], the [BuildContext] is not
/// necessary when changing the current route.
///
final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

//GLOBAL KEY TO DECLARE TO CONTEXT CLASS//

class NavigationUtilities {
  // static GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  /// A convenience method to push a new [MaterialPageRoute] to the [Navigator].
  static void push(Widget widget, {String name}) {
    key.currentState.push(MaterialPageRoute(
      builder: (context) => widget,
      settings: RouteSettings(name: name),
    ));
  }

  /// A convenience method to push a new [route] to the [Navigator].
  static Future<dynamic> pushRoute(String route,
      {RouteType type = RouteType.slideIn, Map args}) async {
    if (args == null) {
      args = Map<String, dynamic>();
    }
    args["routeType"] = type;
    return await key.currentState.pushNamed(
      route,
      arguments: args,
    );
  }

  /// A convenience method to push a named replacement route.
  static Future<dynamic> pushReplacementNamed(String route,
      {RouteType type = RouteType.slideIn, Map args}) {
    if (args == null) {
      args = Map<String, dynamic>();
    }
    args["routeType"] = type;
    key.currentState.pushReplacementNamed(
      route,
      arguments: args,
    );
  }

  /// Returns a [RoutePredicate] similar to [ModalRoute.withName] except it
  /// compares a list of route names.
  ///
  /// Can be used in combination with [Navigator.pushNamedAndRemoveUntil] to
  /// pop until a route has one of the name in [names].
  static RoutePredicate namePredicate(List<String> names) {
    return (route) =>
        !route.willHandlePopInternally &&
        route is ModalRoute &&
        (names.contains(route.settings.name));
  }
}

/// [onGenerateRoute] is called whenever a new named route is being pushed to
/// the app.
///
/// The [RouteSettings.arguments] that can be passed along the named route
/// needs to be a `Map<String, dynamic>` and can be used to pass along
/// arguments for the screen.
Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final routeName = settings.name;
  final arguments = settings.arguments as Map<String, dynamic> ?? {};
  final routeType =
      arguments["routeType"] as RouteType ?? RouteType.defaultRoute;

  Widget screen;

  switch (routeName) {
    case WelcomeScreen.route:
      screen = WelcomeScreen();
      break;
    case OtpVerifyScreen.route:
      screen = OtpVerifyScreen(arguments: arguments,);
      break;
    case CreatePasswordScreen.route:
      screen = CreatePasswordScreen(arguments: arguments,);
      break;

    case SignInScreen.route:
      screen = SignInScreen();
      break;
    case SignUpScreen.route:
      screen = SignUpScreen();
      break;
    case ForgetPasswordScreen.route:
      screen = ForgetPasswordScreen();
      break;
    case BusinessDetailScreen.route:
      screen = BusinessDetailScreen();
      break;
    // case BusinessDetail1.route:
    //   screen = BusinessDetail1();
    //   break;
    case BusinessFullDetail.route:
      screen = BusinessFullDetail();
      break;
    case HelpScreen.route:
      screen = HelpScreen();
      break;
    case BusinessView.route:
      screen = BusinessView();
      break;
    case BusinessEdit.route:
      screen = BusinessEdit();
      break;
    case EditProfileScreen.route:
      screen = EditProfileScreen();
      break;
    case FavoriteScreen.route:
      screen = FavoriteScreen();
      break;
  }

  switch (routeType) {
    case RouteType.fade:
      return FadeRoute(
        builder: (_) => screen,
        settings: RouteSettings(name: routeName),
      );
    case RouteType.slideIn:
      return SlideTransit(
        enterPage: screen,
      );
    case RouteType.InOut:
      return ScaleRoute(
        page: screen,
      );
    case RouteType.bottomUp:
      return BottomToUpTransit(
        page: screen,
      );

    case RouteType.defaultRoute:
    default:
      return MaterialPageRoute(
        builder: (_) => screen,
        settings: RouteSettings(name: routeName),
      );
  }
}
