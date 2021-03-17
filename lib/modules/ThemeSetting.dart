import 'dart:async';

import 'package:zaviato/app/Helper/Themehelper.dart';
import 'package:zaviato/app/constant/constants.dart';
import 'package:zaviato/app/utils/math_utils.dart';
import 'package:zaviato/app/utils/pref_utils.dart';
import 'package:zaviato/components/widgets/shared/animations.dart';
import 'package:zaviato/components/widgets/shared/app_background.dart';
import 'package:zaviato/components/widgets/shared/buttons.dart';
import 'package:zaviato/components/widgets/shared/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zaviato/app/app.export.dart';
import 'package:zaviato/app/localization/app_locales.dart';
import 'package:zaviato/components/widgets/BaseStateFulWidget.dart';

import '../main.dart';

/// The [ThemeSetting] is shown when a user logged into the app for the first
/// time.
class ThemeSetting extends StatefulScreenWidget {
  static const route = "setup";
  StreamSubscription subscription;

  @override
  _ThemeSettingState createState() => _ThemeSettingState();
}

class _ThemeSettingState extends StatefulScreenWidgetState {
  final GlobalKey<SlideAnimationState> _slideSetupKey =
      GlobalKey<SlideAnimationState>();

  Widget _buildSetupScreen() {
    final mediaQuery = MediaQuery.of(context);

    return SlideAnimation(
      key: _slideSetupKey,
      duration: const Duration(milliseconds: 600),
      endPosition: Offset(0, -mediaQuery.size.height),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            _buildText(),
            const SizedBox(height: 16),
            _buildUserName(),
            const SizedBox(height: 16),
            _buildBottom(),
          ],
        ),
      ),
    );
  }

  Widget _buildText() {
    return Expanded(
      flex: 2,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          R.string().themeStrings.welcome,
          style: TextStyle(color: appTheme.textColor),
        ),
      ),
    );
  }

  Widget _buildUserName() {
    //final loginModel = LoginModel.of(context);
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FractionallySizedBox(
          widthFactor: 2 / 3,
          child: FittedBox(
            child: PrimaryDisplayText(
              APPNAME,
              style: Theme.of(context).textTheme.display3,
              delay: const Duration(milliseconds: 800),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottom() {
    return Expanded(
      flex: 4,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 8),
          SecondaryDisplayText(
            R.string().themeStrings.selectYourTheme,
            textAlign: TextAlign.center,
            delay: Duration(milliseconds: 3000),
          ),
          SizedBox(
            height: getSize(16),
          ),
          Spacer(),
          BounceInAnimation(
            delay: const Duration(milliseconds: 4000),
            child: AppButton.flat(
              text: R.string().commonString.btnContinue,
              borderRadius: getSize(14),
              onTap: () {
                ThemeHelper.changeTheme("light");
                // Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Future<void> _navigateToHome() async {
    await _slideSetupKey.currentState.forward();
    app.resolve<PrefUtils>().saveShowThemeSelection(true);
    // AppNavigation.shared.goNextFromSplash(isFromThemeSelection: true);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AppBackground(
        child: _buildSetupScreen(),
      ),
    );
  }
}
