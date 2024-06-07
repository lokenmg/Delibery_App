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

                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(compra.producto!.imagen),
                          radius: 30,
                        ),
                        title: Text(
                          compra.producto!.nombre,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
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
                              icon: const Icon(Icons.delete, color: Colors.red))
                        ]),
                        trailing: Text("\$${compra.subtotal}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    );
                  },
                )),
                const SizedBox(height: 20),
                const Text(
                  "Total",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text("\$${carritoProvider.total}",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      if (carritoProvider.carrito.isNotEmpty) {
                        Navigator.pushNamed(context, '/confirmarCompra');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                      shadowColor: Colors.black12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: const Text("Comprar",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    ))
              ],
            ),
          ),
        ));
  }
}
