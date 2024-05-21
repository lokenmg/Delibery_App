import 'package:delibery_app/logica/validadores/validadores.dart';
import 'package:flutter/material.dart';

import 'formularios/login_form.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    final validador = Validadores();
    return Scaffold(
      body: Column(
        children: [
          Title(color: Colors.black, child: const Text("Iniciar sesion")),
          FormularioLogin(formkey: formkey, validador: validador),
          MaterialButton(
              child: const Text("Registrarme"),
              onPressed: () {
                Navigator.pushNamed(context, "/registro");
              })
        ],
      ),
    );
  }
}
