import 'package:campo_minado_flutter/models/campo_minado.dart';
import 'package:campo_minado_flutter/ui/screens/tela_de_escolha_de_dificuldade.dart';
import 'package:flutter/material.dart';

class DialogDeFimDeJogo extends StatelessWidget {
  final CampoMinado campoMinado;
  final bool vitoria;
  const DialogDeFimDeJogo(
      {super.key, required this.campoMinado, required this.vitoria});

  @override
  Widget build(BuildContext context) {
    String nomeDoJogador = '';

    return AlertDialog(
      title: Text(vitoria
          ? 'Você Venceu! \n Digite seu nome para armazenar a pontuação:'
          : 'Você Perdeu!'),
      actions: [
        if (vitoria)
          Column(
            children: [
              TextField(
                onChanged: (text) {
                  nomeDoJogador = text;
                },
              ),
              TextButton(
                onPressed: () {
                  campoMinado.armazenarNovaVitoria(
                      nomeDoJogador,
                      campoMinado.cronometro.elapsedTime,
                      campoMinado.dificuldade);

                  //mostrar msg de vitoria armazenada
                  const snackBar = SnackBar(
                    content: Text('vitória armazenada'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  //volta para tela de escolha de dificuldade para jogar novamente
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => const TelaDeEscolhaDeDificuldade()),
                  );
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        if (!vitoria)
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => const TelaDeEscolhaDeDificuldade()),
              );
            },
            child: const Text('Jogar novamente'),
          ),
      ],
    );
  }
}
