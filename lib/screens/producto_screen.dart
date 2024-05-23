import 'package:delibery_app/modelos/models/apiModels/producto_model_id.dart';
import 'package:delibery_app/modelos/models/carrito.dart';
import 'package:delibery_app/modelos/models/providers/carrito_compras_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductoScreen extends StatefulWidget {
  const ProductoScreen({super.key});

  @override
  State<ProductoScreen> createState() => _ProductoScreenState();
}

class _ProductoScreenState extends State<ProductoScreen> {
  int total = 0;
  int contador = 0;
  @override
  Widget build(BuildContext context) {
    final ProductoModelId argument =
        ModalRoute.of(context)?.settings.arguments as ProductoModelId;
    return Scaffold(
        appBar: AppBar(
          title: Text(argument.nombre),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Image.network(
              argument.imagen,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              argument.nombre,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              argument.descripcion,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Precio ${argument.precio.toString()}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            argument.descuento > 0
                ? Text(
                    'Descuento \$${argument.descuento}',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  )
                : const SizedBox(),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        (contador < 1) ? null : contador--;
                        (argument.descuento != 0)
                            ? total = (contador *
                                argument.precio /** (argument.descuento/100)*/)
                            : total = (contador * argument.precio);
                      });
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  Text(contador.toString()),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        contador++;
                        (argument.descuento != 0)
                            ? total = (contador *
                                argument.precio /** (argument.descuento/100)*/)
                            : total = (contador * argument.precio);
                      });
                    },
                    icon: const Icon(Icons.add),
                  ),
                  Text("Total: \$$total")
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Provider.of<CarritoComprasProvider>(context, listen: false)
                      .agregarCarrito(CarritoModel(
                          cantidad: contador == 0 ? 1 : contador,
                          producto: argument,
                          subtotal: contador == 0 ? argument.precio : total));
                },
                child: const Text('Agregar al carrito')),
            ElevatedButton(onPressed: () {}, child: const Text("comprar ahora"))
          ]),
        ));
  }
}

class NombreProducto extends StatelessWidget {
  const NombreProducto({
    super.key,
    required this.nombre,
  });

  final String nombre;

  @override
  Widget build(BuildContext context) {
    return Text(nombre);
  }
}
