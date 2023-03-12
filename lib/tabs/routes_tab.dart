import 'package:flutter/material.dart';
import '../widgets/card_list_widget.dart';

class RoutesTab extends StatelessWidget {
  const RoutesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Rutas'),
        automaticallyImplyLeading: false, // Remove the back button
      ),
      body: CardListWidget(),
    );
  }
}
