import 'package:flutter/material.dart';

class CardListWidget extends StatefulWidget {
  @override
  _CardListWidgetState createState() => _CardListWidgetState();
}

class _CardListWidgetState extends State<CardListWidget> {
  List<String> _list = ['Actividad 1', 'Actividad 2', 'Actividad 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // remove the app bar
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(_list[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _list.add('Actividad ${_list.length + 1}');
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
