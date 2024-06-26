import 'package:delibery_app/entidades/modelos/models/apiModels/info_basica_model.dart';
import 'package:delibery_app/services/delivery_service.dart';
import 'package:delibery_app/services/token_services.dart';
import 'package:flutter/material.dart';

class DrawerEncargado extends StatefulWidget {
  const DrawerEncargado({super.key});

  @override
  State<DrawerEncargado> createState() => _DrawerEncargadoState();
}

class _DrawerEncargadoState extends State<DrawerEncargado> {
  InfoBasicaModel? infoBasicaModel;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    getInfoBasicas();
  }

  void getInfoBasicas() async {
    try {
      var response = await DeliveryService().getEncargadoInfo();
      setState(() {
        infoBasicaModel = InfoBasicaModel.fromJson(response);
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = "Error al cargar la información";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: isLoading
                ? const Text('cargando...')
                : Text(infoBasicaModel?.nombre ?? 'Nombre no disponible'),
            accountEmail: isLoading
                ? const Text('cargando...')
                : Text(infoBasicaModel?.email ?? 'Email no disponible'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                infoBasicaModel?.urlFoto ??
                    'https://firebasestorage.googleapis.com/v0/b/delibery-flutter.appspot.com/o/sistema%2Fblank-avatar-photo-place-holder-600nw-1095249842.webp?alt=media&token=67655cf0-d514-4e8b-94ac-07e0233ade2c',
              ),
            ),
          ),
          if (errorMessage != null) ...[
            ListTile(
              title: Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
          ListTile(
            leading: const Icon(Icons.add_business_rounded),
            title: const Text('Agregar tienda'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/AddStore');
            },
          ),
          ListTile(
            leading: const Icon(Icons.store_rounded),
            title: const Text('mi tienda'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/tienda');
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_rounded),
            title: const Text('Agregar producto'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/AddProduct');
            },
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Perfil'),
            onTap: () {
              //agregar vista de perfil
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              await TokenServices.removeToken();
              navigator();
            },
          ),
        ],
      ),
    );
  }

  void navigator() {
    Navigator.pushReplacementNamed(context, "/login");
  }
}
