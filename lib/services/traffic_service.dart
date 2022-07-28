import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:mapas_app/models/models.dart';
import 'package:mapas_app/services/services.dart';

class TrafficService {
  final Dio _dioTraffic;

  final String _baseTrafficUrl = 'https://us1.locationiq.com/v1/directions';

  TrafficService()
      : _dioTraffic = Dio()
          ..interceptors.add(TrafficInterceptor()); //configurar interseptores

  // Future<TrafficResponce> getCoorsStartToend(LatLng start, end) async {
  Future getCoorsStartToend(LatLng start, end) async {
 
    final coorString =
        '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
    final url = '$_baseTrafficUrl/driving/$coorString';

  

    // final resp = await _dioTraffic.get('https://us1.locationiq.com/v1/directions/driving/-99.0502000290935,19.474310367;-99.12225489215162,19.4835754884550?key=pk.2769150a5b92d668096b7ea65e1dccbd&steps=false&alternatives=false&geometries=polyline6');
    final resp = await _dioTraffic.get(url);

    // print(resp.data['routes'][0]['geometry']);

    final data = TrafficResponce.fromMap(resp.data);

    return data;
  }
}