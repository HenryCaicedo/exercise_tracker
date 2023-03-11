import 'package:flutter/material.dart';
import 'dart:math' as math;

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  double _goal = 123.0;
  double _reached = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(
                value: _reached / _goal,
                strokeWidth: 10,
              ),
            ),
            Text(
              _reached.toStringAsFixed(0),
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Actividad', style: TextStyle(fontSize: 18)),
        icon: const Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        onPressed: () {
          setState(() {
            Navigator.pushNamed(context, '/third');
            //_reached += 1;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Log out',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'My routes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Segments',
          ),
        ],
        selectedItemColor: Colors.blue,
        onTap: (int index) {
          if (index == 0) {
            Navigator.pop(context); // Navigate back to previous screen
          } else {
            // Handle other button taps
          }
        },
      ),
    );
  }
}
