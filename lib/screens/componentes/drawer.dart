import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menú',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.store_rounded),
            title: const Text('Agregar tienda'),
            onTap: () {
              // Acción para navegar a la pantalla de inicio
              Navigator.pop(context);
              Navigator.pushNamed(context, '/AddStore');
            },
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              // Acción para navegar a la pantalla de inicio
              Navigator.pop(context); // Cierra el drawer
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Perfil'),
            onTap: () {
              // Acción para navegar a la pantalla de perfil
              Navigator.pop(context); // Cierra el drawer
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            onTap: () {
              // Acción para navegar a la pantalla de configuración
              Navigator.pop(context); // Cierra el drawer
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
    );
  }
}
