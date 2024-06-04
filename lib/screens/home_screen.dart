import 'package:delibery_app/screens/componentes/productos_listview.dart';
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
        )
      ]),
      body: const Center(
        child: ProductosListView(),
      ),
    );
  }
}
