import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  ImageInput(this.onSelectImage, { Key? key }) : super(key: key);

  Function onSelectImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if(photo == null) return;

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(photo.path);
    final String savedLocation = '${appDir.path}/$fileName';

    await photo.saveTo(savedLocation);

    setState(() {
      _storedImage = File(savedLocation);
    });

    widget.onSelectImage(savedLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
        child: _storedImage != null ? Image.file(_storedImage!, fit: BoxFit.cover, width: double.infinity,) : const Text('No Image Taken', textAlign: TextAlign.center,),
        alignment: Alignment.center,
      ),
      const SizedBox(width: 10),
      Expanded(child: FlatButton.icon(textColor: Theme.of(context).primaryColor, onPressed: _takePicture, icon: const Icon(Icons.camera), label: const Text('Take Photo')))
    ],);
  }
}