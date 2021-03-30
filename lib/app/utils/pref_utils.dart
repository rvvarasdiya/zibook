import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zaviato/app/base/BaseApiResp.dart';
import 'package:zaviato/app/base/ErrorResp.dart';
import 'package:zaviato/app/localization/app_locales.dart';
import 'package:zaviato/app/network/NetworkCall.dart';
import 'package:zaviato/app/network/NetworkCall.dart';
import 'package:zaviato/app/network/NetworkCall.dart';
import 'package:zaviato/app/network/ServiceModule.dart';
import 'package:zaviato/app/utils/string_utils.dart';
import 'package:zaviato/components/screens/Auth/SignInScreen.dart';
import 'package:zaviato/main.dart';
import 'package:zaviato/models/Auth/LogInResponseModel.dart';
import 'package:zaviato/models/Auth/LogoutModel.dart';
import 'package:zaviato/models/Master/MasterResponse.dart';

import 'BaseDialog.dart';
import 'CustomDialog.dart';

/// Wraps the [SharedPreferences].
class PrefUtils {
  static final Logger _log = Logger("Prefs");

  SharedPreferences preferences;

  double screenSizeWidth;

  /// The [prefix] is used in keys for user specific preferences. You can use unique user-id for multi_user
  String get prefix => "my_app";

  String get keyIsShowThemeSelection => "keyIsShowThemeSelection";

  String get keySelectedThemeId => "keySelectedThemeId";

  String get keyIsUserLogin => "keyIsUserLogin";

  String get keyUser => "keyUser";

  String get keyMaster => "keyMaster";

  String get keyToken => "keyToken";

  String get keyMasterSyncDate => "keyMasterSyncDate";

  String get keyUserPermission => "keyUserPermission";

  Future<void> init() async {
    preferences ??= await SharedPreferences.getInstance();
  }

  /// Gets the int value for the [key] if it exists.
  int getInt(String key, {int defaultValue = 0}) {
    try {
      init();
      return preferences.getInt(key) ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  /// Gets the bool value for the [key] if it exists.
  bool getBool(String key, {bool defaultValue = false}) {
    try {
      init();
      return preferences.getBool(key) ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  /// Gets the String value for the [key] if it exists.
  String getString(String key, {String defaultValue}) {
    try {
      init();
      return preferences.getString(key) ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  /// Gets the string list for the [key] or an empty list if it doesn't exist.
  List<String> getStringList(String key) {
    try {
      init();
      return preferences.getStringList(key) ?? <String>[];
    } catch (e) {
      return <String>[];
    }
  }

  /// Gets the int value for the [key] if it exists.
  void saveInt(String key, int value) {
    init();
    preferences.setInt(key, value);
  }

  /// Gets the int value for the [key] if it exists.
  void saveBoolean(String key, bool value) {
    init();
    preferences.setBool(key, value);
  }

  /// Gets the int value for the [key] if it exists.
  void saveString(String key, String value) {
    init();
    preferences.setString(key, value);
  }

  /// Gets the string list for the [key] or an empty list if it doesn't exist.
  void saveStringList(String key, List<String> value) {
    init();
    preferences.setStringList(key, value);
  }

  void saveShowThemeSelection(bool showThemeSelection) {
    preferences.setBool(keyIsShowThemeSelection, showThemeSelection);
  }

  // User Getter setter
  Future<void> saveUser(User user) async {
    await preferences.setBool(keyIsUserLogin, true);
    preferences.setString(keyUser, json.encode(user));
  }

  User getUserDetails() {
    var userJson = json.decode(preferences.getString(keyUser));
    return userJson != null ? new User.fromJson(userJson) : null;
  }

    // master Getter setter
  Future<void> saveMaster(MasterResp masterResp) async {
    await preferences.setBool(keyIsUserLogin, true);
    preferences.setString(keyMaster, json.encode(masterResp));
  }

  MasterResp getMaster() {
    var masterJson = json.decode(preferences.getString(keyMaster));
    return masterJson != null ? new MasterResp.fromJson(masterJson) : null;
  }

  Future<void> saveUserToken(String token) async {
    await preferences.setString(keyToken, token);
  }

  bool isUserLogin() {
    return !isNullEmptyOrFalse(getUserToken());
  }

  String getUserToken() {
    String str = getString(keyToken);
    if (!isNullEmptyOrFalse(str)) {
      String token = getString(keyToken);
      return token;
    } else {
      return null;
    }
  }

  String getMasterSyncDate() {
    if (isStringEmpty(getString(keyMasterSyncDate)) == false) {
      return getString(keyMasterSyncDate);
    } else {
      return "1970-01-01T00:00:00+00:00";
    }
  }

  void saveMasterSyncDate(String masterSyncDate) {
    preferences.setString(keyMasterSyncDate, masterSyncDate);
  }

  // Future<void> saveUserPermission(UserPermissions user) async {
  //   _preferences.setString(keyUserPermission, json.encode(user));
  // }

  // UserPermissions getUserPermission() {
  //   var userPermissionsJson =
  //       json.decode(_preferences.getString(keyUserPermission));
  //   return userPermissionsJson != null
  //       ? new UserPermissions.fromJson(userPermissionsJson)
  //       : null;
  // }

  //   Future<void> saveUserPermission(UserPermissions user) async {
  //   preferences.setString(keyUserPermission, json.encode(user));
  // }

  // UserPermissions getUserPermission() {
  //   var userPermissionsJson =
  //       json.decode(_preferences.getString(keyUserPermission));
  //   return userPermissionsJson != null
  //       ? new UserPermissions.fromJson(userPermissionsJson)
  //       : null;
  // }.
    Future<void> clearPreferenceAndDB() async {
    preferences.clear();
    // await AppDatabase.instance.masterDao.deleteAllMasterItems();
    // await AppDatabase.instance.sizeMasterDao.deleteAllMasterItems();
  }
    resetAndLogout(BuildContext context) {
    // bool rememberMe = app.resolve<PrefUtils>().getBool("rememberMe");
    // String userName = app.resolve<PrefUtils>().getString("userName");
    // String passWord = app.resolve<PrefUtils>().getString("passWord");

    app.resolve<PrefUtils>().clearPreferenceAndDB();

    // if (rememberMe) {
    //   app.resolve<PrefUtils>().saveBoolean("rememberMe", rememberMe);
    //   app.resolve<PrefUtils>().saveString("userName", userName);
    //   app.resolve<PrefUtils>().saveString("passWord", passWord);
    // }

    Navigator.of(context).pushNamed(SignInScreen.route);
  }
  //   Future deleteAllMasterItems() async {
  //   await masterStore.delete(await db);
  // }
}


logoutFromApp(BuildContext context) {
  app.resolve<CustomDialogs>().confirmDialog(context,
      title: R.string().commonString.lbllogout,
      desc: R.string().authStrings.logoutConfirmationMsg,
      positiveBtnTitle: R.string().commonString.yes,
      negativeBtnTitle: R.string().commonString.no,
      onClickCallback: (buttonType) {
    if (buttonType == ButtonType.PositveButtonClick) {
      callLogout(context);
    }
  });
}

callLogout(BuildContext context) {
  // LogoutReq req = LogoutReq();
  //  List<String> emails = [];
  //   for(var i in app.resolve<PrefUtils>().getUserDetails().emails){
  //     emails.add(i.email);
  //   }
  //   if(!isNullEmptyOrFalse(emails))
  //     req.username = emails.first;
  
  // req.password = app.resolve<PrefUtils>().getUserDetails().
  // req.username = app.resolve<PrefUtils>().getUserDetails().
  NetworkCall<BaseApiResp>()
      .makeCall(
          () => app.resolve<ServiceModule>().networkService().logout(), 
          context,
          isProgress: true)
      .then((response) {
    app.resolve<PrefUtils>().resetAndLogout(context);
  }).catchError((onError) {
    if (onError is ErrorResp) {
      app.resolve<PrefUtils>().resetAndLogout(context);
    }
  });
}

