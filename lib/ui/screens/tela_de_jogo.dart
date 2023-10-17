import 'package:campo_minado_flutter/exceptions/dificuldade_escolhida_invalidada_excepcion.dart';
import 'package:campo_minado_flutter/models/campo_minado.dart';
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
                          //TODO: n deixar clicar de novo caso ja tenha descoberto, TRATAR EXCECOES
                          zona.descobrirZona();
                        });
                      },
                      onLongPress: () {
                        setState(() {
                          if (zona.status == 1) {
                            zona.removerBandeira();
                          } else {
                            zona.colocarBandeira();
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
