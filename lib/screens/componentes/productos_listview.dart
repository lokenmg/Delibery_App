import 'package:delibery_app/entidades/modelos/models/apiModels/producto_model_id.dart';
import 'package:delibery_app/entidades/modelos/models/datosPrueba/productos_datos.dart';
import 'package:flutter/material.dart';

class ProductosListView extends StatefulWidget {
  const ProductosListView({super.key});

  @override
  State<ProductosListView> createState() => _ProductosListViewState();
}

List<ProductoModelId> productos = ProductosDatos().productos();

class _ProductosListViewState extends State<ProductosListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: productos.map((producto) {
        return ListTile(
          tileColor: Colors.grey[200],
          leading: Image.network(
            producto.imagen,
            width: 100,
          ),
          title: Text(producto.nombre),
          subtitle: Text(producto.descripcion),
          trailing: Text("\$${producto.precio.toString()}"),
          onTap: () {
            Navigator.pushNamed(context, '/producto', arguments: producto);
          },
        );
      }).toList(),
    );
  }
}
