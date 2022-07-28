import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/blocs/blocs.dart';
import 'package:mapas_app/helpers/helpers.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, state) {
        return state.displayManualMarker
            ? const _ManualMarkerBody()
            : const SizedBox();

        // if (state.displayManualMarker) {
        //   return const _ManualMarkerBody();
        // }
        // return const SizedBox();
      },
    );
  }
}

class _ManualMarkerBody extends StatelessWidget {
  const _ManualMarkerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationhBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return SizedBox(
        child: SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          const Positioned(top: 70, left: 20, child: _BtnBack()),
          Center(
            child: Transform.translate(
              offset: const Offset(0, -22),
              child: BounceInDown(
                  from: 120,
                  child: const Icon(
                    Icons.location_on_rounded,
                    size: 60,
                  )),
            ),
          ),

          //Boton de confirmar

          Positioned(
            bottom: 70,
            left: 40,
            child: FadeInUp(
              duration: const Duration(milliseconds: 300),
              child: MaterialButton(
                minWidth: size.width - 120,
                onPressed: () async {
                  final start = locationhBloc.state.lasKnownLocation;

                  if (start == null) return;
                  final end = mapBloc.mapCenter;
                  if (end == null) return;

                  //Confirmar ubicacion
                  ShowLoadingMessage(context);

                  final destination =
                      await searchBloc.getCoorsStartToend(start, end);
                  mapBloc.drawRotatePolyline(destination);

                  searchBloc.add(OnInactiviteMnaulaMarkerEvent());
                  Navigator.pop(context);
                },
                color: Colors.black,
                elevation: 0,
                height: 50,
                shape: const StadiumBorder(),
                child: const Text(
                  'Confirmar destino',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w300),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

class _BtnBack extends StatelessWidget {
  const _BtnBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);

    return FadeInLeft(
      duration: const Duration(milliseconds: 300),
      child: CircleAvatar(
        maxRadius: 30,
        backgroundColor: Colors.white,
        child: IconButton(
            onPressed: () {
              searchBloc.add(OnInactiviteMnaulaMarkerEvent());
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
      ),
    );
  }
}
