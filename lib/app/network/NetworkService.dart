import 'package:zaviato/app/constant/ApiConstants.dart';
import 'package:zaviato/app/constant/constants.dart';
import 'package:retrofit/retrofit.dart';
import 'package:zaviato/models/Auth/SignUpModel.dart';
import 'package:zaviato/models/Auth/SignUpResponseModel.dart';
import '../app.export.dart';
part 'NetworkService.g.dart';

@RestApi(baseUrl: baseURL)
abstract class NetworkService {
  factory NetworkService(Dio dio) = _NetworkService;

  @POST(ApiConstants.register)
  Future<SignUpResponseModel> login(@Body() SignUpModel req);
}
