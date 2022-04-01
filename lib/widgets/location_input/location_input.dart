// Core

// Flutter Sdks
import 'package:flutter/material.dart';

// Packages
import 'package:geolocator/geolocator.dart';
import 'package:great_places/helpers/location_helpers/location_helper.dart';

// Providers

// Screens

// Widgets

// Helpers
import '../../helpers/db_helpers/db_helper.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    await Geolocator.openLocationSettings();
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          padding: const EdgeInsets.all(5),
          child: _previewImageUrl != null
              ? Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text('No Location Selected', textAlign: TextAlign.center,),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(textColor: Theme.of(context).primaryColor, onPressed: () async {
              try {
                final Position position = await _determinePosition();
                print(
                  ''' accuracy: ${position.accuracy},
                      altitude: ${position.altitude},
                      floor: ${position.floor},
                      latitude: ${position.latitude},
                      longitude: ${position.longitude},
                      speed: ${position.speed},
                  '''
                );

                final staticMapImageUrl = LocationHelper.generateLocationPreviewUrl(latitude: position.latitude, longitude: position.longitude);

                setState(() {
                  _previewImageUrl = staticMapImageUrl;
                });

              } catch (e) {
                print(' error: ${e} ');
              }
            }, icon: const Icon(Icons.location_on), label: const Text('Current Location')),
            const SizedBox(height:10),
            FlatButton.icon(textColor: Theme.of(context).primaryColor, onPressed: () {}, icon: Icon(Icons.map), label: const Text('Select On Map')),
          ],
        )
      ],
    );
  }
}
