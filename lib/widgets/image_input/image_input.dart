import 'package:flutter/material.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  const ImageInput({ Key? key }) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
        child: _storedImage != null ? Image.file(_storedImage!, fit: BoxFit.cover,) : const Text('No Image Taken', textAlign: TextAlign.center,),
        alignment: Alignment.center,
      ),
      const SizedBox(width: 10),
      Expanded(child: FlatButton.icon(textColor: Theme.of(context).primaryColor, onPressed: () {}, icon: const Icon(Icons.camera), label: const Text('Take Photo')))
    ],);
  }
}