import 'package:delibery_app/screens/index.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _routes = {
    "/login": (context) => const Login(),
    "/registro": (context) => const Registro(),
    "/home": (context) => const HomeScreen(),
    "/AddStore": (context) => const AddStore(),
  };
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: "/login",
      routes: _routes,
    );
  }
}
