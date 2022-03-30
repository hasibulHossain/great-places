import 'dart:convert';

Place placeFromJson(String str) => Place.fromJson(json.decode(str));

Place placeFromMap(Map<String, dynamic> place) => Place.fromMap(place);

String placeToJson(Place data) => json.encode(data.toJson());

class Place {
  Place({
    required this.id,
    required this.title,
    required this.image,
    this.location,
  });

  final String id;
  final String title;
  final String image;
  final Location? location;

  // Convert json to Place class
  factory Place.fromJson(Map<String, dynamic> json) => Place(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    location: Location.fromJson(json["location"]),
  );

  // convert Map to Place class.
  factory Place.fromMap(Map<String, dynamic> place) => Place(
    id: place["id"],
    title: place["title"],
    image: place["image"],
  );

  // Convert Place class to json
  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "location": location?.toJson(),
  };

  // Convert Place class to Map
  static Map<String, dynamic> toMap({required String id, required String title, required String image}) {
    return {
      'id': id,
      'title': title,
      'image': image,
    };
  }


}

class Location {
  Location({
    required this.latitude,
    required this.longitude,
    this.address,
  });

  final double latitude;
  final int longitude;
  final String? address;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
    "address": address,
  };
}
