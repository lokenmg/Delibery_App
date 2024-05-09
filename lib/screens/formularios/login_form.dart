import 'package:delibery_app/validadores/validadores.dart';
import 'package:flutter/material.dart';

class FormularioLogin extends StatelessWidget {
  FormularioLogin({
    super.key,
    required GlobalKey<FormState> formkey,
    required this.validador,
  }) : _formkey = formkey;

  final GlobalKey<FormState> _formkey;
  final Validadores validador;
  TextEditingController correoController = TextEditingController();
  TextEditingController contraseniaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: correoController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: "Correo electronico"),
            validator: (value) {
              if (validador.validarCampoVacio(value) != null) {
                return validador.validarCampoVacio(value);
              }
              if (validador.validarEmail(value) != null) {
                return validador.validarEmail(value);
              }
              return null;
            },
          ),
          TextFormField(
            controller: contraseniaController,
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(labelText: "Contraseña"),
            validator: (value) {
              if (validador.validarCampoVacio(value) != null) {
                return validador.validarCampoVacio(value);
              }

              return null;
            },
          ),
          MaterialButton(
              child: const Text("Acceder"),
              onPressed: () {
                if (_formkey.currentState!.validate()) {}
              })
        ],
      ),
    );
  }
}
