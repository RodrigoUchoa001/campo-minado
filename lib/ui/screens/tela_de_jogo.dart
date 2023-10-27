import 'package:campo_minado_flutter/exceptions/dificuldade_escolhida_invalidada_excepcion.dart';
import 'package:campo_minado_flutter/models/campo_minado.dart';
import 'package:campo_minado_flutter/ui/widgets/campo_minado_widget.dart';
import 'package:flutter/material.dart';

class TelaDeJogo extends StatefulWidget {
  final int dificuldade;
  const TelaDeJogo({super.key, required this.dificuldade});

  @override
  State<TelaDeJogo> createState() => _TelaDeJogoState();
}

class _TelaDeJogoState extends State<TelaDeJogo> {
  late CampoMinado campoMinado;
  bool taPausado = false;

  @override
  void initState() {
    super.initState();
    campoMinado = CampoMinado(widget.dificuldade);
    campoMinado.cronometro.elapsedTimeStream.listen((elapsedTime) {
      setState(
          () {}); // Atualize a interface do usuário quando o stream notificar mudanças
    });
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

  void pausarJogo() {
    if (campoMinado.jogoEmAndamento) {
      setState(() {
        campoMinado.cronometro.stop();
        taPausado = true;
      });
      showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.white,
        builder: (context) {
          return AlertDialog(
            title: const Text("Jogo pausado"),
            content: Text(
                'Tempo decorrido: ${campoMinado.cronometro.elapsedTime.inMinutes.remainder(60).toString().padLeft(2, '0')}:${campoMinado.cronometro.elapsedTime.inSeconds.remainder(60).toString().padLeft(2, '0')}'),
            actions: [
              TextButton(
                onPressed: () {
                  despausarJogo();
                  Navigator.of(context).pop();
                },
                child: const Text('Despausar'),
              ),
            ],
          );
        },
      );
    }
  }

  void despausarJogo() {
    setState(() {
      campoMinado.cronometro.start();
      taPausado = false;
    });
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getNomeDaDificuldade(campoMinado.dificuldade),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            pausarJogo();
                          },
                          icon: const Icon(Icons.pause, size: 36))
                    ],
                  ),
                ),
                !campoMinado.jogoEmAndamento
                    ? const Text(
                        'o jogo acabou!',
                        style: TextStyle(color: Colors.red),
                      )
                    : Container(),
                const SizedBox(height: 24),
                StreamBuilder<Duration>(
                  stream: campoMinado.cronometro.elapsedTimeStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      final elapsed = snapshot.data;
                      return Text(
                        '${elapsed?.inMinutes.remainder(60).toString().padLeft(2, '0')}:${elapsed?.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                        style: const TextStyle(fontSize: 48.0),
                      );
                    } else {
                      return const Text(
                        '00:00',
                        style: TextStyle(fontSize: 48.0),
                      );
                    }
                  },
                ),
                CampoMinadoWidget(campoMinado: campoMinado),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
