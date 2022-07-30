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

    on<OnNewPlacesFoundEvent>(
      (event, emit) => emit(state.copyWith(places: event.places)),
    );
    //Todo el ultimo element al incio
    //on addToHIstory
    on<AddToHistoryEvent>((event, emit) =>
        emit(state.copyWith(history: [event.place, ...state.history])));
  }

  Future<RouteDestination> getCoorsStartToend(LatLng start, end) async {
    final trafficResponce = await trafficService.getCoorsStartToend(start, end);

    final geometry = trafficResponce.routes[0].geometry;

    final distance = trafficResponce.routes[0].distance;
    final duracion = trafficResponce.routes[0].duration;

    //decodificar
    final point = decodePolyline(geometry, accuracyExponent: 6);

    final latLngList = point
        .map((coor) => LatLng(coor[0].toDouble(), coor[1].toDouble()))
        .toList();

    return RouteDestination(
        distance: distance, duration: duracion, points: latLngList);
  }

  Future getPlaceByQuery(String query) async {
    if (query.isEmpty || query == '') {
      final List<PlacesResponce> newPlaces = [];
      add(OnNewPlacesFoundEvent(newPlaces));
      return;
    }
    final newPlaces = await trafficService.getReseultByQuery(query);

    //todo por aqui tenemos almacer el state
    add(OnNewPlacesFoundEvent(newPlaces));
  }

  void _onaddToHIstory(AddToHistoryEvent event, Emitter<SearchState> emit) {
    List<PlacesResponce> lista = state.history;
    lista.add(event.place);
    emit(state.copyWith(history: lista));
    // emit(state.copyWith(followingUser: true));
    // if (locationBloc.state.lasKnownLocation == null) return;
    // moveCamera(locationBloc.state.lasKnownLocation!);
  }
}
