import 'package:delibery_app/screens/encarcado_screens/encargado_componentes/drawer_encargado.dart';
import 'package:delibery_app/screens/encarcado_screens/encargado_componentes/listview_productos_tienda.dart';
import 'package:delibery_app/services/token_services.dart';
import 'package:flutter/material.dart';

class HomeEncargadoScreen extends StatefulWidget {
  const HomeEncargadoScreen({super.key});

  @override
  State<HomeEncargadoScreen> createState() => _HomeEncargadoScreenState();
}

class _HomeEncargadoScreenState extends State<HomeEncargadoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerEncargado(),
      appBar: AppBar(
        title: const Text('Delibery App'),
        actions: <Widget>[],
      ),
      body: const ProductosTiendaListview(),
    );
  }
}
