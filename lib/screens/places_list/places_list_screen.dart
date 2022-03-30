// Core
import 'dart:io';

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
        child: FutureBuilder(
          future: context.read<GreatPlaces>().fetchAndSetPlace(),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<GreatPlaces>(
                      child: const Text('No Place Found!'),
                      builder: (ctx, greatPlace, child) => greatPlace.places.isEmpty ? child! : ListView.builder(
                        itemCount: greatPlace.places.length,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(File(greatPlace.places[i].image)),
                          ),
                          title: Text(greatPlace.places[i].title),
                          onTap: () {},
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
