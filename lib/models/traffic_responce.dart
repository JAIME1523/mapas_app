// To parse this JSON data, do
//
//     final trafficResponce = trafficResponceFromMap(jsonString);

import 'dart:convert';

class TrafficResponce {
  TrafficResponce({
    required this.code,
    required this.routes,
    required this.waypoints,
  });

  final String code;
  final List<Route> routes;
  final List<Waypoint> waypoints;

  factory TrafficResponce.fromJson(String str) =>
      TrafficResponce.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TrafficResponce.fromMap(Map<String, dynamic> json) => TrafficResponce(
        code: json["code"],
        routes: List<Route>.from(json["routes"].map((x) => Route.fromMap(x))),
        waypoints: List<Waypoint>.from(
            json["waypoints"].map((x) => Waypoint.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "routes": List<dynamic>.from(routes.map((x) => x.toMap())),
        "waypoints": List<dynamic>.from(waypoints.map((x) => x.toMap())),
      };
}

class Route {
  Route({
    required this.geometry,
    required this.legs,
    required this.weightName,
    required this.weight,
    required this.duration,
    required this.distance,
  });

  final String geometry;
  final List<Leg> legs;
  final String weightName;
  final double weight;
  final double duration;
  final double distance;

  factory Route.fromJson(String str) => Route.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Route.fromMap(Map<String, dynamic> json) => Route(
        geometry: json["geometry"],
        legs: List<Leg>.from(json["legs"].map((x) => Leg.fromMap(x))),
        weightName: json["weight_name"],
        weight: json["weight"].toDouble(),
        duration: json["duration"].toDouble(),
        distance: json["distance"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "geometry": geometry,
        "legs": List<dynamic>.from(legs.map((x) => x.toMap())),
        "weight_name": weightName,
        "weight": weight,
        "duration": duration,
        "distance": distance,
      };
}

class Leg {
  Leg({
    required this.steps,
    required this.summary,
    required this.weight,
    required this.duration,
    required this.distance,
  });

  final List<dynamic> steps;
  final String summary;
  final double weight;
  final double duration;
  final double distance;

  factory Leg.fromJson(String str) => Leg.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Leg.fromMap(Map<String, dynamic> json) => Leg(
        steps: List<dynamic>.from(json["steps"].map((x) => x)),
        summary: json["summary"],
        weight: json["weight"].toDouble(),
        duration: json["duration"].toDouble(),
        distance: json["distance"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "steps": List<dynamic>.from(steps.map((x) => x)),
        "summary": summary,
        "weight": weight,
        "duration": duration,
        "distance": distance,
      };
}

class Waypoint {
  Waypoint({
    required this.hint,
    required this.distance,
    required this.name,
    required this.location,
  });

  final String hint;
  final double distance;
  final String name;
  final List<double> location;

  factory Waypoint.fromJson(String str) => Waypoint.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Waypoint.fromMap(Map<String, dynamic> json) => Waypoint(
        hint: json["hint"],
        distance: json["distance"].toDouble(),
        name: json["name"],
        location: List<double>.from(json["location"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toMap() => {
        "hint": hint,
        "distance": distance,
        "name": name,
        "location": List<dynamic>.from(location.map((x) => x)),
      };
}
