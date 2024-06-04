import 'package:delibery_app/entidades/enums/enum_metodo_pago.dart';
import 'package:delibery_app/screens/componentes/formularios/pago_tarjeta_form.dart';
import 'package:flutter/material.dart';

class MetodoPago extends StatefulWidget {
  const MetodoPago({super.key});

  @override
  State<MetodoPago> createState() => _MetodoPagoState();
}

class _MetodoPagoState extends State<MetodoPago> {
  EnumMetodoPago? _metodoPago = EnumMetodoPago.tarjeta;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Metodo de pago'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(children: [
            Column(
              children: [
                DropdownButton(
                  isDense: true,
                  isExpanded: true,
                  value: _metodoPago,
                  onChanged: (EnumMetodoPago? value) {
                    setState(() {
                      _metodoPago = value;
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: EnumMetodoPago.tarjeta,
                      child: Text("Pago con tarjeta"),
                    ),
                    DropdownMenuItem(
                      value: EnumMetodoPago.efectivo,
                      child: Text("Efectivo"),
                    ),
                  ],
                ),
                if (_metodoPago == EnumMetodoPago.tarjeta)
                  const PagoTarjetaForm(),
              ],
            ),
          ]),
        ),
      ),
    );
  }
  //8001232222
  //2721067079
}
