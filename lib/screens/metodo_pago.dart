import 'package:flutter/material.dart';

class MetodoPago extends StatefulWidget {
  const MetodoPago({super.key});

  @override
  State<MetodoPago> createState() => _MetodoPagoState();
}

class _MetodoPagoState extends State<MetodoPago> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Metodo de pago'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const Text(
                "Selecciona tu metodo de pago",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/carrito');
                },
                child: const Text("Pagar con tarjeta"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/carrito');
                },
                child: const Text("Pagar con efectivo"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
