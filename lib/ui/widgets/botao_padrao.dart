import 'package:flutter/material.dart';

class BotaoPadrao extends StatelessWidget {
  final String titulo;
  final Function apertar;
  const BotaoPadrao({super.key, required this.titulo, required this.apertar});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          apertar();
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(20),
          textStyle: const TextStyle(fontSize: 20),
          fixedSize: Size(width - 24, 56),
        ),
        child: Text(titulo),
      ),
    );
  }
}
