import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:exercise_tracker/route_screen.dart';
import '../lists/activity_list.dart';

class CardListWidget extends StatefulWidget {
  @override
  _CardListWidgetState createState() => _CardListWidgetState();
}

class _CardListWidgetState extends State<CardListWidget> {
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
          itemCount: activities.length,
          itemBuilder: (BuildContext context, int index) {
            Activity data = activities[index];
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => RouteScreen(data: data),
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // not implemented
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
