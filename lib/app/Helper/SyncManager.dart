import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info/package_info.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zaviato/app/base/BaseApiResp.dart';
import 'package:zaviato/app/base/ErrorResp.dart';
import 'package:zaviato/app/network/NetworkCall.dart';
import 'package:zaviato/app/network/ServiceModule.dart';
import 'package:zaviato/app/utils/CustomDialog.dart';
import 'package:zaviato/app/utils/pref_utils.dart';
import 'package:zaviato/models/Master/MasterResponse.dart';

import '../../main.dart';

class SyncManager {
  static final SyncManager _instance = SyncManager._internal();

  SyncManager._internal();

  static SyncManager get instance {
    return _instance;
  }

  factory SyncManager() {
    return _instance;
  }

  Future callMasterSync(
    BuildContext context,
    Function success,
    Function failure, {
    bool isNetworkError = true,
    bool isProgress = true,
    String id,
  }) async {
    Map<String,dynamic> req = {};
    // req["lastSyncDate"] = app.resolve<PrefUtils>().getMasterSyncDate();
    req["lastSyncDate"] ="1970-01-01T00:00:00+00:00";
    
    print(req["lastSyncDate"]);


    NetworkCall<MasterResp>()
        .makeCall(
            () => app.resolve<ServiceModule>().networkService().getMaster(req),
            context,
            isProgress: isProgress,
            isNetworkError: isNetworkError)
        .then((masterResp) async {
      // save Logged In user
      // if (masterResp.data.loggedInUser != null) {
      //   app.resolve<PrefUtils>().saveUser(masterResp.data.loggedInUser);
      // }

      // if (masterResp.data.permission != null) {
      //   await app.resolve<PrefUtils>().saveUserPermission(
      //         masterResp.data.permission,
      //       );
      // }

      //Append static data masters
      // List<Master> arrLocalData = await Config().getLocalDataJson();
      // masterResp.data.masters.list.addAll(arrLocalData);

      // await AppDatabase.instance.masterDao
      //     .addOrUpdate(masterResp.data.masters.list);

      // await AppDatabase.instance.masterDao
      //     .delete(masterResp.data.masters.deleted);

      // await AppDatabase.instance.sizeMasterDao
      //     .addOrUpdate(masterResp.data.sizeMaster.list);

      // await AppDatabase.instance.sizeMasterDao
      //     .delete(masterResp.data.sizeMaster.deleted);

      // save master sync date
      app.resolve<PrefUtils>().saveMasterSyncDate(masterResp.data.lastSyncDate);

      // success block
      success();
      // callHandler()
    }).catchError((onError) => {
              failure(),
              if (isNetworkError)
                {
                  showToast((onError is ErrorResp)
                      ? onError.message
                      : onError.toString()),
                },
            });
  }


  // Future callApiForBlock(
  //   BuildContext context,
  //   TrackDataReq req,
  //   Function(TrackBlockResp) success,
  //   Function(ErrorResp) failure, {
  //   bool isProgress = false,
  // }) async {
  //   NetworkCall<TrackBlockResp>()
  //       .makeCall(
  //     () => app.resolve<ServiceModule>().networkService().diamondBlockList(req),
  //     context,
  //     isProgress: isProgress,
  //   )
  //       .then((resp) async {
  //     success(resp);
  //   }).catchError((onError) => {if (onError is ErrorResp) failure(onError)});
  // }

  // void callVersionUpdateApi(BuildContext context, String screenConstant,
  //     {String id}) {
  //   NetworkCall<VersionUpdateResp>()
  //       .makeCall(
  //           () => app
  //               .resolve<ServiceModule>()
  //               .networkService()
  //               .getVersionUpdate(),
  //           context,
  //           isProgress: true)
  //       .then(
  //     (resp) {
  //       if (resp.data != null) {
  //         PackageInfo.fromPlatform().then(
  //           (PackageInfo packageInfo) {
  //             String appName = packageInfo.appName;
  //             String packageName = packageInfo.packageName;
  //             String version = packageInfo.version;
  //             String buildNumber = packageInfo.buildNumber;
  //             if (Platform.isIOS) {
  //               print("iOS");
  //               if (resp.data.ios != null) {
  //                 num respVersion = resp.data.ios.number;

  //                 if (num.parse(version) < respVersion) {
  //                   bool hardUpdate = resp.data.ios.isHardUpdate;
  //                   Map<String, dynamic> dict = new HashMap();
  //                   dict["isHardUpdate"] = hardUpdate;
  //                   dict["oncomplete"] = () {
  //                     if (screenConstant == VersionUpdateApi.logIn) {
  //                       SyncManager.instance.callMasterSync(
  //                           NavigationUtilities.key.currentContext, () async {
  //                         //success
  //                         AppNavigation.shared.movetoHome(isPopAndSwitch: true);
  //                       }, () {},
  //                           isNetworkError: false,
  //                           isProgress: true,
  //                           id: id).then((value) {});
  //                     }

  //                     //for splash
  //                     if (screenConstant == VersionUpdateApi.splash) {
  //                       AppNavigation.shared.movetoHome(isPopAndSwitch: true);
  //                     }

  //                     //signinasguest and signinwithmpin
  //                     if (screenConstant == VersionUpdateApi.signInAsGuest ||
  //                         screenConstant == VersionUpdateApi.signInWithMpin)
  //                       Navigator.pop(context);
  //                   };
  //                   if (hardUpdate == true) {
  //                     if (screenConstant == VersionUpdateApi.logIn ||
  //                         screenConstant == VersionUpdateApi.splash) {
  //                       app.resolve<PrefUtils>().saveSkipUpdate(false);
  //                       NavigationUtilities.pushReplacementNamed(
  //                           VersionUpdate.route,
  //                           args: dict);
  //                     }

  //                     //for signinwithmpin / signinwithguest
  //                     if (screenConstant == VersionUpdateApi.signInAsGuest ||
  //                         screenConstant == VersionUpdateApi.signInWithMpin) {
  //                       NavigationUtilities.pushReplacementNamed(
  //                         VersionUpdate.route,
  //                         args: dict,
  //                       );
  //                     }
  //                   } else {
  //                     if (app.resolve<PrefUtils>().getSkipUpdate() == false) {
  //                       NavigationUtilities.pushReplacementNamed(
  //                           VersionUpdate.route,
  //                           args: dict);
  //                     } else {
  //                       //for login
  //                       if (screenConstant == VersionUpdateApi.logIn) {
  //                         SyncManager.instance.callMasterSync(
  //                             NavigationUtilities.key.currentContext, () async {
  //                           //success
  //                           AppNavigation.shared
  //                               .movetoHome(isPopAndSwitch: true);
  //                         }, () {},
  //                             isNetworkError: false,
  //                             isProgress: true,
  //                             id: id).then((value) {});
  //                       }

  //                       //for spalsh
  //                       if (screenConstant == VersionUpdateApi.splash)
  //                         AppNavigation.shared.movetoHome(isPopAndSwitch: true);
  //                     }
  //                   }
  //                 } else {
  //                   //for login / signinasguest / signinwithmpin
  //                   if (screenConstant == VersionUpdateApi.logIn ||
  //                       screenConstant == VersionUpdateApi.signInAsGuest ||
  //                       screenConstant == VersionUpdateApi.signInWithMpin) {
  //                     SyncManager.instance.callMasterSync(
  //                         NavigationUtilities.key.currentContext, () async {
  //                       //success
  //                       AppNavigation.shared.movetoHome(isPopAndSwitch: true);
  //                     }, () {},
  //                         isNetworkError: false,
  //                         isProgress: true,
  //                         id: id).then((value) {});
  //                   }

  //                   //for splash
  //                   if (screenConstant == VersionUpdateApi.splash)
  //                     AppNavigation.shared.movetoHome(isPopAndSwitch: true);
  //                 }
  //               } else {
  //                 //for signinwithmpin / signwithguest
  //                 if (screenConstant == VersionUpdateApi.logIn ||
  //                     screenConstant == VersionUpdateApi.signInWithMpin ||
  //                     screenConstant == VersionUpdateApi.signInAsGuest) {
  //                   SyncManager.instance.callMasterSync(
  //                       NavigationUtilities.key.currentContext, () async {
  //                     //success
  //                     AppNavigation.shared.movetoHome(isPopAndSwitch: true);
  //                   }, () {},
  //                       isNetworkError: false,
  //                       isProgress: true,
  //                       id: id).then((value) {});
  //                 }

  //                 //for splash
  //                 if (screenConstant == VersionUpdateApi.splash)
  //                   AppNavigation.shared.movetoHome(isPopAndSwitch: true);
  //               }
  //             } else {
  //               print("Android");
  //               if (resp.data.android != null) {
  //                 num respVersion = resp.data.android.number;
  //                 if (num.parse(buildNumber) < respVersion) {
  //                   bool hardUpdate = resp.data.android.isHardUpdate;
  //                   Map<String, dynamic> dict = new HashMap();
  //                   dict["isHardUpdate"] = hardUpdate;
  //                   dict["oncomplete"] = () {
  //                     //only for login
  //                     if (screenConstant == VersionUpdateApi.logIn) {
  //                       SyncManager.instance.callMasterSync(
  //                           NavigationUtilities.key.currentContext, () async {
  //                         //success
  //                         AppNavigation.shared.movetoHome(isPopAndSwitch: true);
  //                       }, () {},
  //                           isNetworkError: false,
  //                           isProgress: true,
  //                           id: id).then((value) {});
  //                     }

  //                     //for splash
  //                     if (screenConstant == VersionUpdateApi.splash)
  //                       AppNavigation.shared.movetoHome(isPopAndSwitch: true);
  //                   };
  //                   if (hardUpdate == true) {
  //                     if (screenConstant == VersionUpdateApi.signInAsGuest ||
  //                         screenConstant == VersionUpdateApi.signInWithMpin) {
  //                       NavigationUtilities.pushReplacementNamed(
  //                         VersionUpdate.route,
  //                       );
  //                     } else {
  //                       app.resolve<PrefUtils>().saveSkipUpdate(false);
  //                       NavigationUtilities.pushReplacementNamed(
  //                           VersionUpdate.route,
  //                           args: dict);
  //                     }
  //                   } else {
  //                     if (app.resolve<PrefUtils>().getSkipUpdate() == false) {
  //                       NavigationUtilities.pushReplacementNamed(
  //                           VersionUpdate.route,
  //                           args: dict);
  //                     } else {
  //                       if (screenConstant == VersionUpdateApi.logIn) {
  //                         SyncManager.instance.callMasterSync(
  //                             NavigationUtilities.key.currentContext, () async {
  //                           //success
  //                           AppNavigation.shared
  //                               .movetoHome(isPopAndSwitch: true);
  //                         }, () {},
  //                             isNetworkError: false,
  //                             isProgress: true,
  //                             id: id).then((value) {});
  //                       }

  //                       //for splash
  //                       if (screenConstant == VersionUpdateApi.splash) {
  //                         AppNavigation.shared.movetoHome(isPopAndSwitch: true);
  //                       }
  //                     }
  //                   }

  //                   // //signinasguest / signinwithmpin
  //                   // bool hardUpdate = resp.data.android.isHardUpdate;
  //                   // if (hardUpdate == true) {

  //                   // }
  //                 } else {
  //                   //for signinguest and login and signinwithmpin

  //                   if (screenConstant == VersionUpdateApi.logIn ||
  //                       screenConstant == VersionUpdateApi.signInWithMpin ||
  //                       screenConstant == VersionUpdateApi.signInAsGuest) {
  //                     SyncManager.instance.callMasterSync(
  //                         NavigationUtilities.key.currentContext, () async {
  //                       //success
  //                       AppNavigation.shared.movetoHome(isPopAndSwitch: true);
  //                     }, () {},
  //                         isNetworkError: false,
  //                         isProgress: true,
  //                         id: id).then((value) {});
  //                   }

  //                   //for splash
  //                   if (screenConstant == VersionUpdateApi.splash)
  //                     AppNavigation.shared.movetoHome(isPopAndSwitch: true);
  //                 }
  //               } else {
  //                 //for signinwithmpin / signinwithguest
  //                 if (screenConstant == VersionUpdateApi.signInWithMpin ||
  //                     screenConstant == VersionUpdateApi.signInAsGuest) {
  //                   SyncManager.instance.callMasterSync(
  //                       NavigationUtilities.key.currentContext, () async {
  //                     //success
  //                     AppNavigation.shared.movetoHome(isPopAndSwitch: true);
  //                   }, () {},
  //                       isNetworkError: false,
  //                       isProgress: true,
  //                       id: id).then((value) {});
  //                 }

  //                 //for splash
  //                 if (screenConstant == VersionUpdateApi.splash)
  //                   AppNavigation.shared.movetoHome(isPopAndSwitch: true);
  //               }
  //             }
  //           },
  //         );
  //       }
  //     },
  //   ).catchError(
  //     (onError) => {
  //       app.resolve<CustomDialogs>().confirmDialog(context,
  //           title: R.string().errorString.versionError,
  //           desc: onError.message,
  //           positiveBtnTitle: R.string().commonString.btnTryAgain,
  //           onClickCallback: (PositveButtonClick) {
  //         if (screenConstant == VersionUpdateApi.splash) {
  //           //for splash
  //           callVersionUpdateApi(context, screenConstant);
  //         } else {
  //           callVersionUpdateApi(context, screenConstant, id: id);
  //         }
  //       }),
  //     },
  //   );
  // }

}
