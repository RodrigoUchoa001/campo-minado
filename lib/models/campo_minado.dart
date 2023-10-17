import 'dart:math';

import 'package:campo_minado_flutter/exceptions/dificuldade_escolhida_invalidada_excepcion.dart';
import 'package:campo_minado_flutter/models/zona.dart';

/// representa o tabuleiro do campo minado
class CampoMinado {
  late List<List<Zona>> tabuleiro;
  late int _dificuldade;

  int get dificuldade => _dificuldade;

  /// 1 = facil = 8x8
  /// 2 = medio = 10x16
  /// 3 = dificil = 24x24
  CampoMinado(int dificuldade) {
    _dificuldade = dificuldade;

    if (dificuldade == 1) {
      tabuleiro = List.generate(
        8,
        (row) => List.generate(
          8,
          (col) => Zona(),
        ),
      );
      preencherComBombas(10);
    } else if (dificuldade == 2) {
      tabuleiro = List.generate(
        10,
        (row) => List.generate(
          16,
          (col) => Zona(),
        ),
      );
      preencherComBombas(30);
    } else if (dificuldade == 3) {
      tabuleiro = List.generate(
        24,
        (row) => List.generate(
          24,
          (col) => Zona(),
        ),
      );
      preencherComBombas(100);
    } else {
      throw DificuldadeEscolhidaInvalidaException(
          'A dificuldade escolhida é invalida');
    }
  }
  void preencherComBombas(int numBombas) {
    final random = Random();
    int bombasColocadas = 0;

    while (bombasColocadas < numBombas) {
      final row = random.nextInt(tabuleiro.length);
      final col = random.nextInt(tabuleiro[0].length);

      if (!tabuleiro[row][col].temBomba) {
        tabuleiro[row][col].temBomba = true;
        bombasColocadas++;
      }
    }
  }
}
