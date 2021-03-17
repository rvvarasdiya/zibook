import 'package:zaviato/app/theme/theme_settings_model.dart';
import 'package:zaviato/app/utils/connectivity_service.dart';
import 'package:zaviato/app/utils/flushbar_service.dart';
import 'package:zaviato/app/utils/pref_utils.dart';
import 'package:kiwi/kiwi.dart';
import 'package:zaviato/app/network/NetworkCall.dart';
import 'package:zaviato/app/network/ServiceModule.dart';
import 'package:zaviato/app/utils/CustomDialog.dart';
import '../app.export.dart';
part "app_module.g.dart";

abstract class AppModule {
  @Register.singleton(ConnectivityService)
  @Register.singleton(PrefUtils)
  @Register.singleton(FlushbarService)
  @Register.singleton(ThemeSettingsModel)
  @Register.singleton(ServiceModule)
  @Register.singleton(CustomDialogs)
  void configure();
}

void setup() {
  var appModule = _$AppModule();
  appModule.configure();
}
