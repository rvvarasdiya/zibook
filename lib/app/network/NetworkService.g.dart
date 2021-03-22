// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NetworkService.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _NetworkService implements NetworkService {
  _NetworkService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://secret-citadel-73539.herokuapp.com';
  }

  final Dio _dio;

  String baseUrl;

  @override
  login(req) async {
    ArgumentError.checkNotNull(req, 'req');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(req?.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'https://secret-citadel-73539.herokuapp.comapi/v1/customer/user/register',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SignUpResponseModel.fromJson(_result.data);
    return Future.value(value);
  }
}
