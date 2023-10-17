import 'package:campo_minado_flutter/ui/screens/tela_de_jogo.dart';
import 'package:campo_minado_flutter/ui/widgets/botao_padrao.dart';
import 'package:flutter/material.dart';

class TelaDeEscolhaDeDificuldade extends StatelessWidget {
  const TelaDeEscolhaDeDificuldade({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Escolha o nível de dificuldade",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              BotaoPadrao(
                  titulo: 'Fácil',
                  apertar: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const TelaDeJogo(dificuldade: 1)),
                    );
                  }),
              BotaoPadrao(
                  titulo: 'Intermediário',
                  apertar: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const TelaDeJogo(dificuldade: 2)),
                    );
                  }),
              BotaoPadrao(
                  titulo: 'Difícil',
                  apertar: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const TelaDeJogo(dificuldade: 3)),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
