import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:exercise_tracker/route_screen.dart';

class CardListWidget extends StatefulWidget {
  @override
  _CardListWidgetState createState() => _CardListWidgetState();
}

class _CardListWidgetState extends State<CardListWidget> {
  List<RouteData> _list = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    String jsonString =
        await DefaultAssetBundle.of(context).loadString('assets/routes.json');
    List<dynamic> jsonList = json.decode(jsonString);
    List<RouteData> dataList =
        jsonList.map((json) => RouteData.fromJson(json)).toList();
    setState(() {
      _list = dataList;
    });
  }

  IconData _getIcon(int type) {
    if (type == 1) {
      return Icons.directions_run;
    } else {
      return Icons.directions_bike;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // remove the app bar
      body: Padding(
        padding: const EdgeInsets.all(8.0), // set desired padding
        child: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (BuildContext context, int index) {
            RouteData data = _list[index];
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => RouteScreen(),
                      transitionDuration: Duration(milliseconds: 300),
                      transitionsBuilder: (_, animation, __, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset(1.0, 0.0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: child,
                          ),
                        );
                      },
                    ),
                  );
                },
                leading: Icon(_getIcon(data.type)),
                title: Row(
                  children: [
                    Text(
                      '${data.startDate}',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 15.0),
                    Text(
                      '${data.startTime}',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.distance} km',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                trailing: Icon(Icons.chevron_right),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // not implemented
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class RouteData {
  final String startDate;
  final String startTime;
  final String finishDate;
  final String finishTime;
  final double distance;
  final String timeSpent;
  final int type;
  final int routeId;
  final int userId;

  RouteData({
    required this.startDate,
    required this.startTime,
    required this.finishDate,
    required this.finishTime,
    required this.distance,
    required this.timeSpent,
    required this.type,
    required this.routeId,
    required this.userId,
  });

  factory RouteData.fromJson(Map<String, dynamic> json) {
    return RouteData(
      startDate: json['start_date'],
      startTime: json['start_time'],
      finishDate: json['finish_date'],
      finishTime: json['finish_time'],
      distance: json['distance'].toDouble(),
      timeSpent: json['time_spent'],
      type: json['type'],
      routeId: json['route_id'],
      userId: json['user_id'],
    );
  }
}
