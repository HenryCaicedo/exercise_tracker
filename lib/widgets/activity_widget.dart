import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../lists/activity_list.dart';
import '../tab_widget.dart';
import 'package:exercise_tracker/data/database.dart';
import 'package:exercise_tracker/activity_screen.dart' as act;
import 'package:geolocator/geolocator.dart';

class ActivityWidget extends StatefulWidget {
  final int activityType; // define the parameter as a final field

  ActivityWidget({required this.activityType}); // add a constructor

  @override
  _ActivityWidgetState createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends State<ActivityWidget> {
  bool _isPaused = true;
  int _elapsedSeconds = 0;
  Timer? _timer;
  var inicio = '11:30';
  var fin = '13:23';
  var startDateTime;

  IconData _getIcon(int type) {
    if (type == 1) {
      return Icons.directions_run;
    } else {
      return Icons.directions_bike;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        _elapsedSeconds++;
      });
    });

    // Save the start datetime only if it is null
    if (startDateTime == null) {
      startDateTime = DateTime.now();
    }
  }

  void _pauseTimer() {
    _timer?.cancel();
    _isPaused = true;
  }

  void _resumeTimer() {
    _isPaused = false;
    _startTimer();
  }

  void _stopTimer() async {
    _timer?.cancel();
    _isPaused = false;

    // // Create a new Activity object with dummy data
    // DateTime finishDateTime = DateTime.now();

    // Activity newActivity = Activity(
    //   startDate: DateFormat('dd/MM').format(startDateTime),
    //   startTime: DateFormat('HH:mm').format(startDateTime),
    //   finishDate: DateFormat('dd/MM').format(finishDateTime),
    //   finishTime: DateFormat('HH:mm').format(finishDateTime),
    //   distance: 0,
    //   timeSpent:
    //       '${(_elapsedSeconds ~/ 3600).toString().padLeft(2, '0')}:${((_elapsedSeconds % 3600) ~/ 60).toString().padLeft(2, '0')}:${(_elapsedSeconds % 60).toString().padLeft(2, '0')}',
    //   type: widget.activityType,
    //   routeId: activities.length + 1,
    //   userId: 1,
    // );

    // // Add the new activity to the list
    // addActivity(newActivity);
    final prefs = await SharedPreferences.getInstance();
    final idUsuario = prefs.getInt('userId') ?? -1;
    final tipo = prefs.getInt('tipo') ?? -1;
    String tipoActividad;

    if (tipo == 0) {
      tipoActividad = 'trote';
    } else {
      tipoActividad = 'ciclismo';
    }

    await DatabaseHelper.instance.createRecorrido(
        idUsuario,
        act.ActivityScreen.getDistancia(),
        tipoActividad,
        _elapsedSeconds,
        act.ActivityScreen.getPuntos());
    cleartipo();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('actividad guardada'),
      ),
    );

    // Reset the elapsed seconds
    _elapsedSeconds = 0;
    act.ActivityScreen.closeGeo();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TabWidget(initialIndex: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                _getIcon(widget.activityType),
                size: 35,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tiempo',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${(_elapsedSeconds ~/ 3600).toString().padLeft(2, '0')}:${((_elapsedSeconds % 3600) ~/ 60).toString().padLeft(2, '0')}:${(_elapsedSeconds % 60).toString().padLeft(2, '0')}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Distancia',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '0 km',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Column(
                children: [
                  IconButton(
                    icon:
                        _isPaused ? Icon(Icons.play_arrow) : Icon(Icons.pause),
                    onPressed: () {
                      setState(() {
                        _isPaused = !_isPaused;
                        if (_isPaused) {
                          _pauseTimer();
                        } else {
                          _resumeTimer();
                        }
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  IconButton(
                    icon: Icon(Icons.stop),
                    onPressed: () {
                      setState(() {
                        _stopTimer();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> cleartipo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('tipo');
  }
}
