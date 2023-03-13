import 'package:flutter/material.dart';
import '../activity_screen.dart';

class ActivityDialog extends StatelessWidget {
  final List<String> activityTypes = [
    'Trote',
    'Caminata',
    'Senderismo',
    'Ciclismo'
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nueva actividad'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Tipo'),
          DropdownButton<String>(
            isExpanded: true,
            value: activityTypes[0],
            onChanged: (String? newValue) {},
            items: activityTypes
                .map<DropdownMenuItem<String>>(
                  (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ),
                )
                .toList(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/activity');
          },
          child: const Text('Iniciar'),
        ),
      ],
    );
  }
}
