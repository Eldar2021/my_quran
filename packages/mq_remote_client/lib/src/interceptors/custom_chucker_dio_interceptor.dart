import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';

class CustomChuckerDioInterceptor extends ChuckerDioInterceptor {
  @override
  Future<void> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    if (response.requestOptions.responseType == ResponseType.stream) {
      return handler.next(response);
    }
    return super.onResponse(response, handler);
  }
}
