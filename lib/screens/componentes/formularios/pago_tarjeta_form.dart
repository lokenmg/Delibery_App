import 'package:delibery_app/logica/validadores/validadores.dart';
import 'package:flutter/material.dart';

class PagoTarjetaForm extends StatefulWidget {
  const PagoTarjetaForm({super.key});

  @override
  State<PagoTarjetaForm> createState() => _PagoTarjetaFormState();
}

TextEditingController _titularController = TextEditingController();
TextEditingController _mesExpiracionController = TextEditingController();
TextEditingController _anioExpiracionController = TextEditingController();
TextEditingController _numeroTarjetaController = TextEditingController();
TextEditingController _codigoController = TextEditingController();

class _PagoTarjetaFormState extends State<PagoTarjetaForm> {
  final validar = Validadores();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Nombre del titular",
          ),
          controller: _titularController,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (validar.validarCampoVacio(value) != null) {
              return validar.validarCampoVacio(value);
            } else {
              return null;
            }
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Número de tarjeta",
          ),
          controller: _numeroTarjetaController,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (validar.validarCampoVacio(value) != null) {
              return validar.validarCampoVacio(value);
            } else if (validar.validarEnteros(value) != null) {
              return validar.validarEnteros(value);
            } else {
              return null;
            }
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Mes de expiración",
          ),
          controller: _mesExpiracionController,
          keyboardType: TextInputType.text,
          validator: ((value) {
            if (validar.validarCampoVacio(value) != null) {
              return validar.validarCampoVacio(value);
            } else if (validar.validarEnteros(value) != null) {
              return validar.validarEnteros(value);
            } else {
              return null;
            }
          }),
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Año de expiración",
          ),
          controller: _anioExpiracionController,
          keyboardType: TextInputType.text,
          validator: ((value) {
            if (validar.validarCampoVacio(value) != null) {
              return validar.validarCampoVacio(value);
            } else if (validar.validarEnteros(value) != null) {
              return validar.validarEnteros(value);
            } else {
              return null;
            }
          }),
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Código de seguridad",
          ),
          maxLength: 3,
          controller: _codigoController,
          keyboardType: TextInputType.text,
          validator: ((value) {
            if (validar.validarCampoVacio(value) != null) {
              return validar.validarCampoVacio(value);
            } else if (validar.validarEnteros(value) != null) {
              return validar.validarEnteros(value);
            } else {
              return null;
            }
          }),
        ),
        MaterialButton(
          onPressed: () {
            if (_formkey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Pago realizado con éxito"),
                ),
              );
            }
          },
          child: const Text("pagar"),
        )
      ]),
    );
  }
}
