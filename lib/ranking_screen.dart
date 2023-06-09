import 'package:exercise_tracker/route_screen.dart';
import 'package:flutter/material.dart';

class RankingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabla de Posiciones'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                onTap: () {},
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      index == 0 ? Icons.star : Icons.circle,
                      color: index == 0 ? Colors.yellow : Colors.grey,
                    ),
                    SizedBox(width: 10),
                    Text(
                      '${index + 1}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
                title: Text(
                  'Actividad',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '5 min',
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
    );
  }
}
