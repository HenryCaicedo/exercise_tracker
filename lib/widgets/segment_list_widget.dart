import 'package:flutter/material.dart';
import '../segment_screen.dart';
import '../new_segment_screen.dart';

class Segmento {
  final String name;
  final String type;
  final double distance;

  Segmento({
    required this.name,
    required this.type,
    required this.distance,
  });
}

class SegmentListWidget extends StatefulWidget {
  @override
  _SegmentListWidgetState createState() => _SegmentListWidgetState();

  void addSegment(Segmento segmento) {
    _SegmentListWidgetState().addSegment(segmento);
  }
}

class _SegmentListWidgetState extends State<SegmentListWidget> {
  List<Segmento> segments = [
    Segmento(name: 'Segmento 1', type: 'Ciclismo', distance: 10.5),
    Segmento(name: 'Segmento 2', type: 'Trote', distance: 5.0),
    Segmento(name: 'Segmento 3', type: 'Ciclismo', distance: 8.2),
    Segmento(name: 'Segmento 4', type: 'Trote', distance: 2.7),
    Segmento(name: 'Segmento 5', type: 'Ciclismo', distance: 12.3),
    Segmento(name: 'Segmento 6', type: 'Ciclismo', distance: 12.2),
  ];

  void addSegment(Segmento segmento) {
    setState(() {
      segments.insert(0, segmento);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: segments.length,
          itemBuilder: (BuildContext context, int index) {
            Segmento segmento = segments[index];
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
                      segmento.name,
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
                      '${segmento.type}: ${segmento.distance.toString()} km',
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
        onPressed: () async {
          final Segmento? newSegment = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewSegmentScreen()),
          );
          if (newSegment != null) {
            addSegment(newSegment);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
