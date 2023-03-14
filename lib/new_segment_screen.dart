import 'package:flutter/material.dart';
import 'segment_screen.dart';

class NewSegmentScreen extends StatelessWidget {
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
        title: Text('Nuevo segmento'),
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
                  height: 200,
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
                  leading: Icon(Icons.label),
                  title: TextField(
                    decoration: InputDecoration(
                      labelText: 'Nombre del segmento',
                    ),
                    onChanged: (value) {},
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.directions_bike),
                  title: Text('Tipo de actividad:'),
                  trailing: DropdownButton<String>(
                    value: 'cycling',
                    items: [
                      DropdownMenuItem<String>(
                        value: 'cycling',
                        child: Text('Ciclismo'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'running',
                        child: Text('Trote'),
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.place),
                  title: Text('Distancia:'),
                  subtitle: Text('1.1 km'),
                ),
                ListTile(
                  leading: Icon(Icons.timer),
                  title: Text('Tiempo aproximado:'),
                  subtitle: Text('15 min'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  child: Text('Crear'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SegmentScreen()),
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
