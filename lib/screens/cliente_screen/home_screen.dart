import 'package:delibery_app/screens/cliente_screen/componentes/cliente_drawer.dart';
import 'package:delibery_app/screens/componentes/productos_listview.dart';
import 'package:delibery_app/services/token_services.dart';
import 'package:flutter/material.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerCliente(),
      appBar: AppBar(title: const Text('Delibery App'), actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.shopping_cart,
            semanticLabel: "Carrito de compras",
          ),
          onPressed: () {
            Navigator.pushNamed(context, "/carrito");
          },
        ),
      ]),
      body: const Center(
        child: ProductosListView(),
      ),
    );
  }

  Future<String> getMyToken() async {
    String? token = await TokenServices.getToken();
    if (token != null) {
      return token;
    } else {
      return "No hay token";
    }
  }
}
