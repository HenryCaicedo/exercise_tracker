import 'package:flutter/material.dart';

class FourthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fourth screen'),
      ),
      body: Center(
        child: Text('This is the third screen.'),
      ),
    );
  }
}
