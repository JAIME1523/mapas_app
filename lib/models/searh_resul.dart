import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class SearchResut {
  final bool cancel;
  final bool manual;
  final LatLng? position;
  final String? name;
  final String? description;

  SearchResut({required this.cancel, this.manual = false, this.position, this.name, this.description});

  //Hacer modificaciones nombre,description,latLong
  @override
  String toString() {
    // TODO: implement toString
    return 'cancel: ${cancel}, manual: ${manual}';
  }

}
