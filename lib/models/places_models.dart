// To parse this JSON data, do
//
//     final placesResponce = placesResponceFromMap(jsonString);

import 'dart:convert';

class PlacesResponce {
  PlacesResponce({
    required this.placeId,
    required this.osmId,
    required this.osmType,
    required this.licence,
    required this.lat,
    required this.lon,
    //  required this.boundingbox,
    this.placesResponceClass,
    this.type,
    required this.displayName,
    this.displayPlace,
    this.displayAddress,
    required this.address,
  });

  final String placeId;
  final String osmId;
  final String osmType;
  final String licence;
  final String lat;
  final String lon;
  // final List<String> boundingbox;
  final String? placesResponceClass;
  final String? type;
  final String displayName;
  final String? displayPlace;
  final String? displayAddress;
  final Address address;

  factory PlacesResponce.fromJson(String str) =>
      PlacesResponce.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlacesResponce.fromMap(Map<String, dynamic> json) => PlacesResponce(
        placeId: json["place_id"],
        osmId: json["osm_id"],
        osmType: json["osm_type"],
        licence: json["licence"],
        lat: json["lat"],
        lon: json["lon"],
        // boundingbox: List<String>.from(json["boundingbox"].map((x) => x)),
        placesResponceClass: json["class"],
        type: json["type"],
        displayName: json["display_name"],
        displayPlace: json["display_place"],
        displayAddress: json["display_address"],
        address: Address.fromMap(json["address"]),
      );

  Map<String, dynamic> toMap() => {
        "place_id": placeId,
        "osm_id": osmId,
        "osm_type": osmType,
        "licence": licence,
        "lat": lat,
        "lon": lon,
        // "boundingbox": List<dynamic>.from(boundingbox.map((x) => x)),
        "class": placesResponceClass,
        "type": type,
        "display_name": displayName,
        "display_place": displayPlace,
        "display_address": displayAddress,
        "address": address.toMap(),
      };
}

class Address {
  Address({
    this.name,
    this.state,
    this.country,
    this.countryCode,
    this.county,
    this.postcode,
  });

  final String? name;
  final String? state;
  final String? country;
  final String? countryCode;
  final String? county;
  final String? postcode;

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        name: json["name"],
        state: json["state"],
        country: json["country"],
        countryCode: json["country_code"],
        county: json["county"] == null ? null : json["county"],
        postcode: json["postcode"] == null ? null : json["postcode"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "state": state,
        "country": country,
        "country_code": countryCode,
        "county": county == null ? null : county,
        "postcode": postcode == null ? null : postcode,
      };
}
