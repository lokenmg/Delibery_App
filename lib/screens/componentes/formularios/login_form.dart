import 'package:delibery_app/logica/validadores/validadores.dart';
import 'package:delibery_app/modelos/models/apiModels/login_model.dart';
import 'package:delibery_app/services/registros_services.dart';
import 'package:flutter/material.dart';

class FormularioLogin extends StatelessWidget {
  FormularioLogin({
    super.key,
    required GlobalKey<FormState> formkey,
    required this.validador,
  }) : _formkey = formkey;

  final GlobalKey<FormState> _formkey;
  final Validadores validador;
  final TextEditingController correoController = TextEditingController();
  final TextEditingController contraseniaController = TextEditingController();

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
                if (_formkey.currentState!.validate()) {
                  LoginModel loginModel = LoginModel(
                      email: correoController.text,
                      password: contraseniaController.text);

                  RegistrosServices().login(loginModel.toJson()).then(
                    (value) {
                      if (value.token.isNotEmpty) {
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Error al iniciar sesión"),
                          ),
                        );
                      }
                    },
                  );
                }
              })
        ],
      ),
    );
  }
}
