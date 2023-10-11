import 'package:campo_minado_flutter/models/zona.dart';

/// representa o tabuleiro do campo minado
class Tabuleiro {
  late List<List<Zona>> tabuleiro;

  /// 1 = facil = 8x8
  /// 2 = medio = 10x16
  /// 3 = dificil = 24x24
  Tabuleiro(int dificuldade) {
    // if (dificuldade == 1) {
    //   criaTabuleiro(8, 8);
    // } else if (dificuldade == 2) {
    //   criaTabuleiro(10, 16);
    // } else if (dificuldade == 3) {
    //   criaTabuleiro(24, 24);
    // }
    if (dificuldade == 1) {
      tabuleiro = List.generate(
        8,
        (row) => List.generate(
          8,
          (col) => Zona(),
        ),
      );
    } else if (dificuldade == 2) {
      tabuleiro = List.generate(
        10,
        (row) => List.generate(
          16,
          (col) => Zona(),
        ),
      );
    } else if (dificuldade == 3) {
      tabuleiro = List.generate(
        24,
        (row) => List.generate(
          24,
          (col) => Zona(),
        ),
      );
    }
  }
}
