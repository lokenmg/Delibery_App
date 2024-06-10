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
    final CarritoComprasProvider carritoProvider =
        context.watch<CarritoComprasProvider>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Carrito de compras'),
        ),
        body: carritoProvider.carrito.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      size: 100,
                      color: Colors.black12,
                    ),
                    Text(
                      "Carrito vacío",
                      style: TextStyle(fontSize: 30, color: Colors.black12),
                    )
                  ],
                ),
              )
            : SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Row(children: [
                                const Text(
                                  "Cantidad: ",
                                ),
                                Text(compra.cantidad.toString()),
                                const Padding(
                                    padding: EdgeInsets.only(left: 20)),
                                IconButton(
                                    onPressed: () {
                                      carritoProvider
                                          .eliminarCarritoPorIndex(index);
                                    },
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red))
                              ]),
                              trailing: Text("\$${compra.subtotal}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          );
                        },
                      )),
                      const SizedBox(height: 20),
                      const Text(
                        "Total",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text("\$${carritoProvider.total}",
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () {
                            if (carritoProvider.carrito.isNotEmpty) {
                              Navigator.pushNamed(context, '/confirmarCompra');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.black12,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Comprar",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                          ))
                    ],
                  ),
                ),
              ));
  }
}
