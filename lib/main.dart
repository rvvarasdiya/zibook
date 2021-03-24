import 'package:zaviato/app/Helper/LocalizationHelper.dart';
import 'package:zaviato/app/di/app_module.dart';
import 'package:zaviato/components/screens/Home/mainscreen.dart';
import 'package:zaviato/components/screens/WelcomeScreen/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiwi/kiwi.dart';
import 'package:zaviato/app/theme/settings_models_provider.dart';
import 'package:zaviato/components/screens/dashboard/dashboard.dart';
import 'package:zaviato/modules/ThemeSetting.dart';
import 'app/Helper/Themehelper.dart';
import 'app/constant/constants.dart';
import 'app/theme/app_theme.dart';
import 'app/theme/global_models_provider.dart'; 
import 'app/utils/navigator.dart';
import 'app/utils/route_observer.dart';
import 'components/screens/dashboard/homescreen.dart';

KiwiContainer app;

TextDirection deviceTextDirection = TextDirection.ltr;

main() {
  WidgetsFlutterBinding.ensureInitialized();
//  R.changeLocale(English.languageCode);
//  if (kDebugMode) {
//    rootBundle
//        .load('assets/chls.pem')
//        .then((value) => {
//              if (value != null)
//                {
//                  SecurityContext.defaultContext
//                      .setTrustedCertificatesBytes(value.buffer.asUint8List())
//                }
//            })
//        .catchError((object) => {print(object)});
//  }
  app = KiwiContainer();

  setup();

  runApp(
    SettingsModelsProvider(
      child: GlobalModelsProvider(
        child: StreamBuilder<String>(
          stream: ThemeHelper.appthemeString,
          builder: (context, snapshot) {
            return StreamBuilder(
              stream: LocalizationHelper.appLanguage,
              builder: (context, snapshot2) {
                return Base();
                // do some stuff with both streams here
              },
            );
          },
        ),
      ),
    ),
  );
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
}

class Base extends StatefulWidget {
  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> {
  ThemeData themeData;

  @override
  void initState() {
    super.initState();
//    ThemeHelper.changeTheme("light");
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(() {
        themeData = AppTheme.of(context).theme;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    // app.resolve<PrefUtils>().saveDeviceId();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: APPNAME,
      theme: themeData,
      navigatorKey: key,
      onGenerateRoute: onGenerateRoute,
      navigatorObservers: [routeObserver],
      home: Dashboard(),
      //  WelcomeScreen(),
      routes: <String, WidgetBuilder>{
        '/ThemeSetting': (BuildContext context) => ThemeSetting(),
      },
      builder: _builder,
    );
  }

  Widget _builder(BuildContext context, Widget child) {
    return Column(
      children: <Widget>[
        Expanded(child: child),
      ],
    );
  }
}
