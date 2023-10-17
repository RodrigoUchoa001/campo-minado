import 'package:campo_minado_flutter/ui/widgets/botao_padrao.dart';
import 'package:flutter/material.dart';

class TelaDeEscolhaDeDificuldade extends StatelessWidget {
  const TelaDeEscolhaDeDificuldade({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Escolha o nível de dificuldade",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            BotaoPadrao(titulo: 'Fácil', apertar: () {}),
            BotaoPadrao(titulo: 'Intermidiário', apertar: () {}),
            BotaoPadrao(titulo: 'Difícil', apertar: () {}),
          ],
        ),
      ),
    );
  }
}
