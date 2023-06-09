import 'package:flutter/material.dart';
import 'tabs/home_tab.dart';
import 'tabs/routes_tab.dart';
import 'tabs/segments_tab.dart';
import 'widgets/log_out_dialog_widget.dart';

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
      home: const TabWidget(),
    );
  }
}

class TabWidget extends StatefulWidget {
  final int initialIndex;

  const TabWidget({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  _TabWidgetState createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  final List<Widget> _tabs = [
    const HomeTab(),
    const RoutesTab(),
    const SegmentsTab(),
  ];

  final List<String> _titles = [
    'Exercise Tracker',
    'Historial de actividades',
    'Segmentos',
  ];

  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        automaticallyImplyLeading: false,
        actions: _currentIndex == 0
            ? [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => const LogOutDialogWidget(),
                    );
                    if (confirmed == true) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ]
            : null,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 180),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: _tabs[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Actividades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Segmentos',
          ),
        ],
        selectedItemColor: Colors.blue,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
