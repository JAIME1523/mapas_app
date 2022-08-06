import 'dart:ui' as ui;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/marker/end_marker.dart';
import 'package:mapas_app/marker/start_marker.dart';

Future<BitmapDescriptor> getStartCustomMaerkwe(
    int minutes, String destination) async {
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);

  const size = ui.Size(350, 150);

  final startMarker =
      StarkMarkerPaint(destination: destination, minutes: minutes);
  startMarker.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}

Future<BitmapDescriptor> getendCustomMarker(
    int kilometers, String destination) async {
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);

  const size = ui.Size(350, 150);

  final startMarker =
      EndMarkerPaint(destination: destination, kilometers: kilometers);
  startMarker.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}
