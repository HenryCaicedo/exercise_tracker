import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'tab_widget.dart';
import 'activity_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/tabs': (context) => const TabWidget(),
        '/activity': (context) => ActivityScreen(activityType: 1),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}
