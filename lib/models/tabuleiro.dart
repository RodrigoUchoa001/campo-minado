import 'package:campo_minado_flutter/models/zona.dart';

/// representa o tabuleiro do campo minado
class Tabuleiro {
  late List<List<Zona>> tabuleiro;

  /// 1 = facil = 8x8
  /// 2 = medio = 10x16
  /// 3 = dificil = 24x24
  Tabuleiro(int dificuldade) {
    if (dificuldade == 1) {
      criaTabuleiro(8, 8);
    } else if (dificuldade == 2) {
      criaTabuleiro(10, 16);
    } else if (dificuldade == 3) {
      criaTabuleiro(24, 24);
    }
  }

  void criaTabuleiro(int x, int y) {
    for (int i = 0; i < x; i++) {
      for (int j = 0; j < y; j++) {
        tabuleiro[x][y] = Zona();
      }
    }
  }
}
