import 'package:delibery_app/entidades/modelos/models/apiModels/token_model.dart';
import 'package:delibery_app/entidades/modelos/models/providers/info_login_provider.dart';
import 'package:delibery_app/logica/validadores/validadores.dart';
import 'package:delibery_app/entidades/modelos/models/apiModels/login_model.dart';
import 'package:delibery_app/services/registros_services.dart';
import 'package:delibery_app/services/token_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormularioLogin extends StatefulWidget {
  const FormularioLogin({
    super.key,
    required GlobalKey<FormState> formkey,
    required this.validador,
  }) : _formkey = formkey;

  final GlobalKey<FormState> _formkey;
  final Validadores validador;

  @override
  State<FormularioLogin> createState() => _FormularioLoginState();
}

class _FormularioLoginState extends State<FormularioLogin> {
  final TextEditingController correoController = TextEditingController();

  final TextEditingController contraseniaController = TextEditingController();
  bool _vercontrasenia = true;

  @override
  Widget build(BuildContext context) {
    //bool isPasswordVisible = false;
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: widget._formkey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: correoController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                hintText: 'Escirbe tu correo electrónico',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (widget.validador.validarCampoVacio(value) != null) {
                  return widget.validador.validarCampoVacio(value);
                }
                if (widget.validador.validarEmail(value) != null) {
                  return widget.validador.validarEmail(value);
                }
                return null;
              },
            ),
            _gap(),
            TextFormField(
              controller: contraseniaController,
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (widget.validador.validarCampoVacio(value) != null) {
                  return widget.validador.validarCampoVacio(value);
                }

                return null;
              },
              obscureText: _vercontrasenia,
              decoration: InputDecoration(
                  labelText: 'Contraseña',
                  hintText: 'Escirbe tu contraseña',
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          if (_vercontrasenia == true) {
                            _vercontrasenia = false;
                          } else {
                            _vercontrasenia = true;
                          }
                        });
                      },
                      icon: const Icon(Icons.remove_red_eye))),
            ),
            _gap(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  child: const Text("Acceder"),
                  onPressed: () {
                    if (widget._formkey.currentState!.validate()) {
                      LoginModel loginModel = LoginModel(
                          email: correoController.text,
                          password: contraseniaController.text);

                      RegistrosServices().login(loginModel.toJson()).then(
                        (value) async {
                          if (value.token.isNotEmpty) {
                            await TokenServices.setToken(value.token);
                            await TokenServices.setUsuario(int.parse(value.id));
                            guardarUsuarioLogeado(value);
                            navigaitor(value.type);
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
                  }),
            )
          ],
        ),
      ),
    );
  }

  //guardar a un usuario logeadoen InfoLoginProvider
  void guardarUsuarioLogeado(TokenModel value) {
    Provider.of<InfoLoginProvider>(context, listen: false).tokenModel = value;
  }

  void navigaitor(String type) {
    if (type == "Cliente") {
      Navigator.pushReplacementNamed(context, '/homeclient');
    } else if (type == "Encargado") {
      Navigator.pushReplacementNamed(context, '/homeencargado');
    } else if (type == "Repartidor") {
      Navigator.pushReplacementNamed(context, '/homerepartidor');
    }
  }

  Widget _gap() => const SizedBox(height: 16);
}
