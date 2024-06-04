import 'package:delibery_app/entidades/modelos/models/carrito.dart';
import 'package:delibery_app/entidades/modelos/models/providers/carrito_compras_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarritoComprasScreen extends StatefulWidget {
  const CarritoComprasScreen({super.key});

  @override
  State<CarritoComprasScreen> createState() => _CarritoComprasScreenState();
}

class _CarritoComprasScreenState extends State<CarritoComprasScreen> {
  int cantidad = 0;
  @override
  Widget build(BuildContext context) {
    final carritoProvider = context.watch<CarritoComprasProvider>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Carrito de compras'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: carritoProvider.carrito.length,
                  itemBuilder: (context, index) {
                    final compra = carritoProvider.carrito[index];

                    return ListTile(
                      leading:
                          Image.network(compra.producto!.imagen, width: 100),
                      title: Text(compra.producto!.nombre),
                      subtitle: Row(children: [
                        const Text(
                          "Cantidad: ",
                        ),
                        Text(compra.cantidad.toString()),
                        const Padding(padding: EdgeInsets.only(left: 20)),
                        IconButton(
                            onPressed: () {
                              carritoProvider.eliminarCarritoPorIndex(index);
                            },
                            icon: const Icon(Icons.delete))
                      ]),
                      trailing: Text("\$${compra.subtotal}"),
                    );
                  },
                )),
                const Text(
                  "total",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text("\$${carritoProvider.total}"),
                ElevatedButton(
                    onPressed: () {
                      if (carritoProvider.carrito.isNotEmpty) {
                        Navigator.pushNamed(context, '/confirmarCompra');
                      }
                    },
                    style: const ButtonStyle(
                        shadowColor: MaterialStatePropertyAll(Colors.black12)),
                    child: const Text("Comprar",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)))
              ],
            ),
          ),
        ));
  }
}
