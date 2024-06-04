import 'package:delibery_app/logica/validadores/validadores.dart';
import 'package:delibery_app/screens/componentes/formularios/componentes/dropdounsbuton/logo_component.dart';
import 'package:flutter/material.dart';

import 'componentes/formularios/login_form.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    final validador = Validadores();
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 150),
        reverse: true,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const LogoComponent(),
              FormularioLogin(formkey: formkey, validador: validador),
              MaterialButton(
                  child: const Text("Registrarme"),
                  onPressed: () {
                    Navigator.pushNamed(context, "/registro");
                  })
            ],
          ),
        ),
      ),
    );
  }
}
