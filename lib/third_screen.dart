import 'package:flutter/material.dart';

import 'widgets/card_list_widget.dart';

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Screen'),
      ),
      body: CardListWidget(),
    );
  }
}
