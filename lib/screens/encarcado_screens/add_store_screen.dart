import 'package:delibery_app/screens/encarcado_screens/encargado_componentes/drawer_encargado.dart';
import 'package:delibery_app/screens/componentes/formularios/tiendas_forms/form_add_store.dart';
import 'package:flutter/material.dart';

class AddStore extends StatefulWidget {
  const AddStore({super.key});

  @override
  State<AddStore> createState() => _AddStoreState();
}

class _AddStoreState extends State<AddStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerEncargado(),
      appBar: AppBar(
        title: const Text('Agregar tienda'),
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: ListView(
          children: [
            const Padding(padding: EdgeInsets.all(10)),
            Title(
              color: Colors.black,
              child: const Text(
                "Agregar tienda",
                style: TextStyle(fontSize: 25),
              ),
            ),
            const FormAddStore(),
          ],
        ),
      ),
    );
  }
}
