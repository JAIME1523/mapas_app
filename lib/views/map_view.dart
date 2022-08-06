import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/blocs/blocs.dart';

class MapView extends StatelessWidget {
  final LatLng initialLocation;
  final Set<Polyline> polylines;
  final Set<Marker> markers;
  const MapView(
      {Key? key,
      required this.initialLocation,
      required this.polylines,
      required this.markers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapBLoc = BlocProvider.of<MapBloc>(context);

    late CameraPosition initialCameraPosition =
        CameraPosition(target: initialLocation, zoom: 15);
    final size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width,
        height: size.height,
        child: Listener(
          onPointerMove: (poiterMove) {
            mapBLoc.add(const OnStopFollowingUseEvent());
          },
          child: GoogleMap(
            initialCameraPosition: initialCameraPosition,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            polylines: polylines,
            onMapCreated: ((controller) =>
                mapBLoc.add(OnMapInitializedEvent(controller))),
            onCameraMove: (position) {
              mapBLoc.mapCenter = position.target;
            },
            markers: markers,
          ),
        ));
  }
}
