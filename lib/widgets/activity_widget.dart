import 'dart:async';

import 'package:flutter/material.dart';

class ActivityWidget extends StatefulWidget {
  @override
  _ActivityWidgetState createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends State<ActivityWidget> {
  bool _isPaused = false;
  int _elapsedSeconds = 0;
  Timer? _timer;

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
  }

  void _pauseTimer() {
    _timer?.cancel();
    _isPaused = true;
  }

  void _resumeTimer() {
    _isPaused = false;
    _startTimer();
  }

  void _stopTimer() {
    _timer?.cancel();
    _isPaused = false;
    _elapsedSeconds = 0;
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
                Icons.directions_run,
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
                      _isPaused ? '$_elapsedSeconds segundos' : '00:00:$_elapsedSeconds',
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
                    icon: _isPaused ? Icon(Icons.play_arrow) : Icon(Icons.pause),
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
}
