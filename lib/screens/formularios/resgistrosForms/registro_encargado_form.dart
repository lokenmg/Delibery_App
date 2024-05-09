import 'package:delibery_app/validadores/validadores.dart';
import 'package:flutter/material.dart';

import '../componentes/dropdounsbuton/dropdownbutton_genero.dart';

class FormRegistroEncargado extends StatefulWidget {
  const FormRegistroEncargado({super.key});

  @override
  State<FormRegistroEncargado> createState() => _FormRegistroEncargadoState();
}

TextEditingController nombreController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController generoController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController calle1Controller = TextEditingController();
TextEditingController calle2Controller = TextEditingController();
TextEditingController calle3Controller = TextEditingController();
TextEditingController coloniaController = TextEditingController();
TextEditingController cpController = TextEditingController();
TextEditingController estadoController = TextEditingController();
TextEditingController municipioController = TextEditingController();
TextEditingController numeroExteriorController = TextEditingController();
TextEditingController numeroInteriorController = TextEditingController();
TextEditingController referenciaController = TextEditingController();

class _FormRegistroEncargadoState extends State<FormRegistroEncargado> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final Validar = Validadores();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(children: <Widget>[
        Title(
            color: Colors.black,
            child: const Text(
              "Registro como encargado",
              style: TextStyle(fontSize: 25),
            )),
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Nombre",
          ),
          controller: nombreController,
          validator: (value) {
            if (Validar.validarCampoVacio(value) != null) {
              return Validar.validarCampoVacio(value);
            }
            return null;
          },
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: "Email"),
          controller: emailController,
          validator: (value) {
            if (Validar.validarCampoVacio(value) != null) {
              return Validar.validarCampoVacio(value);
            }
            if (Validar.validarEmail(value) != null) {
              return Validar.validarEmail(value);
            }
            return null;
          },
        ),
        Title(color: Colors.black, child: Text("Género")),
        DropdownButtonGenero(),
      ]),
    );
  }
}
