import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/blocs/blocs.dart';
import 'package:mapas_app/screens/screens.dart';

void main() {
  runApp(MultiBlocProvider(
      providers: [BlocProvider(create: (_) => GpsBloc())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Maps App',
        home: LoadingScreen());
  }
}
