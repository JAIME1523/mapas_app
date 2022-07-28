import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/blocs/blocs.dart';
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
        (event, emit) => emit(state.copyWith(polylines: event.polylines)));
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
    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['route'] = myRoute;
    add(DisplayPolylinesEvent(currentPolylines));
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
