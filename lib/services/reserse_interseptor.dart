

import 'package:dio/dio.dart';

class ReverseInterseptor extends Interceptor{
final accesToken ='pk.2769150a5b92d668096b7ea65e1dccbd';


 @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'key': accesToken,
      'accept-language': 'es',
      'format': 'json'
    });
    super.onRequest(options, handler);
  }

  
}