import 'package:delibery_app/screens/cliente_screen/componentes/mis_compras_listview.dart';
import 'package:flutter/material.dart';

class MisComprasScreen extends StatefulWidget {
  const MisComprasScreen({super.key});

  @override
  State<MisComprasScreen> createState() => _MisComprasScreenState();
}

class _MisComprasScreenState extends State<MisComprasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis compras'),
      ),
      body: const MisComprasListView(),
    );
  }
}
