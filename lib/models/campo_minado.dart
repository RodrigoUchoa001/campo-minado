import 'dart:math';

import 'package:campo_minado_flutter/exceptions/dificuldade_escolhida_invalidada_excepcion.dart';
import 'package:campo_minado_flutter/models/zona.dart';

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
    contarBombasAdjacentes();
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

  List<List<int>> contarBombasAdjacentes() {
    /// matriz que vai armazenar a quantidade de bombas adjacentes de cada
    /// posicao. é usada para realizar testes
    List<List<int>> matrizDeBombasAdjacentes = List.generate(
      tabuleiro.length,
      (row) => List.generate(
        tabuleiro[row].length,
        (col) => 0,
      ),
    );

    for (int i = 0; i < tabuleiro.length; i++) {
      for (int j = 0; j < tabuleiro[i].length; j++) {
        if (!tabuleiro[i][j].temBomba) {
          int bombasAdjacentes = 0;

          // Verifique as 8 posições adjacentes.
          for (int dx = -1; dx <= 1; dx++) {
            for (int dy = -1; dy <= 1; dy++) {
              int newRow = i + dx;
              int newCol = j + dy;

              if (newRow >= 0 &&
                  newRow < tabuleiro.length &&
                  newCol >= 0 &&
                  newCol < tabuleiro[i].length &&
                  tabuleiro[newRow][newCol].temBomba) {
                bombasAdjacentes++;
              }
            }
          }

          tabuleiro[i][j].bombasAdjacentes = bombasAdjacentes;
          matrizDeBombasAdjacentes[i][j] = bombasAdjacentes;
        }
      }
    }
    return matrizDeBombasAdjacentes;
  }
}
