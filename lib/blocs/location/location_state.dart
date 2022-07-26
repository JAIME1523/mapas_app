part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool followingUser;
  final LatLng? lasKnownLocation;
  final List<LatLng> myLocationHistory;
  //ultima geolocalizacion
  //historial

  const LocationState(
      {this.followingUser = false, this.lasKnownLocation, myLocationHistory})
      : myLocationHistory = myLocationHistory ?? const [];

//crear el copi with
  LocationState copyWith({
    bool? followingUser,
    LatLng? lasKnownLocation,
    List<LatLng>? myLocationHistory,
  }) =>
      LocationState(
        followingUser     : followingUser ?? this.followingUser,
        lasKnownLocation  : lasKnownLocation ?? this.lasKnownLocation,
        myLocationHistory : myLocationHistory ?? this.myLocationHistory,
      );

  //se agrega el followingUser para saber el estado
  @override
  List<Object?> get props =>
      [followingUser, lasKnownLocation, myLocationHistory];
}

// class LocationInitial extends LocationState {}
