import 'package:zaviato/app/constant/constants.dart';

import '../app.export.dart';

class ApiConstants {
  static const String PROXY_URL = "PROXY 192.168.1.14:8888";

  static const String   commonUrl = apiUrl + "api/v1/";
  static const String customerCommonUrl = commonUrl + "customer";

  static const String imageBaseURL = baseURL;
  static const String apiUrl = baseURL;

  static const String   documentUpload = commonUrl + "common/file/file-upload";

  static const String masterSync = customerCommonUrl + "/user/sync";

  static const String login = customerCommonUrl + "/user/login";

  static const String register = customerCommonUrl + "/user/register";

  static const String sendOtpForVerification =
      customerCommonUrl + "/user/mobile-verification-otp";

  static const String verifyOtp = customerCommonUrl + "/user/verify-mobile";

  static const String verifyResetOtp = commonUrl + "auth/check-reset-password-otp";


  static const String resetPassword =
      customerCommonUrl + "/auth/reset-password";

  static const String changePassword =
      customerCommonUrl + "/auth/change-password";

  static const String logout = customerCommonUrl + "/user/logout";

  static const String propertyAdd = customerCommonUrl + "/property/add";


  static const String checkResetOtp =
      customerCommonUrl + "/auth/check-reset-password-otp";

  static const String contactUs = customerCommonUrl + "/contact-us/paginate";

  static const String   forgetPassword =
      commonUrl + "auth/forgot-password";

  //HomeScreen
  static const String homeScreenApi = customerCommonUrl + "/category/paginate";

  //login
  static const String logInApi = commonUrl + "common/user/login";

  //send otp
  static const String sendOTP = customerCommonUrl + "/user/mobile-verification-otp";
  
  //reset-password
  static const String resetPasswordApi = commonUrl + "auth/reset-password";

  //contactus
  static const StricontactUsApi = commonUrl + "common/user/contact-us";

  //register business
  static const String registerBusinessApi = customerCommonUrl + "/business/add";

  //register business
  static const String mybusiness = customerCommonUrl + "/business/paginate-my-businesses/";

  //List of businesses by category
  static const String businessViewByCategory = customerCommonUrl + "/business/paginate-by-category/{id}";

  //contact us
  static const String contactUsApi = commonUrl + "common/user/contact-us";

  //Update business
  static const String updateBusinessApi = customerCommonUrl + "/business/update/{id}";
    
  //city
  static const String getCityApi = customerCommonUrl + "/common/cities-by-state/{id}";
  
  //logout
  static const String logoutApi = commonUrl + "common/user/logout";
  
  //delete business
  static const String deleteBusinessApi = customerCommonUrl + "/business/remove/{id}";

}
