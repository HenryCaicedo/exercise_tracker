import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'segment_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'widgets/segment_list_widget.dart';
import 'lists/segment_list.dart';
import 'tab_widget.dart';
import 'package:exercise_tracker/data/database.dart';

class NewSegmentScreen extends StatefulWidget {
  @override
  State<NewSegmentScreen> createState() => _NewSegmentScreenState();
}

class _NewSegmentScreenState extends State<NewSegmentScreen> {
  String _selectedActivity = 'trote';
  final TextEditingController _nameController = TextEditingController();
  late GoogleMapController _mapController;
  final LatLng fromPoint = LatLng(-38.956176, -67.920666);

  final LatLng toPoint = LatLng(-38.953724, -67.923921);

  final Map<MarkerId, Marker> _marcadores = {};

  _onTap(LatLng position) {
    setState(() {
      if (mark.length == 2) {
        mark.clear();
      }
      mark.add(
        Marker(
          markerId: MarkerId(mark.length.toString()),
          position: position,
          infoWindow: InfoWindow(title: "Punto"),
        ),
      );
      print(mark.length);
    });

    // final markerId = MarkerId(_marcadores.length.toString());
    // final marker = Marker(markerId: markerId, position: position);
    // _marcadores[markerId] = marker;
    // print(_marcadores.values);
  }

  var mark = Set<Marker>();

  Set<Marker> _createMarkers() {
    var tmp = Set<Marker>();
    tmp.add(
      Marker(
        markerId: MarkerId("fromPoint"),
        position: fromPoint,
        infoWindow: InfoWindow(title: "Pizzeria"),
      ),
    );

    return tmp;
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

  @override
  void initState() {
    super.initState();
    mark.clear();
  }

  bool _isPublic = false;

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
        title: Text('Nuevo segmento'),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      color: Colors.grey[300],
                    ),
                    child: Center(
                        child: GoogleMap(
                      initialCameraPosition:
                          CameraPosition(target: LatLng(0, 0), zoom: 10),
                      markers: mark,
                      onTap: _onTap,
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      onMapCreated: _mapcreated,
                    )),
                  ),
                  ListTile(
                    leading: Icon(Icons.label),
                    title: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Nombre del segmento',
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.directions_bike),
                    title: Text('Tipo de actividad:'),
                    trailing: DropdownButton<String>(
                      value: 'ciclismo',
                      items: [
                        DropdownMenuItem<String>(
                          value: 'ciclismo',
                          child: Text('Ciclismo'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'trote',
                          child: Text('Trote'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedActivity = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.place),
                    title: Text('Distancia:'),
                    subtitle: Text('1.1 km'),
                  ),
                  ListTile(
                    leading: Icon(Icons.timer),
                    title: Text('Tiempo aproximado:'),
                    subtitle: Text('15 min'),
                  ),
                  ListTile(
                    leading: Icon(Icons.public),
                    title: Text('Hacer público:'),
                    trailing: Switch(
                      value: _isPublic,
                      onChanged: (value) {
                        setState(() {
                          _isPublic = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    child: Text('Crear'),
                    onPressed: () {
                      if (mark.length == 2) {
                        crearSegmento(
                            _isPublic,
                            _nameController.text,
                            _selectedActivity,
                            0.0, //distancia
                            0, //tiempo
                            obtenerInicio(mark),
                            obtenerFin(mark));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TabWidget(initialIndex: 2)),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('introduzca 2 puntos validos'),
                          ),
                        );
                      }

                      addSegment(Segmento(
                          id: '1',
                          userId: '1',
                          name: 'Segmento 1',
                          type: 'Ciclismo',
                          distance: 10.5));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void crearSegmento(
      bool publico,
      String nombre,
      String tipoActividad,
      double distancia,
      int tiempo,
      String puntoInicio,
      String puntoFinal) async {
    int privacidad;
    if (publico) {
      privacidad = 1;
    } else {
      privacidad = 0;
    }
    final prefs = await SharedPreferences.getInstance();
    final idUsuario = prefs.getInt('userId') ?? -1;

    await DatabaseHelper.instance.createSegment(idUsuario, privacidad, nombre,
        tipoActividad, distancia, tiempo, puntoInicio, puntoFinal);
  }

  String obtenerInicio(Set<Marker> markers) {
    if (markers.isEmpty) {
      return '';
    }
    LatLng inicio = markers.first.position;
    return '${inicio.latitude.toStringAsFixed(6)},${inicio.longitude.toStringAsFixed(6)}';
  }

  String obtenerFin(Set<Marker> markers) {
    if (markers.isEmpty) {
      return '';
    }
    LatLng fin = markers.last.position;
    return '${fin.latitude.toStringAsFixed(6)},${fin.longitude.toStringAsFixed(6)}';
  }
}
