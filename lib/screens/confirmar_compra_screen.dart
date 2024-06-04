import 'package:delibery_app/entidades/modelos/models/apiModels/cliente_model.dart';
import 'package:delibery_app/entidades/modelos/models/apiModels/cliente_model_id.dart';
import 'package:delibery_app/entidades/modelos/models/providers/carrito_compras_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmarCompraScreen extends StatefulWidget {
  const ConfirmarCompraScreen({super.key});

  @override
  State<ConfirmarCompraScreen> createState() => _ConfirmarCompraScreenState();
}

class _ConfirmarCompraScreenState extends State<ConfirmarCompraScreen> {
  // almacenar con provider
  ClienteModelId cliente = ClienteModelId(
      id: 1,
      nombre: "nombre",
      fechaNacimiento: "fechaNacimiento",
      email: "email",
      telefono: "telefono",
      urlFoto: "urlFoto",
      idGenero: 1,
      direccion: Direccion(
          calle1: "calle1",
          calle2: "calle2",
          calle3: "calle3",
          colonia: "colonia",
          cp: 12345,
          estado: "estado",
          municipio: "municipio",
          numeroExterior: "1",
          numeroInterior: "1",
          referencia: "referencia"),
      password: "password");

  @override
  Widget build(BuildContext context) {
    final carritoProvider = context.watch<CarritoComprasProvider>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Confirmar compra'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                const Text("Direccion"),
                Text(
                    "${cliente.direccion.calle1} ${cliente.direccion.calle2} ${cliente.direccion.calle3}, N° ${cliente.direccion.numeroExterior}, exterior ${cliente.direccion.numeroInterior}, ${cliente.direccion.municipio}, ${cliente.direccion.colonia}, ${cliente.direccion.estado}"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 20,
                      padding: const EdgeInsets.fromLTRB(2, 5, 10, 5),
                      child: const Text("Cantidad"),
                    ),
                    Container(
                      height: 20,
                      padding: const EdgeInsets.fromLTRB(3, 5, 30, 5),
                      child: const Text("Producto"),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(90, 5, 10, 5),
                      child: const Text("Subtotal"),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.all(4)),
                Expanded(
                    child: ListView.builder(
                  itemCount: carritoProvider.carrito.length,
                  itemBuilder: (context, index) {
                    final producto = carritoProvider.carrito[index];

                    return ListTile(
                      leading: Text(
                        producto.cantidad.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      title: Text(
                        producto.producto!.nombre,
                        style: const TextStyle(fontSize: 17.5),
                      ),
                      trailing: (Text(producto.subtotal.toString())),
                    );
                  },
                )),
                const Text(
                  "total",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
                Text("\$${carritoProvider.total}"),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/metodoPago');
                    },
                    style: const ButtonStyle(
                        shadowColor: MaterialStatePropertyAll(Colors.black12)),
                    child: const Text("Método de pago",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )))
              ],
            ),
          ),
        ));
  }
  // numero de folio 58046116
}
