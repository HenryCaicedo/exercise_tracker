import 'dart:convert';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // remove the app bar
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (BuildContext context, int index) {
          RouteData data = _list[index];
          return Card(
            child: ListTile(
              title: Text(
                '${data.startDate} ${data.startTime}',
                style: TextStyle(fontSize: 18.0),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tiempo: ${data.timeSpent}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'Distancia: ${data.distance} km',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          );
        },
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
