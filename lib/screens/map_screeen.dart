import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:mapas_app/blocs/blocs.dart';
import 'package:mapas_app/views/views.dart';
import 'package:mapas_app/widgets/widgets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    // location.getCurrentPosition();
    locationBloc.stratFollowingUser();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    locationBloc.stopFollowingUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          return locationState.lasKnownLocation == null
              ? const Center(child: Text('Espere por favor...'))
              : BlocBuilder<MapBloc, MapState>(
                  builder: (context, mapState) {
                    Map<String, Polyline> polylines =
                        Map.from(mapState.polylines);

                    if (!mapState.showMyRoute) {
                      polylines.removeWhere((key, value) => key == 'myRoute');
                    }

                    return SingleChildScrollView(
                      child: Stack(
                        children: [
                          MapView(
                            initialLocation: locationState.lasKnownLocation!,
                            //values toSet para convertir el valor en un set
                            polylines: polylines.values.toSet(),
                          ),

                          // TODO: botones...
                          const SearchBar(),
                         const ManualMarker(),

                          // Center(child:Text('${state.lasKnownLocation!}') ,)
                        ],
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          BtnFollowUser(),
          BtnCurrentLocation(),
          BtnToogleUSerRoute()
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
