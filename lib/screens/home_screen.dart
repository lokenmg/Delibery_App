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
      appBar: AppBar(
        title: const Text('Delibery App'),
      ),
      body: const Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
