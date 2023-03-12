import 'package:flutter/material.dart';

class SegmentsTab extends StatelessWidget {
  const SegmentsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // set to false to remove back button
        title: Text('Segments Screen'),
      ),
      body: Center(
        child: Text(
          'Segments screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
