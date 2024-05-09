import 'package:delibery_app/validadores/validadores.dart';
import 'package:flutter/material.dart';

import 'formularios/login_form.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    final validador = Validadores();
    return Scaffold(
      body: Column(
        children: [
          Title(color: Colors.black, child: Text("Iniciar sesion")),
          FormularioLogin(formkey: _formkey, validador: validador),
          MaterialButton(
              child: Text("Registrarme"),
              onPressed: () {
                Navigator.pushNamed(context, "/registro");
              })
        ],
      ),
    );
  }
}
