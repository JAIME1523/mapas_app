import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  StreamSubscription? gpsServiceSubcription;

  GpsBloc()
      : super(const GpsState(
            isGpsPermissionGranted: false, isGpsEnabled: false)) {
    on<GpsAndPermissionEvent>((event, emit) => emit(state.copyWith(
        isGpsEnabled: event.isGpsEnabled,
        isGpsPermissionGranted: event.isGpsPermissionGranted)));
    _init();
  }

  Future<void> _init() async {
    final isEnable = await _checkGpsStatus();
    final isGranted = await _isPermissionGranted();
//ejecuar las funciones en una sola linea de manera simultanea
    final gpsInirStatus = await Future.wait([
      _checkGpsStatus(),
      _isPermissionGranted(),
    ]);
    //actualiza el estado de laplicacion con este evento
    //el add es solo si esta dentro del mismo bloc
    //se pone la posicion de el future que corresponde
    add(GpsAndPermissionEvent(
      isGpsEnabled: gpsInirStatus[0],
      isGpsPermissionGranted: gpsInirStatus[1],
    ));
  }

  Future<bool> _checkGpsStatus() async {
    final isEnable = await Geolocator.isLocationServiceEnabled();

    Geolocator.getServiceStatusStream().listen((event) {
      final isEnable = (event.index == 1) ? true : false;
      //actualiza el estado de laplicacion con este evento
      add(GpsAndPermissionEvent(
        isGpsEnabled: isEnable,
        isGpsPermissionGranted: state.isGpsPermissionGranted,
      ));
    });
    return isEnable;
  }

//verificar los permisos
  Future<bool> _isPermissionGranted() async {
    final isGranted = await Permission.location.isGranted;
    return isGranted;
  }

//preguntar sobre los permisos para agregar
  Future<void> askGpsAccess() async {
    final status = await Permission.location.request();
    switch (status) {
      case PermissionStatus.granted:
        add(GpsAndPermissionEvent(
            isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: true));
        break;

      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        add(GpsAndPermissionEvent(
            isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: false));
        //abre la ventana de operaciones
        openAppSettings();
        break;
    }
  }

  @override
  Future<void> close() {
    gpsServiceSubcription?.cancel();
    return super.close();
  }
}
