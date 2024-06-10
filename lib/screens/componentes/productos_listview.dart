import 'package:flutter/material.dart';
import 'package:delibery_app/services/delivery_service.dart';
import 'package:delibery_app/entidades/modelos/models/apiModels/producto_model_id.dart';

class ProductosListView extends StatefulWidget {
  const ProductosListView({super.key});

  @override
  State<ProductosListView> createState() => _ProductosListViewState();
}

class _ProductosListViewState extends State<ProductosListView> {
  List<ProductoModelId> productos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    cargarProductos();
  }

  void cargarProductos() async {
    try {
      List<ProductoModelId> fetchedProductos =
          await DeliveryService().getProductos();
      setState(() {
        productos = fetchedProductos;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : productos.isEmpty
            ? const Center(child: Text("No hay productos disponibles"))
            : ListView.builder(
                itemCount: productos.length,
                itemBuilder: (context, index) {
                  ProductoModelId producto = productos[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        leading: Image.network(
                          producto.imagen,
                          width: 90,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return const Icon(Icons
                                .error); // Mostrar un ícono de error si la imagen no se carga
                          },
                        ),
                        title: Text(producto.nombre),
                        subtitle: Text(producto.descripcion),
                        trailing: Text(
                          "\$${producto.precio.toString()}",
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/producto',
                              arguments: producto);
                        },
                      ),
                    ),
                  );
                },
              );
  }
}
