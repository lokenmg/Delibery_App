import 'package:delibery_app/entidades/modelos/models/apiModels/producto_model_id.dart';
import 'package:delibery_app/services/delivery_service.dart';
import 'package:flutter/material.dart';

class ModificarProductoScreen extends StatefulWidget {
  const ModificarProductoScreen({
    super.key,
  });

  @override
  State<ModificarProductoScreen> createState() =>
      _ModificarProductoScreenState();
}

class _ModificarProductoScreenState extends State<ModificarProductoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int argument = ModalRoute.of(context)?.settings.arguments as int;
    return FutureBuilder(
      future: DeliveryService().getProductoById(argument),
      builder: (BuildContext context, AsyncSnapshot<ProductoModelId> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Text('Producto: ${snapshot.data!.nombre}');
        }
      },
    );
  }
}
