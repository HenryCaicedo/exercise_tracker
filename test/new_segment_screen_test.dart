// Import the test package and Counter class
import 'package:exercise_tracker/new_segment_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


void main() {
  test('calculateDistance should return the total distance between all points', () {
    final points = [
      LatLng(37.4219999,-122.0840575),
      LatLng(37.4219999,-122.0840575),
      LatLng(37.4220941,-122.0844322),
      LatLng(37.4220989,-122.0844342),
      LatLng(37.4223152,-122.0850453),
      LatLng(37.4223775,-122.0851425),
      LatLng(37.4224956,-122.0854697),
      LatLng(37.4225633,-122.0857763),
      LatLng(37.4226194,-122.0860074),
      LatLng(37.422718,-122.0864069),
      LatLng(37.4227758,-122.0866154),
      LatLng(37.4228545,-122.0869775),
      LatLng(37.422911,-122.0871971),
      LatLng(37.4230056,-122.0876687),
      LatLng(37.4230843,-122.0879958),
      LatLng(37.4231177,-122.0881786),
      LatLng(37.4231649,-122.0883858),
      LatLng(37.4231966,-122.0885582),
      LatLng(37.4232675,-122.0888799),
      LatLng(37.4233051,-122.0890803),
      LatLng(37.4233599,-122.0892934),
      LatLng(37.423423,-122.0895185),
      LatLng(37.4234647,-122.0897049),
      LatLng(37.4235587,-122.0901521),
      LatLng(37.4236148,-122.0903832),
      LatLng(37.4236661,-122.0905863),
      LatLng(37.4237043,-122.0907832),
      LatLng(37.4237461,-122.0909659),
      LatLng(37.4237709,-122.0910738),
    ];

    final expectedDistance = 652.8854115513275;

    expect(calculateDistance(points), equals(expectedDistance));
  });
}

double calculateDistance(List<LatLng> points) {
  double totalDistance = 0.0;
  for (int i = 1; i < points.length; i++) {
    final distance = Geolocator.distanceBetween(
        points[i - 1].latitude, points[i - 1].longitude, points[i].latitude, points[i].longitude);
    totalDistance += distance;
  }
  return totalDistance;
}