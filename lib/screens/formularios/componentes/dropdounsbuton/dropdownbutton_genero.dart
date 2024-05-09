import 'package:flutter/material.dart';
import 'package:delibery_app/entidades/enums/enum_genero.dart';

DropdownButton<EnumGenero> DropdownButtonGenero() {
  EnumGenero? _generoSeleccionado = EnumGenero.masculino;
  return DropdownButton(
      items: const [
        DropdownMenuItem(
          value: EnumGenero.masculino,
          child: Text("Masculino"),
        ),
        DropdownMenuItem(
          value: EnumGenero.femenino,
          child: Text("Femenino"),
        ),
        DropdownMenuItem(
          value: EnumGenero.otro,
          child: Text("Otro"),
        )
      ],
      value: _generoSeleccionado,
      onChanged: (EnumGenero? value) {
        _generoSeleccionado = value;
      });
}
