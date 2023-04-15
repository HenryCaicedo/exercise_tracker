import 'package:flutter/material.dart';

class Activity {
  final String startDate;
  final String startTime;
  final String finishDate;
  final String finishTime;
  final double distance;
  final String timeSpent;
  final int type;
  final int routeId;
  final int userId;

  Activity({
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
}

List<Activity> activities = [
  Activity(
    startDate: "14/07",
    startTime: "07:15",
    finishDate: "14/07",
    finishTime: "08:27",
    distance: 1.4,
    timeSpent: "01:12",
    type: 2,
    routeId: 1,
    userId: 1,
  ),
  Activity(
    startDate: "15/07",
    startTime: "08:30",
    finishDate: "15/07",
    finishTime: "09:45",
    distance: 3.2,
    timeSpent: "01:15",
    type: 1,
    routeId: 2,
    userId: 1,
  ),
  Activity(
    startDate: "16/07",
    startTime: "09:00",
    finishDate: "16/07",
    finishTime: "10:10",
    distance: 2.1,
    timeSpent: "01:10",
    type: 1,
    routeId: 3,
    userId: 1,
  ),
  Activity(
    startDate: "16/07",
    startTime: "09:00",
    finishDate: "16/07",
    finishTime: "10:10",
    distance: 2.1,
    timeSpent: "01:10",
    type: 2,
    routeId: 3,
    userId: 2,
  ),
];

void addActivity(Activity activity) {
  activities.insert(0, activity);
}
