part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnActivateManualMarkerEvent extends SearchEvent {}

class OnInactiviteMnaulaMarkerEvent extends SearchEvent {}

class OnNewPlacesFoundEvent extends SearchEvent {
  final List<PlacesResponce> places;
  const OnNewPlacesFoundEvent(this.places);
}

class AddToHistoryEvent extends SearchEvent {
  final PlacesResponce place;
  const AddToHistoryEvent(this.place);
}
 


//evento AddTOhISTORYeNVEMT aqui
//FINAL PlacesResponce