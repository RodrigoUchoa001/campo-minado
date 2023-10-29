import 'package:campo_minado_flutter/db/db_metodos.dart';
import 'package:campo_minado_flutter/models/campo_minado.dart';
import 'package:campo_minado_flutter/ui/screens/tela_de_escolha_de_dificuldade.dart';
import 'package:campo_minado_flutter/utils/formatar_tempo_decorrido.dart';
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
          ? 'Você Venceu! \n Seu tempo foi: ${formatarTempoDecorrido(campoMinado.cronometro.elapsedTime)}'
          : 'Você Perdeu!'),
      actions: [
        if (vitoria)
          Column(
            children: [
              const Text('Digite seu nome para armazenar a pontuação:'),
              TextField(
                onChanged: (text) {
                  nomeDoJogador = text;
                },
              ),
              TextButton(
                onPressed: () {
                  final DBMetodos db = DBMetodos();
                  db.armazenarNovaVitoria(nomeDoJogador, campoMinado);

                  //mostrar msg de vitoria armazenada
                  final snackBar = SnackBar(
                    content: Text('Vitória de $nomeDoJogador armazenada'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  //volta para tela de escolha de dificuldade para jogar novamente
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const TelaDeEscolhaDeDificuldade(),
                    ),
                    ModalRoute.withName('/'),
                  );
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        if (!vitoria)
          TextButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const TelaDeEscolhaDeDificuldade(),
                ),
                ModalRoute.withName('/'),
              );
            },
            child: const Text('Jogar novamente'),
          ),
      ],
    );
  }
}
