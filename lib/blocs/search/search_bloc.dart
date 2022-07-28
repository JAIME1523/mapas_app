import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';

import 'package:mapas_app/blocs/blocs.dart';
import 'package:mapas_app/models/models.dart';
import 'package:mapas_app/services/services.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  TrafficService trafficService;

  SearchBloc({required this.trafficService}) : super(const SearchState()) {
    on<OnActivateManualMarkerEvent>(
        (event, emit) => emit(state.copyWith(displayManualMarker: true)));
    on<OnInactiviteMnaulaMarkerEvent>(
        (event, emit) => emit(state.copyWith(displayManualMarker: false)));
  }

  Future<RouteDestination> getCoorsStartToend(LatLng start, end) async {
    final trafficResponce = await trafficService.getCoorsStartToend(start, end);

    final geometry = trafficResponce.routes[0].geometry;

    final distance = trafficResponce.routes[0].distance;
    final duracion = trafficResponce.routes[0].duration;

    //decodificar
    final point = decodePolyline(geometry, accuracyExponent: 6);
    
    final latLngList = point.map((coor)=> LatLng(coor[0].toDouble(), coor[1].toDouble())).toList();

    return RouteDestination(
        distance: distance, duration: duracion, points: latLngList );
  }
}
