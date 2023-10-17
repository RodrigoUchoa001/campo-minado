import 'package:campo_minado_flutter/models/campo_minado.dart';
import 'package:campo_minado_flutter/models/zona.dart';
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
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getNomeDaDificuldade(campoMinado.dificuldade),
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: _getZonaColor(zona),
                      ),
                      child: Center(
                        child: _getZonaIcon(zona),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getZonaColor(Zona zona) {
    if (zona.status == 0) {
      return Colors.grey; // Zona não descoberta.
    } else if (zona.status == 1) {
      return Colors.blue; // Zona com bandeira.
    } else {
      return Colors.white; // Zona descoberta.
    }
  }

  Widget _getZonaIcon(Zona zona) {
    if (zona.status == 2) {
      if (zona.temBomba) {
        return const Icon(Icons.zoom_out_map, color: Colors.black, size: 24);
      } else {
        return Text(
          zona.bombasAdjacentes > 0 ? zona.bombasAdjacentes.toString() : '',
          style: const TextStyle(fontSize: 20),
        );
      }
    } else if (zona.status == 1) {
      return const Icon(Icons.flag, color: Colors.black, size: 24);
    } else {
      return Container();
    }
  }
}
