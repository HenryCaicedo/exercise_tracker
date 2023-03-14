import 'package:flutter/material.dart';
import 'ranking_screen.dart';

class SegmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Date'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Card(
          color: Colors.white,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    color: Colors.grey[300],
                  ),
                  child: Center(
                    child: Text(
                      'Map goes here',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.directions_walk),
                  title: Text('Distancia:'),
                  subtitle: Text('1.1 km'),
                ),
                ListTile(
                  leading: Icon(Icons.timer),
                  title: Text('Mejor tiempo:'),
                  subtitle: Text('15 min'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  child: Text('Tabla de posiciones'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RankingScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
