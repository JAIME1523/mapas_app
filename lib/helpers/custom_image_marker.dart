import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

late BitmapDescriptor iconmarker;
getAssetImageMarker() async {
  late BitmapDescriptor iconmarker;

  // var a =  BitmapDescriptor.fromAssetImage(const ImageConfiguration(
  //   devicePixelRatio:  2.5,

  // ), 'assets/custom-pin');

  // return a;
  await getBytesFromAsset().then((value) {
    iconmarker = BitmapDescriptor.fromBytes(value);
  });

  return iconmarker;
}

Future<Uint8List> getBytesFromAsset() async {
  ByteData data = await rootBundle.load('assets/custom-pin.png');
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: 120);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

getNetworkIMageMarker() async {
  final responce = await Dio().get(
      'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/map-marker-512.png',
      options: Options(responseType: ResponseType.bytes));
  // return BitmapDescriptor.fromBytes(responce.data);

  //resize de la imagen cambiar de tañamo una imagen de un url

  final imageCode = await ui.instantiateImageCodec(responce.data,
      targetWidth: 150, targetHeight: 150);
  final frame = await imageCode.getNextFrame();
  final data = await frame.image.toByteData(format: ui.ImageByteFormat.png);
  if (data == null) {
    return await getAssetImageMarker();
  }
  return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
}
