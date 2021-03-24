import 'package:zaviato/app/base/BaseApiResp.dart';
import 'package:zaviato/app/constant/ApiConstants.dart';
import 'package:zaviato/app/constant/constants.dart';
import 'package:retrofit/retrofit.dart';
import 'package:zaviato/models/Auth/LogInResponseModel.dart';
import 'package:zaviato/models/Auth/SignUpModel.dart';
import 'package:zaviato/models/Auth/SignUpResponseModel.dart';
import 'package:zaviato/models/Home/HomeScreenResponse.dart';
import 'package:zaviato/models/Master/MasterResponse.dart';
import '../app.export.dart';
part 'NetworkService.g.dart';

@RestApi(baseUrl: baseURL)
abstract class NetworkService {
  factory NetworkService(Dio dio) = _NetworkService;

  @POST(ApiConstants.register)
  Future<SignUpResponseModel> signUpApi(@Body() SignUpModel req);

  @POST(ApiConstants.homeScreenApi)
  Future<HomeScreenResponse> homeScreenApi();

  @POST(ApiConstants.logInApi)
  Future<LogInResponseModel> logInApi(@Body() Map<String, dynamic> req);

  @POST(ApiConstants.forgetPassword)
  Future<BaseApiResp> forgetPasswordApi(@Body() Map<String, dynamic> req);

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
}
