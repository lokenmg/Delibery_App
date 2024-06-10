import 'package:delibery_app/entidades/modelos/models/apiModels/producto_model_id.dart';
import 'package:delibery_app/services/delivery_service.dart';
import 'package:flutter/material.dart';

class ProductosTiendaListview extends StatefulWidget {
  const ProductosTiendaListview({super.key});

  @override
  State<ProductosTiendaListview> createState() =>
      _ProductosTiendaListviewState();
}

bool exist = false;
int? storeId;

class _ProductosTiendaListviewState extends State<ProductosTiendaListview> {
  List<ProductoModelId> productos = [];
  bool isLoading = true;
  void getStore() {
    final deliveryService = DeliveryService();
    deliveryService.getStore().then((value) {
      if (value['status'] != 500) {
        setState(() {
          storeId = value['idTienda'];
          getProducts();
          exist = true;
        });
      }
    });
  }

  void getProducts() async {
    try {
      List<ProductoModelId> fetchedProductos =
          await DeliveryService().getProductosByTienda(storeId!);
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
  void initState() {
    super.initState();
    getStore();
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
                          Navigator.pushNamed(context, '/actualizarProducto',
                              arguments: producto.id);
                        },
                      ),
                    ),
                  );
                },
              );
  }
}
