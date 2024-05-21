import 'package:flutter/material.dart';

class Titulos extends StatelessWidget {
  const Titulos({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Title(
            color: Colors.black,
            title: "Documentos",
            child: Text(
              title,
              style: const TextStyle(fontSize: 20, shadows: [
                Shadow(
                    color: Color.fromARGB(255, 87, 86, 86),
                    offset: Offset(1, 1),
                    blurRadius: 1)
              ]),
            )));
  }
}
