const GOOGLE_MAP_API = 'AIzaSyB2RKoVBuly5gt_Jpc9wB_DyBU6Am8VSes';

class LocationHelper {
  static String generateLocationPreviewUrl({required double latitude, required double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_MAP_API';
  } 
}