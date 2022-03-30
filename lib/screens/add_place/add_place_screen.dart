import 'dart:io';

// flutter sdk
import 'package:flutter/material.dart';

// third party imports
import 'package:provider/provider.dart';

// providers
import '../../providers/places/places.dart';

// screens

// widgets
import '../../widgets/image_input/image_input.dart';

class AddPlace extends StatefulWidget {
  AddPlace({Key? key}) : super(key: key);

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  String? _pickedImage;

  final _titleController = TextEditingController();

  void _selectImage(String savedImgLocation) {
    _pickedImage = savedImgLocation;
  }

  void _savePlace() {
    if(_titleController.text.isEmpty || _pickedImage == null) return;
    
    context.read<GreatPlaces>().savePlace(_titleController.text, _pickedImage!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new place'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration:
                          const InputDecoration(labelText: 'Place', hintText: 'Dhaka'),
                    ),
                    const SizedBox(height: 10),
                    ImageInput(_selectImage)
                  ],
                ),
              ),
            ),
            RaisedButton.icon(
              onPressed: _savePlace,
              icon: Icon(Icons.add),
              label: Text('Add Place'),
              color: Theme.of(context).colorScheme.secondary,
            )
          ],
        ),
      ),
    );
  }
}
