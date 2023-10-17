import 'package:campo_minado_flutter/ui/screens/tela_de_escolha_de_dificuldade.dart';
import 'package:campo_minado_flutter/ui/widgets/botao_padrao.dart';
import 'package:flutter/material.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Campo Minado",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            BotaoPadrao(
              titulo: 'Jogar',
              apertar: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => const TelaDeEscolhaDeDificuldade()),
                );
              },
            ),
            BotaoPadrao(
              titulo: 'Ver Pontuação',
              apertar: () {},
            )
          ],
        ),
      ),
    );
  }
}
