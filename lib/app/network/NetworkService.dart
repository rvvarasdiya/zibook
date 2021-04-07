import 'package:zaviato/app/base/BaseApiResp.dart';
import 'package:zaviato/app/constant/ApiConstants.dart';
import 'package:zaviato/app/constant/constants.dart';
import 'package:retrofit/retrofit.dart';
import 'package:zaviato/components/screens/dashboard/SettingScreen/changePasswordScreen.dart';
import 'package:zaviato/models/Auth/ChangePasswordModel.dart';
import 'package:zaviato/models/Auth/LogInResponseModel.dart';
import 'package:zaviato/models/Auth/LogoutModel.dart';
import 'package:zaviato/models/Auth/SignUpModel.dart';
import 'package:zaviato/models/Auth/SignUpResponseModel.dart';
import 'package:zaviato/models/ContactUs/contactUsModel.dart';
import 'package:zaviato/models/FaqsModel.dart';
import 'package:zaviato/models/Favorite/Favorite.dart';
import 'package:zaviato/models/Home/HomeScreenResponse.dart';
import 'package:zaviato/models/Master/MasterResponse.dart';
import 'package:zaviato/models/RegisterBusiness/RegisterBusiness.dart';
import 'package:zaviato/models/cities/citiesModel.dart';
import 'package:zaviato/models/mybusiness/MyBusinessByCategoryRes.dart';
import 'package:zaviato/models/mybusiness/MyBusinessRes.dart';
import 'package:zaviato/models/mybusiness/UpdateBusiness.dart';
import '../app.export.dart';
part 'NetworkService.g.dart';

@RestApi(baseUrl: baseURL)
abstract class NetworkService {
  factory NetworkService(Dio dio) = _NetworkService;

  @POST(ApiConstants.register)
  Future<SignUpResponseModel> signUpApi(@Body() SignUpModel req);

  @POST(ApiConstants.homeScreenApi)
  Future<HomeScreenResponse> homeScreenApi();

  @POST(ApiConstants.homeScreenApi)
  Future<HomeScreenResponse> notificationScreenApi();

  @POST(ApiConstants.logInApi)
  Future<LogInResponseModel> logInApi(@Body() Map<String, dynamic> req);

  @POST(ApiConstants.forgetPassword)
  Future<BaseApiResp>   forgetPasswordApi(@Body() Map<String, dynamic> req);

  @POST(ApiConstants.verifyResetOtp)
  Future<BaseApiResp> verifyOTPApi(@Body() Map<String, dynamic> req);

  @POST(ApiConstants.verifyOtp)
  Future<BaseApiResp> verifyMobileOtpApi(@Body() Map<String, dynamic> req);

  @POST(ApiConstants.sendOTP)
  Future<BaseApiResp> sendOTPApi(@Body() Map<String, dynamic> req);

  @POST(ApiConstants.resetPasswordApi)
  Future<BaseApiResp> resetPasswordApi(@Body() Map<String, dynamic> req);

  @POST(ApiConstants.masterSync)
  Future<MasterResp> getMaster(@Body() Map<String, dynamic> req);

  @POST(ApiConstants.contactUsApi)
  Future<ContactUsRes> contactUs(@Body() ContactUsReq req);

  @POST(ApiConstants.registerBusinessApi)
  Future<BaseApiResp> registerBusiness(@Body() RegisterBusinessReq req);

  @POST(ApiConstants.mybusiness)
  Future<MyBusinessRes> getMyBusinesses();

  @POST(ApiConstants.businessViewByCategory)
  Future<MyBusinessByCategoryRes> getBusinessListByCategory(
      @Path("id") String id);

  @POST(ApiConstants.getCityApi)
  Future<Cities> getAllCity(@Path("id") String id);

  @POST(ApiConstants.logoutApi)
  Future<BaseApiResp> logout();

  @POST(ApiConstants.getFaqsApi)
  Future<FaqsResp> getFaqs();
  @POST(ApiConstants.getFavoriteListApi)
  Future<MyBusinessByCategoryRes> getFavoriteList();

  @POST(ApiConstants.addToFavoriteApi)
  Future<AddFavoriteRes> addToFovourite(@Path("id") String id);

  @POST(ApiConstants.deleteBusinessApi)
  Future<BaseApiResp> removeBusiness(@Path("id") String id);

  @POST(ApiConstants.updateBusinessApi)
  Future<BaseApiResp> updteBusiness(@Body() UpdateBusinessReq req);

  @POST(ApiConstants.changepasswordApi) 
  Future<BaseApiResp> ChangePassword(@Body() ChangePassReq req);

  @POST(ApiConstants.addreviewRatingApi)
  Future<BaseApiResp> addReviewRating(@Body() Map<String, dynamic> req);

}
