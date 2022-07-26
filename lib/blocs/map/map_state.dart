part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool isfollowingUser;
  final bool showMyRoute;
  //polilines

  final Map<String, Polyline> polylines;
  /*
  'mi_reuta: {
    id:polelineId Google,
    points[ [lat,lng], [123,123]],
    width:2,
    color: black
  }
   */

  const MapState(
      {this.isMapInitialized = false,
      this.isfollowingUser = true,
      this.showMyRoute = true,
      Map<String, Polyline>? polylines})
      : polylines = polylines ?? const {};

  MapState copyWith(
          {bool? isMapInitialized,
          bool? followingUser,
          bool? showMyRoute,
          Map<String, Polyline>? polylines}) =>
      MapState(
        showMyRoute: showMyRoute ?? this.showMyRoute,
        isMapInitialized: isMapInitialized ?? this.isMapInitialized,
        isfollowingUser: followingUser ?? isfollowingUser,
        polylines: polylines ?? this.polylines,
      );

  @override
  List<Object> get props => [isMapInitialized, isfollowingUser, polylines, showMyRoute];
}
