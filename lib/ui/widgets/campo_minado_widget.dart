import 'package:campo_minado_flutter/exceptions/bandeira_em_zona_descoberta_exception.dart';
import 'package:campo_minado_flutter/exceptions/descobrir_zona_com_bandeira_exception.dart';
import 'package:campo_minado_flutter/models/campo_minado.dart';
import 'package:campo_minado_flutter/ui/widgets/dialog_de_fim_de_jogo.dart';
import 'package:campo_minado_flutter/ui/widgets/zona_widget.dart';
import 'package:flutter/material.dart';

class CampoMinadoWidget extends StatefulWidget {
  final CampoMinado campoMinado;
  const CampoMinadoWidget({super.key, required this.campoMinado});

  @override
  State<CampoMinadoWidget> createState() => _CampoMinadoWidgetState();
}

class _CampoMinadoWidgetState extends State<CampoMinadoWidget> {
  void mostrarMsgDeFimDeJogo(bool vitoria) {
    widget.campoMinado.cronometro.stop(); // Pare o cronômetro

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return DialogDeFimDeJogo(
            campoMinado: widget.campoMinado, vitoria: vitoria);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      // TODO: fazer o interactive viewer pegar a tela toda
      panEnabled: false, // Set it to false to prevent panning.
      boundaryMargin: const EdgeInsets.all(double.infinity),
      minScale: 1.0,
      maxScale: 3.0,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.campoMinado.tabuleiro[0].length,
        ),
        itemCount: widget.campoMinado.tabuleiro.length *
            widget.campoMinado.tabuleiro[0].length,
        itemBuilder: (context, index) {
          final row = index ~/ widget.campoMinado.tabuleiro[0].length;
          final col = index % widget.campoMinado.tabuleiro[0].length;
          final zona = widget.campoMinado.tabuleiro[row][col];

          return GestureDetector(
            onTap: () {
              setState(() {
                try {
                  if (zona.status == 0) {
                    if (zona.temBomba) {
                      widget.campoMinado.descobrirZona(row, col);
                      mostrarMsgDeFimDeJogo(false);
                    } else {
                      widget.campoMinado.descobrirZonasAdjacentes(row, col);
                      if (!widget.campoMinado.jogoEmAndamento) {
                        mostrarMsgDeFimDeJogo(widget.campoMinado.vitoria);
                      }
                    }
                  }
                } on DescobrirZonaComBandeiraException catch (e) {
                  final snackBar = SnackBar(
                    content: Text(e.toString()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

                if (!widget.campoMinado.jogoEmAndamento) {
                  for (int i = 0;
                      i < widget.campoMinado.tabuleiro.length;
                      i++) {
                    for (int j = 0;
                        j < widget.campoMinado.tabuleiro[i].length;
                        j++) {
                      if (widget.campoMinado.tabuleiro[i][j].temBomba) {
                        widget.campoMinado.tabuleiro[i][j]
                            .forcarDescobrirZona();
                      }
                    }
                  }
                  mostrarMsgDeFimDeJogo(widget.campoMinado.vitoria);
                }
              });
            },
            onLongPress: () {
              setState(() {
                if (zona.status == 1) {
                  try {
                    widget.campoMinado.removerBandeira(row, col);
                  } on BandeiraEmZonaDescobertaException catch (e) {
                    final snackBar = SnackBar(
                      content: Text(e.toString()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                } else {
                  try {
                    widget.campoMinado.colocarBandeira(row, col);
                  } on Exception catch (e) {
                    final snackBar = SnackBar(
                      content: Text(e.toString()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
              });
            },
            child: ZonaWidget(zona: zona, venceu: widget.campoMinado.vitoria),
          );
        },
      ),
    );
  }
}
