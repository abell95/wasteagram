import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/models/waste_post.dart';

void main() {
  test('WastePost generated from map should have matching values', () {
    int numItems = 10;
    String photoURL = "url";
    double latitude = 37.0;
    double longitude = -122.0;
    String datePosted = DateTime.parse('2020-08-14').toString();

    WastePost wastePost = new WastePost.fromMap({
      'quantity': numItems,
      'imageURL': photoURL,
      'latitude': latitude,
      'longitude': longitude,
      'date': datePosted,
    });

    expect(wastePost.numItems, numItems);
    expect(wastePost.photoURL, photoURL);
    expect(wastePost.latitude, latitude);
    expect(wastePost.longitude, longitude);
    expect(wastePost.datePosted, datePosted);
  });

  test('Validate latitude and longitude values can be corrected when invalid', () {
    double latitude = 150.0;
    double longitude = 270.0;

    WastePost wastePost = WastePost(latitude: latitude, longitude: longitude);

    wastePost.validateLatLon();

    expect(wastePost.latitude, 60.0);
    expect(wastePost.longitude, 90.0);
  });
}
