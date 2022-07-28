part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitializedEvent extends MapEvent {
  final GoogleMapController controller;
  const OnMapInitializedEvent(this.controller);
}


class OnStopFollowingUseEvent extends MapEvent {
  const OnStopFollowingUseEvent();

}

class OnStartFollowingUserEvent extends MapEvent {
  const OnStartFollowingUserEvent();
  
}

class UpdateUserPolylineEvent extends MapEvent {
  final List<LatLng> userLocations;
  const UpdateUserPolylineEvent(this.userLocations);

}

class OnToggleUserRouteEvent extends MapEvent {
  const OnToggleUserRouteEvent();
  
}

class DisplayPolylinesEvent extends MapEvent{
  final Map<String,Polyline>  polylines;

  const DisplayPolylinesEvent(this.polylines);
}