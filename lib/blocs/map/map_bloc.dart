import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/blocs/blocs.dart';
import 'package:mapas_app/helpers/helpers.dart';
import 'package:mapas_app/models/models.dart';
import 'package:mapas_app/themes/uber.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;
  StreamSubscription<LocationState>? locationStateSubscription;

  LatLng? mapCenter;
  GoogleMapController? _mapController;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapInitializedEvent>(_onInitMap);

    locationStateSubscription = locationBloc.stream.listen((locationSate) {
      if (locationSate.lasKnownLocation != null) {
        add(UpdateUserPolylineEvent(locationSate.myLocationHistory));
      }
      if (!state.isfollowingUser) return;
      if (locationSate.lasKnownLocation == null) return;
      moveCamera(locationSate.lasKnownLocation!);
    });

    on<OnStopFollowingUseEvent>(_onStopFollowingUsers);
    on<OnStartFollowingUserEvent>(_onStartFollowingUsers);
    on<UpdateUserPolylineEvent>(_updatePolylineNewPoint);
    on<OnToggleUserRouteEvent>(
      (event, emit) => emit(state.copyWith(showMyRoute: !state.showMyRoute)),
    );
    on<DisplayPolylinesEvent>(
      (event, emit) => emit(
          state.copyWith(polylines: event.polylines, markers: event.markers)),
    );
  }

  void _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;
    _mapController?.setMapStyle(jsonEncode(uberMapTheme));
    emit(state.copyWith(isMapInitialized: true));
  }

  Future drawRotatePolyline(RouteDestination destination) async {
    final myRoute = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.black,
      points: destination.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      width: 5,
    );

    double kms = destination.distance / 1000;
    kms = (kms * 100).floorToDouble();

    kms /= 100;

    double tripDuartion = (destination.duration / 60).floorToDouble();

    //custom markers 

    // final startMarker2 = await getAssetImageMarker();
    // final endMarker2 = await getNetworkIMageMarker();

    final iconStartcustom = await getStartCustomMaerkwe(tripDuartion.toInt(), 'Mi Ubicacion');
    final iconEndCustom = await getendCustomMarker(kms.toInt(), destination.endPlace.displayName);


    //inicializar un marcador
    final startMarker = Marker(
      anchor: const Offset(0.1, 1),
        markerId: const MarkerId('start'),
        position: destination.points.first,
        icon: iconStartcustom ,
        infoWindow: InfoWindow(
          title: 'Inicio',
          snippet: 'Kms: $kms, duration: $tripDuartion',
        ));
    final endMarker = Marker(
      icon: iconEndCustom,
        markerId: const MarkerId('end'),
        position: destination.points.last,
        infoWindow: InfoWindow(
          title: destination.endPlace.displayName,
          snippet: destination.endPlace.address.name,
        ));

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    final currentMarkers = Map<String, Marker>.from(state.markers);

    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;

    currentPolylines['route'] = myRoute;
    add(DisplayPolylinesEvent(currentPolylines, currentMarkers));

    await Future.delayed(const Duration(milliseconds: 300));
    _mapController?.showMarkerInfoWindow(const MarkerId('start'));
  }

  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }

  void _onStopFollowingUsers(
      OnStopFollowingUseEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(followingUser: false));
  }

  void _onStartFollowingUsers(
      OnStartFollowingUserEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(followingUser: true));
    if (locationBloc.state.lasKnownLocation == null) return;
    moveCamera(locationBloc.state.lasKnownLocation!);
  }

  void _updatePolylineNewPoint(
      UpdateUserPolylineEvent event, Emitter<MapState> emit) {
    final myRoute = Polyline(
        polylineId: const PolylineId('myRoute'),
        color: Colors.black,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: event.userLocations);
    //Se crea una copia de las polylines que son constantes
    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    //se mimite un nuevo estado con la copia de las lineas
    currentPolylines['myRoute'] = myRoute;
    emit(state.copyWith(polylines: currentPolylines));
  }

  @override
  Future<void> close() {
    // TODO: implement close
    locationStateSubscription?.cancel();
    return super.close();
  }
}
