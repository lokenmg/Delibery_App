import 'package:flutter/material.dart';

class LogoComponent extends StatelessWidget {
  const LogoComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Image(
          image: NetworkImage(
              "https://firebasestorage.googleapis.com/v0/b/delibery-flutter.appspot.com/o/sistema%2FDEMIXO_jpg-removebg-preview.png?alt=media&token=e2823295-144a-4059-8e60-3b9346976220"),
          width: 190,
          height: 190,
        ),
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("DEMIXO",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall)),
      ],
    );
  }
}
