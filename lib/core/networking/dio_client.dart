import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class DioClient extends DioForNative {
  final String _baseUrl;
  String? token;

  void setToken(String token) {
    this.token = token;
  }

  DioClient({required baseUrl}) : _baseUrl = baseUrl {
    options = BaseOptions(
      baseUrl: _baseUrl,
      responseType: ResponseType.json,
    );

    interceptors.add(
      InterceptorsWrapper(
          onRequest: (options, handler) {},
          onResponse: (response, handler) {},
          onError: (exception, handler) {}),
    );

    interceptors.add(LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        error: true));
  }
}
