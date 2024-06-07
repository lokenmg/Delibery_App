import 'package:delibery_app/screens/componentes/productos_listview.dart';
import 'package:delibery_app/services/token_services.dart';
import 'package:flutter/material.dart';

import 'componentes/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
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
        IconButton(
          icon: const Icon(
            Icons.logout,
            semanticLabel: "Cerrar sesión",
          ),
          onPressed: () async {
            await TokenServices.removeToken();
            Navigator.pushNamed(context, "/login");
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
