import 'package:delibery_app/screens/index.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final _routes = {
    "/login": (context) => Login(),
    "/registro": (context) => Registro(),
  };
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: "/login",
      routes: _routes,
    );
  }
}
