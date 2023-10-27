import 'package:campo_minado_flutter/ui/screens/tela_de_escolha_de_dificuldade.dart';
import 'package:campo_minado_flutter/ui/screens/tela_inicial.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campo Minado',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      // home: const TelaInicial(),
      initialRoute: '/',
      // home: const TelaDeJogo(dificuldade: 1),
      routes: {
        '/': (context) => const TelaInicial(),
        '/tela-de-escolha-de-dificuldade': (context) =>
            const TelaDeEscolhaDeDificuldade(),
      },
    );
  }
}
