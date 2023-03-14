import 'package:flutter/material.dart';
import '../activity_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeTab(),
    );
  }
}

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  double goal = 10.0; // Dummy value for the goal
  double progress = 2.0; // Dummy value for the progress

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 3.0,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: SizedBox(
                        width: 180.0,
                        height: 180.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 20.0,
                          value: progress / goal,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.blue,
                          ),
                          backgroundColor: Colors.grey.shade300,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        '$progress / $goal km',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16.0,
                      left: 16.0, // added padding
                      right: 16.0, // added padding
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  //Aquí se pone la separación
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ActivityScreen()),
                                  );
                                },
                                icon: Icon(Icons.directions_bike),
                                label: Text('Ciclismo'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  //Aquí se pone la separación
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ActivityScreen()),
                                  );
                                },
                                icon: Icon(Icons.directions_run),
                                label: Text('Trote'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
