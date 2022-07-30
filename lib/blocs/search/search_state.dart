part of 'search_bloc.dart';

class SearchState extends Equatable {
  final bool displayManualMarker;
  final List<PlacesResponce> places;
  final List<PlacesResponce> history;

  //History

  const SearchState(
      {this.displayManualMarker = false,
      this.places = const [],
      this.history = const []});

  SearchState copyWith(
          {bool? displayManualMarker,
          List<PlacesResponce>? places,
          List<PlacesResponce>? history}) =>
      SearchState(
          displayManualMarker: displayManualMarker ?? this.displayManualMarker,
          places: places ?? this.places,
          history: history ?? this.history);

  @override
  List<Object> get props => [displayManualMarker, places, history];
}
