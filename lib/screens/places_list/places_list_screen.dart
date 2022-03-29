import 'package:flutter/material.dart';

import '../add_place/add_place_screen.dart';

class PlaceList extends StatelessWidget {
  const PlaceList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Places'),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddPlace()));
          }, icon: const Icon(Icons.add)),
        ],
      ),
      body: Center(child: CircularProgressIndicator(),),
    );
  }
}