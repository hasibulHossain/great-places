import 'dart:io';
import 'package:flutter/material.dart';
import '../../models/place.dart';

class GreatPlaces with ChangeNotifier {
  final List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  void savePlace(String title, File image) {
    final newPlace = Place(id: DateTime.now().toString(), title: title, location: null, image: image);
    _places.add(newPlace);
    
    notifyListeners();
  }
}