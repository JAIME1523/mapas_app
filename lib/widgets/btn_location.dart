import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/blocs/blocs.dart';
import 'package:mapas_app/ui/ui.dart';

class BtnCurrentLocation extends StatelessWidget {
  const BtnCurrentLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 24,
        child: IconButton(
            onPressed: () {
              final userLocation = locationBloc.state.lasKnownLocation;

              if (userLocation == null) {
                final snack = CustomSnackbar(message: 'No hay ubicacion ');
                ScaffoldMessenger.of(context).showSnackBar(snack);
                return;
              }
              //snackbar;

              mapBloc.moveCamera(userLocation);
            },
            icon: const Icon(
              Icons.my_location_outlined,
            ),
            color: Colors.black),
      ),
    );
  }
}
