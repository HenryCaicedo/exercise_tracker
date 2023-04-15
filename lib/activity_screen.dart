import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/directions.dart' as web;
import 'widgets/activity_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class ActivityScreen extends StatefulWidget {
  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  Set<Polyline> currentRoute = Set();
  web.GoogleMapsDirections directionsApi = web.GoogleMapsDirections(
      apiKey: "AIzaSyAcivqojnFPufHk6fsVDrGTcoQpG_2ufEU");

  late GoogleMapController _mapController;
  Set<Polyline> newRoute = Set();
  List<LatLng> points = [];
  Set<Polyline> polylines = Set();
  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(0, 0),
    zoom: 18,
  );

  // final Map<PolylineId,Polyline> _polylines={};
  // Set<Polyline> get polylines=>_polylines.values.toSet();

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  void setPoly(Set<Polyline> p) {}

  void updateposition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final newPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 20);
    setState(() {
      _kGooglePlex = newPosition;
    });
  }

  void rastreo() {
    StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
        locationSettings: LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 40,
    )).listen((Position? position) async {
      if (position == null) {
        print('Unknown');
      } else {
        print(
            '${position.latitude.toString()}, ${position.longitude.toString()}');
        print("----------------------------------------");
        // LatLng temp = LatLng(position.latitude, position.longitude);
        // const PolylineId polylineId = PolylineId('group');
        // late Polyline polyline;
        // if (_polylines.containsKey(polylineId)) {
        //   final tmp = _polylines[polylineId]!;
        //   polyline = tmp.copyWith(
        //     pointsParam: [...tmp.points, temp],
        //   );
        // } else {
        //   polyline = Polyline(
        //     polylineId: polylineId,
        //     points: [temp],
        //   );
        // }
        // _polylines[polylineId] = polyline;

        if (points.isNotEmpty) {
          var from = points.last;
          var to = LatLng(position.latitude, position.longitude);
          var routePoints = await findDirections(from, to);
          points.addAll(routePoints);
        }

        points.add(LatLng(position.latitude, position.longitude));
        var line = Polyline(
          points: points,
          polylineId: PolylineId("mejor ruta"),
          color: Colors.red,
          width: 4,
        );
        print(points);
        newRoute.add(line);
        setState(() {
          polylines = newRoute;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    updateposition();
    points = [];
    rastreo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity screen'),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.black.withOpacity(0.2),
          ),
          Center(
              child: GoogleMap(
            initialCameraPosition: _kGooglePlex,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            polylines: polylines,
            onMapCreated: _mapcreated,
          )),
          ActivityWidget(),
        ],
      ),
    );
  }

  void _mapcreated(GoogleMapController controller) {
    _mapController = controller;
    _centerView();
  }

  _centerView() async {
    await _mapController.getVisibleRegion();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var left = min(position.latitude, position.latitude);
    var right = max(position.latitude, position.latitude);
    var top = max(position.longitude, position.longitude);
    var bottom = min(position.longitude, position.longitude);

    var bounds = LatLngBounds(
      southwest: LatLng(left, bottom),
      northeast: LatLng(right, top),
    );
    var cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 40);
    _mapController.animateCamera(cameraUpdate);
  }

  Future<List<LatLng>> findDirections(LatLng from, LatLng to) async {
    var origin = web.Location(lat: from.latitude, lng: from.longitude);
    var destination = web.Location(lat: to.latitude, lng: to.longitude);

    var result = await directionsApi.directionsWithLocation(
      origin,
      destination,
      travelMode: web.TravelMode.walking,
    );

    List<LatLng> points = [];

    if (result.isOkay) {
      var route = result.routes[0];
      var leg = route.legs[0];

      leg.steps.forEach((step) {
        points.add(LatLng(step.startLocation.lat, step.startLocation.lng));
        points.add(LatLng(step.endLocation.lat, step.endLocation.lng));
      });
    } else {
      print("ERRROR !!! ${result.status}");
    }

    return points;
  }
}
