import 'package:flutter/material.dart';
import 'ranking_screen.dart';
import 'tab_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as map;
import 'package:geolocator/geolocator.dart';
import 'dart:math';
import 'package:google_maps_webservice/directions.dart';

class SegmentScreen extends StatefulWidget {
  @override
  State<SegmentScreen> createState() => _SegmentScreenState();
}

class _SegmentScreenState extends State<SegmentScreen> {
  Set<map.Polyline> currentRoute = Set();
  GoogleMapsDirections directionsApi =
      GoogleMapsDirections(apiKey: "AIzaSyAcivqojnFPufHk6fsVDrGTcoQpG_2ufEU");

  late GoogleMapController _mapController;

  final LatLng fromPoint = LatLng(-38.956176, -67.920666);

  final LatLng toPoint = LatLng(-38.953724, -67.923921);

  findDirections(LatLng from, LatLng to) async {
    var origin = Location(lat: from.latitude, lng: from.longitude);
    var destination = Location(lat: to.latitude, lng: to.longitude);

    var result = await directionsApi.directionsWithLocation(
      origin,
      destination,
      travelMode: TravelMode.driving,
    );
    print(result);
    Set<map.Polyline> newRoute = Set();

    if (result.isOkay) {
      var route = result.routes[0];
      var leg = route.legs[0];

      List<map.LatLng> points = [];

      leg.steps.forEach((step) {
        points.add(map.LatLng(step.startLocation.lat, step.startLocation.lng));
        points.add(map.LatLng(step.endLocation.lat, step.endLocation.lng));
      });

      var line = map.Polyline(
        points: points,
        polylineId: map.PolylineId("mejor ruta"),
        color: Colors.red,
        width: 4,
      );
      newRoute.add(line);

      print(line);
      setState(() {
        currentRoute = newRoute;
      });
    } else {
      print("ERRROR !!! ${result.status}");
    }
  }

  Set<Marker> _createMarkers() {
    GoogleMapsDirections directionsApi =
        GoogleMapsDirections(apiKey: "AIzaSyAcivqojnFPufHk6fsVDrGTcoQpG_2ufEU");
    var tmp = Set<Marker>();

    tmp.add(
      Marker(
        markerId: MarkerId("fromPoint"),
        position: fromPoint,
        infoWindow: InfoWindow(title: "Pizzeria"),
      ),
    );
    tmp.add(
      Marker(
        markerId: MarkerId("toPoint"),
        position: toPoint,
        infoWindow: InfoWindow(title: "Roca 123"),
      ),
    );

    return tmp;
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    _centerView();
    findDirections(fromPoint, toPoint);
  }

  _centerView() async {
    // var api = Provider.of<DirectionProvider>(context);

    await _mapController.getVisibleRegion();

    // print("buscando direcciones");
    // await api.findDirections(widget.fromPoint, widget.toPoint);

    var left = min(fromPoint.latitude, toPoint.latitude);
    var right = max(fromPoint.latitude, toPoint.latitude);
    var top = max(fromPoint.longitude, toPoint.longitude);
    var bottom = min(fromPoint.longitude, toPoint.longitude);

    // api.currentRoute.first.points.forEach((point) {
    //   left = min(left, point.latitude);
    //   right = max(right, point.latitude);
    //   top = max(top, point.longitude);
    //   bottom = min(bottom, point.longitude);
    // });

    var bounds = LatLngBounds(
      southwest: LatLng(left, bottom),
      northeast: LatLng(right, top),
    );
    var cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);
    _mapController.animateCamera(cameraUpdate);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Date'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Card(
          color: Colors.white,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    color: Colors.grey[300],
                  ),
                  child: Center(
                    child: GoogleMap(
                      initialCameraPosition:
                          CameraPosition(target: fromPoint, zoom: 15),
                      markers: _createMarkers(),
                      polylines: currentRoute,
                      onMapCreated: _onMapCreated,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.directions_walk),
                  title: Text('Distancia:'),
                  subtitle: Text('1.1 km'),
                ),
                ListTile(
                  leading: Icon(Icons.timer),
                  title: Text('Mejor tiempo:'),
                  subtitle: Text('15 min'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  child: Text('Tabla de posiciones'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RankingScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
