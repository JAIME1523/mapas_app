import 'package:dio/dio.dart';

const accesToken ='pk.2769150a5b92d668096b7ea65e1dccbd';

class TrafficInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'steps': false,
      'key': accesToken
    });
    super.onRequest(options, handler);
  }
}
