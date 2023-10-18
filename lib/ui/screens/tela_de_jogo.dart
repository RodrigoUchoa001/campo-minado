import 'package:campo_minado_flutter/exceptions/bandeira_em_zona_descoberta_exception.dart';
import 'package:campo_minado_flutter/exceptions/descobrir_zona_com_bandeira_exception.dart';
import 'package:campo_minado_flutter/exceptions/dificuldade_escolhida_invalidada_excepcion.dart';
import 'package:campo_minado_flutter/models/campo_minado.dart';
import 'package:campo_minado_flutter/ui/screens/tela_de_escolha_de_dificuldade.dart';
import 'package:campo_minado_flutter/ui/widgets/zona_widget.dart';
import 'package:flutter/material.dart';

class TelaDeJogo extends StatefulWidget {
  final int dificuldade;
  const TelaDeJogo({super.key, required this.dificuldade});

  @override
  State<TelaDeJogo> createState() => _TelaDeJogoState();
}

class _TelaDeJogoState extends State<TelaDeJogo> {
  late CampoMinado campoMinado;

  @override
  void initState() {
    super.initState();
    campoMinado = CampoMinado(widget.dificuldade);
  }

  String getNomeDaDificuldade(int dificuldade) {
    if (dificuldade == 1) {
      return 'Fácil';
    }
    if (dificuldade == 2) {
      return 'Intermédiário';
    }
    if (dificuldade == 3) {
      return 'Difícil';
    }
    throw DificuldadeEscolhidaInvalidaException(
        'Dificuldade escolhida invalida');
  }

  void mostrarMsgDeFimDeJogo(bool vitoria) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(vitoria ? 'Você Venceu!' : 'Você Perdeu!'),
          actions: [
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  getNomeDaDificuldade(campoMinado.dificuldade),
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                !campoMinado.jogoEmAndamento
                    ? const Text(
                        'o jogo acabou!',
                        style: TextStyle(color: Colors.red),
                      )
                    : Container(),
                const SizedBox(height: 24),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: campoMinado.tabuleiro[0].length,
                  ),
                  itemCount: campoMinado.tabuleiro.length *
                      campoMinado.tabuleiro[0].length,
                  itemBuilder: (context, index) {
                    final row = index ~/ campoMinado.tabuleiro[0].length;
                    final col = index % campoMinado.tabuleiro[0].length;
                    final zona = campoMinado.tabuleiro[row][col];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          try {
                            campoMinado.descobrirZona(row, col);
                          } on DescobrirZonaComBandeiraException catch (e) {
                            final snackBar = SnackBar(
                              content: Text(e.toString()),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }

                          if (!campoMinado.jogoEmAndamento) {
                            mostrarMsgDeFimDeJogo(campoMinado.vitoria);
                          }
                        });
                      },
                      onLongPress: () {
                        setState(() {
                          if (zona.status == 1) {
                            campoMinado.removerBandeira(row, col);
                          } else {
                            try {
                              campoMinado.colocarBandeira(row, col);
                            } on BandeiraEmZonaDescobertaException catch (e) {
                              final snackBar = SnackBar(
                                content: Text(e.toString()),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        });
                      },
                      child: ZonaWidget(zona: zona),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
