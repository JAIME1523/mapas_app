

import 'package:dio/dio.dart';

class PlacesInterceptor extends Interceptor{
final accesToken ='pk.2769150a5b92d668096b7ea65e1dccbd';


 @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'viewbox':'-98.86064949639152,19.51113489408835,-99.13427773114253,19.428917602875405',
      'key': accesToken,
      'accept-language': 'es',
      'limit':5
    });
    super.onRequest(options, handler);
  }

  
}