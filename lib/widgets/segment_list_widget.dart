import 'package:flutter/material.dart';
import '../segment_screen.dart';
import '../new_segment_screen.dart';

class SegmentListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // remove the app bar
      body: Padding(
        padding: const EdgeInsets.all(8.0), // set desired padding
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            //RouteData data = _list[index];
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => SegmentScreen(),
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
                leading: const Icon(Icons.directions_run),
                title: Row(
                  children: [
                    Text(
                      'Segmento',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 15.0),
                    Text(
                      '',
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
                      'Trote: 4 km',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewSegmentScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
