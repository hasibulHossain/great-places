import 'dart:io';
import 'package:flutter/material.dart';
import '../../models/place.dart';
import '../../helpers/db_helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  void savePlace(String title, String image) {
    final newPlace = Place(id: DateTime.now().toString(), title: title, location: null, image: image);
    _places.add(newPlace);
    
    notifyListeners();
    DBHelper.insert(DBHelper.placesTable, Place.toMap(id: newPlace.id, title: newPlace.title, image: newPlace.image));
  }

  Future<void> fetchAndSetPlace() async {
    final fetchedPlace = await DBHelper.getData(DBHelper.placesTable);
    _places = fetchedPlace.map((place) => Place.fromMap(place)).toList();

    notifyListeners();
  }
}