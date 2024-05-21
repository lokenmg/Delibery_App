import 'package:delibery_app/entidades/enums/enum_usuarios.dart';
import 'package:delibery_app/screens/formularios/resgistrosForms/registro_encargado_form.dart';
import 'package:delibery_app/screens/formularios/resgistrosForms/registro_repartidor_form.dart';
import 'package:flutter/material.dart';

import 'formularios/resgistrosForms/registro_cliente_form.dart';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  EnumUsuarios? _usuarioSeleccionado;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro"),
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: ListView(children: [
          const Padding(padding: EdgeInsets.all(10)),
          Title(
              color: Colors.black,
              child: const Text(
                "Registro",
                style: TextStyle(fontSize: 25),
              )),
          DropdownButton(
              elevation: 9,
              items: const [
                DropdownMenuItem<EnumUsuarios>(
                  value: EnumUsuarios.cliente,
                  child: Text("Cliente"),
                ),
                DropdownMenuItem<EnumUsuarios>(
                  value: EnumUsuarios.repartidor,
                  child: Text("Repartidor"),
                ),
                DropdownMenuItem<EnumUsuarios>(
                    value: EnumUsuarios.encargado, child: Text("Encargado")),
              ],
              value: _usuarioSeleccionado,
              onChanged: (EnumUsuarios? value) {
                setState(() {});
                _usuarioSeleccionado = value;
              }),
          if (_usuarioSeleccionado == EnumUsuarios.encargado)
            const FormRegistroEncargado(),
          if (_usuarioSeleccionado == EnumUsuarios.cliente)
            const FormRegistrocliente(),
          if (_usuarioSeleccionado == EnumUsuarios.repartidor)
            const FormRegistroRepartidor(),
        ]),
      ),
    );
  }
}
