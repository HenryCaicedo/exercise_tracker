import 'package:flutter/material.dart';
import 'widgets/activity_widget.dart';

class ActivityScreen extends StatelessWidget {
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
            child: Text('Map goes here'),
          ),
          ActivityWidget(),
        ],
      ),
    );
  }
}
