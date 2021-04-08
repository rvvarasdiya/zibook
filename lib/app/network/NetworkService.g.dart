// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NetworkService.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _NetworkService implements NetworkService {
  _NetworkService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'http://13.234.240.252:5700/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  signUpApi(req) async {
    ArgumentError.checkNotNull(req, 'req');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(req?.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'http://13.234.240.252:5700/api/v1/customer/user/register',
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

  @override
  homeScreenApi() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'http://13.234.240.252:5700/api/v1/customer/category/paginate',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = HomeScreenResponse.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  notificationScreenApi() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'http://13.234.240.252:5700/api/v1/customer/category/paginate',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = HomeScreenResponse.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  logInApi(req) async {
    ArgumentError.checkNotNull(req, 'req');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(req ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'http://13.234.240.252:5700/api/v1/common/user/login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = LogInResponseModel.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  forgetPasswordApi(req) async {
    ArgumentError.checkNotNull(req, 'req');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(req ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'http://13.234.240.252:5700/api/v1/auth/forgot-password',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BaseApiResp.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  verifyOTPApi(req) async {
    ArgumentError.checkNotNull(req, 'req');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(req ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'http://13.234.240.252:5700/api/v1/auth/check-reset-password-otp',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BaseApiResp.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  verifyMobileOtpApi(req) async {
    ArgumentError.checkNotNull(req, 'req');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(req ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'http://13.234.240.252:5700/api/v1/customer/user/verify-mobile',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BaseApiResp.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  sendOTPApi(req) async {
    ArgumentError.checkNotNull(req, 'req');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(req ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'http://13.234.240.252:5700/api/v1/customer/user/mobile-verification-otp',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BaseApiResp.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  resetPasswordApi(req) async {
    ArgumentError.checkNotNull(req, 'req');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(req ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'http://13.234.240.252:5700/api/v1/auth/reset-password',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BaseApiResp.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getMaster(req) async {
    ArgumentError.checkNotNull(req, 'req');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(req ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'http://13.234.240.252:5700/api/v1/customer/user/sync',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MasterResp.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  contactUs(req) async {
    ArgumentError.checkNotNull(req, 'req');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(req?.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'http://13.234.240.252:5700/api/v1/common/user/contact-us',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ContactUsRes.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  registerBusiness(req) async {
    ArgumentError.checkNotNull(req, 'req');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(req?.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'http://13.234.240.252:5700/api/v1/customer/business/add',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BaseApiResp.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getMyBusinesses() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'http://13.234.240.252:5700/api/v1/customer/business/paginate-my-businesses',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MyBusinessRes.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getBusinessListByCategory(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'http://13.234.240.252:5700/api/v1/customer/business/paginate-by-category/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MyBusinessByCategoryRes.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getAllCity(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'http://13.234.240.252:5700/api/v1/customer/common/cities-by-state/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Cities.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  logout() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'http://13.234.240.252:5700/api/v1/common/user/logout',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BaseApiResp.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getFaqs() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'http://13.234.240.252:5700/api/v1/customer/faqs/paginate',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = FaqsResp.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getFavoriteList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'http://13.234.240.252:5700/api/v1/customer/business/list-favourites',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MyBusinessByCategoryRes.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  addToFovourite(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'http://13.234.240.252:5700/api/v1/customer/business/make-favourite/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AddFavoriteRes.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  removeBusiness(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'http://13.234.240.252:5700/api/v1/customer/business/remove/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BaseApiResp.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  updteBusiness(req) async {
    ArgumentError.checkNotNull(req, 'req');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(req?.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'http://13.234.240.252:5700/api/v1/customer/business/update',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BaseApiResp.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  ChangePassword(req) async {
    ArgumentError.checkNotNull(req, 'req');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(req?.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'http://13.234.240.252:5700/api/v1/auth/change-password',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BaseApiResp.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  addReviewRating(req) async {
    ArgumentError.checkNotNull(req, 'req');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(req ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'http://13.234.240.252:5700/api/v1/customer/rating-review/add',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BaseApiResp.fromJson(_result.data);
    return Future.value(value);
  }
}
