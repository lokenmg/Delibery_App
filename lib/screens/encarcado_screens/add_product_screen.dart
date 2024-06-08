import 'package:delibery_app/screens/componentes/formularios/tiendas_forms/add_product_form.dart';
import 'package:delibery_app/screens/index.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerEncargado(),
      appBar: AppBar(
        title: const Text('Agregar producto'),
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: ListView(
          children: [
            const Padding(padding: EdgeInsets.all(10)),
            Title(
              color: Colors.black,
              child: const Text(
                "Agregar producto",
                style: TextStyle(fontSize: 25),
              ),
            ),
            const AddProductForm(),
          ],
        ),
      ),
    );
  }
}
