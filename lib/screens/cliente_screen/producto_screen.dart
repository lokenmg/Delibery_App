import 'package:delibery_app/entidades/modelos/models/apiModels/producto_model_id.dart';
import 'package:delibery_app/entidades/modelos/models/carrito.dart';
import 'package:delibery_app/entidades/modelos/models/providers/carrito_compras_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductoScreen extends StatefulWidget {
  const ProductoScreen({super.key});

  @override
  State<ProductoScreen> createState() => _ProductoScreenState();
}

class _ProductoScreenState extends State<ProductoScreen> {
  double total = 0;
  int contador = 0;
  @override
  Widget build(
    BuildContext context,
  ) {
    final ProductoModelId argument =
        ModalRoute.of(context)?.settings.arguments as ProductoModelId;
    return Scaffold(
        appBar: AppBar(
          title: Text(argument.nombre),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Image.network(
                argument.imagen,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Text(
                argument.nombre,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              argument.categoriasId.isNotEmpty
                  ? Text(
                      'Categorías: ${argument.categoriasId.join(', ')}',
                      style: const TextStyle(fontSize: 16),
                    )
                  : const SizedBox(),
              const SizedBox(height: 8),
              Text(
                argument.descripcion,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Precio ${argument.precio.toString()}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              argument.descuento > 0
                  ? Text(
                      'Descuento ${argument.descuento}%',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    )
                  : const SizedBox(),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        (contador < 1) ? null : contador--;
                        (argument.descuento != 0)
                            ? total = (contador *
                                (argument.precio -
                                    ((argument.precio * argument.descuento) /
                                        100)))
                            : total = (contador * argument.precio);
                      });
                    },
                    icon: const Icon(Icons.remove),
                    color: Colors.red,
                  ),
                  Text(
                    contador.toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        contador++;
                        total = (contador *
                            (argument.precio -
                                ((argument.precio * argument.descuento) /
                                    100)));
                      });
                    },
                    icon: const Icon(Icons.add),
                    color: Colors.green,
                  ),
                  Text(
                    "Total: \$$total",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  onPressed: () {
                    Provider.of<CarritoComprasProvider>(context, listen: false)
                        .agregarCarrito(CarritoModel(
                            cantidad: contador == 0 ? 1 : contador,
                            producto: argument,
                            subtotal: contador == 0 ? argument.precio : total));
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Agregar al carrito'),
                  )),
            ],
          ),
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
