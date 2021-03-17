import 'package:zaviato/app/constant/constants.dart';

import '../app.export.dart';

class ApiConstants {
  static const String PROXY_URL = "PROXY 192.168.0.206:8888";

  static const String commonUrl = apiUrl + "api/v1/";
  static const String customerCommonUrl = commonUrl + "customer";

  static const String imageBaseURL = baseURL;
  static const String apiUrl = baseURL;

  static const String documentUpload = "/api/v1/upload-file";

  static const String masterSync = customerCommonUrl + "/user/sync";

  static const String login = customerCommonUrl + "/user/login";

  static const String register = customerCommonUrl + "/user/register";

  static const String sendOtpForVerification =
      customerCommonUrl + "/user/mobile-verification-otp";

  static const String verifyOtp = customerCommonUrl + "/user/verify-mobile";

  static const String verifyResetOtp = customerCommonUrl + "/auth/check-reset-password-otp";


  static const String resetPassword =
      customerCommonUrl + "/auth/reset-password";

  static const String changePassword =
      customerCommonUrl + "/auth/change-password";

  static const String logout = customerCommonUrl + "/user/logout";

  static const String propertyAdd = customerCommonUrl + "/property/add";


  static const String checkResetOtp =
      customerCommonUrl + "/auth/check-reset-password-otp";

  static const String contactUs = customerCommonUrl + "/contact-us/paginate";

  static const String forgetPassword =
      customerCommonUrl + "/auth/forgot-password";
}
