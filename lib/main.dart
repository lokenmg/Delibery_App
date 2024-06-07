import 'package:delibery_app/config/theme/app_theme.dart';
import 'package:delibery_app/entidades/modelos/models/providers/carrito_compras_provider.dart';
import 'package:delibery_app/entidades/modelos/models/providers/info_login_provider.dart';
import 'package:delibery_app/screens/index.dart';

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => CarritoComprasProvider()),
    ChangeNotifierProvider(create: (context) => InfoLoginProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  final _routes = {
    "/login": (context) => const Login(),
    "/registro": (context) => const Registro(),
    "/home": (context) => const HomeScreen(),
    "/AddStore": (context) => const AddStore(),
    "/AddProduct": (context) => const AddProductScreen(),
    "/producto": (context) => const ProductoScreen(),
    "/carrito": (context) => const CarritoComprasScreen(),
    "/confirmarCompra": (context) => const ConfirmarCompraScreen(),
    "/metodoPago": (context) => const MetodoPago(),
    "/tienda": (context) => const TiendaScreen(),
  };
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DEMIX',
      initialRoute: "/login",
      routes: _routes,
      theme: AppTheme(selectedTheme: 2).theme(),
    );
  }
}
