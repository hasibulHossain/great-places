// Core

// Flutter Sdks
import 'package:flutter/material.dart';

// Packages
import 'package:provider/provider.dart';

// Providers
import '../../providers/places/places.dart';

// Screens
import '../add_place/add_place_screen.dart';

// Widgets

class PlaceList extends StatelessWidget {
  const PlaceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final places = context.watch<GreatPlaces>().places;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => AddPlace()));
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: places.isEmpty
            ? Center(
                child: Text(
                  'No Places Listed. and places length is ${places.length}',
                ),
              )
            : ListView.builder(
                itemCount: places.length,
                itemBuilder: (ctx, i) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(places[i].image),
                  ),
                  title: Text(places[i].title),
                  onTap: () {},
                ),
              ),
      ),
    );
  }
}