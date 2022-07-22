import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/blocs/blocs.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: BlocBuilder<GpsBloc, GpsState>(
        builder: (BuildContext context, state) {
          return !state.isGpsEnabled
              ? const _EnableGpsMessage()
              : const _AccesButton();
        },
      )
          // _AccesButton(),
          ),
    );
  }
}

class _AccesButton extends StatelessWidget {
  const _AccesButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Es nesesario el acceso al GPS'),
        MaterialButton(
            onPressed: () {
              //madar a llamar el provider del bloc
              final gpsBloc = BlocProvider.of<GpsBloc>(context);
              // final gpsBloc = context.read<GpsBloc>();
              gpsBloc.askGpsAccess();


            },
            color: Colors.black,
            shape: const StadiumBorder(),
            elevation: 0,
            splashColor: Colors.transparent,
            child: const Text('Solicitar Acceso',
                style: TextStyle(color: Colors.white)))
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'debe habilitar el GPS',
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
      ),
    );
  }
}
