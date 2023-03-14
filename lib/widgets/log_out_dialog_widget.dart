import 'package:flutter/material.dart';
import '../login_screen.dart';

class LogOutDialogWidget extends StatelessWidget {
  const LogOutDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Cerrar sesión'),
      content: const Text('¿Estás seguro de querer cerrar sesión?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: const Text('Salir'),
        ),
      ],
    );
  }
}
