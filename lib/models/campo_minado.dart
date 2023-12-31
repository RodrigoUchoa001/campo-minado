import 'dart:math';

import 'package:campo_minado_flutter/exceptions/dificuldade_escolhida_invalidada_excepcion.dart';
import 'package:campo_minado_flutter/exceptions/numero_de_bandeiras_colocadas_ultrapassou_o_maximo_exception.dart';
import 'package:campo_minado_flutter/models/cronometro.dart';
import 'package:campo_minado_flutter/models/zona.dart';

class CampoMinado {
  late List<List<Zona>> tabuleiro;
  late int _dificuldade;
  late int _bandeirasColocadas;
  late List<List<int>> _matrizDeBombasAdjacentes;
  late Cronometro _cronometro;
  bool _jogoEmAndamento = true;
  bool _vitoria = false;

  int get dificuldade => _dificuldade;
  int get bandeirasColocadas => _bandeirasColocadas;
  List<List<int>> get matrizDeBombasAdjacentes => _matrizDeBombasAdjacentes;
  Cronometro get cronometro => _cronometro;
  bool get jogoEmAndamento => _jogoEmAndamento;
  bool get vitoria => _vitoria;

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
    _bandeirasColocadas = 0;
    _cronometro = Cronometro();
  }

  CampoMinado.paraTeste(this.tabuleiro) {
    contarBombasAdjacentes();
    _cronometro = Cronometro();
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

  void contarBombasAdjacentes() {
    /// matriz que vai armazenar a quantidade de bombas adjacentes de cada
    /// posicao. é usada para realizar testes
    _matrizDeBombasAdjacentes = List.generate(
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
  }

  int descobrirZona(int row, int col) {
    if (_jogoEmAndamento) {
      if (!cronometro.isRunning) {
        cronometro.start();
      }
      tabuleiro[row][col].descobrirZona();

      if (tabuleiro[row][col].temBomba) {
        _jogoEmAndamento = false; // O jogo terminou devido a uma derrota.
        _vitoria = false;
      } else {
        // Verificar se todas as zonas não bombas foram descobertas.
        int zonasNaoDescobertas = 0;

        for (int i = 0; i < tabuleiro.length; i++) {
          for (int j = 0; j < tabuleiro[i].length; j++) {
            if (tabuleiro[i][j].status == 0 && !tabuleiro[i][j].temBomba) {
              zonasNaoDescobertas++;
            }
          }
        }

        if (zonasNaoDescobertas == 0) {
          for (int i = 0; i < tabuleiro.length; i++) {
            for (int j = 0; j < tabuleiro[i].length; j++) {
              tabuleiro[i][j].forcarDescobrirZona();
            }
          }
          _jogoEmAndamento = false; // O jogo terminou devido a uma vitória.
          _vitoria = true;
        }
        return zonasNaoDescobertas;
      }
    }
    return 0;
  }

  void descobrirZonasAdjacentes(int row, int col) {
    final List<List<bool>> visited = List.generate(
      tabuleiro.length,
      (i) => List.generate(
        tabuleiro[i].length,
        (j) => false,
      ),
    );

    void dfs(int r, int c) {
      if (r < 0 || r >= tabuleiro.length || c < 0 || c >= tabuleiro[0].length) {
        return;
      }

      if (visited[r][c]) {
        return;
      }

      visited[r][c] = true;
      descobrirZona(r, c);

      if (tabuleiro[r][c].bombasAdjacentes == 0) {
        for (int dr = -1; dr <= 1; dr++) {
          for (int dc = -1; dc <= 1; dc++) {
            dfs(r + dr, c + dc);
          }
        }
      }
    }

    dfs(row, col);
  }

  void colocarBandeira(int row, int col) {
    if (_bandeirasColocadas >= getNumeroDeBombasPermitidas()) {
      throw NumeroDeBandeirasUltrapassouOMaximoException(
          'numero de bandeiras não pode ultrapassar o numero de bombas');
    }

    tabuleiro[row][col].colocarBandeira();
    _bandeirasColocadas++;

    bool temZonaComBombaSemBandeira = false;

    for (int row = 0; row < tabuleiro.length; row++) {
      for (int col = 0; col < tabuleiro[0].length; col++) {
        if (tabuleiro[row][col].temBomba && tabuleiro[row][col].status != 1) {
          temZonaComBombaSemBandeira = true;
        }
      }
    }

    if (!temZonaComBombaSemBandeira) {
      for (int i = 0; i < tabuleiro.length; i++) {
        for (int j = 0; j < tabuleiro[i].length; j++) {
          tabuleiro[i][j].forcarDescobrirZona();
        }
      }
      _jogoEmAndamento = false; // O jogo terminou devido a uma vitória.
      _vitoria = true;
    }
  }

  void removerBandeira(int row, int col) {
    tabuleiro[row][col].removerBandeira();
    _bandeirasColocadas--;
  }

  int getNumeroDeBombasPermitidas() {
    late int numDeBandeirasPermitidas;
    if (dificuldade == 1) {
      numDeBandeirasPermitidas = 10;
    } else if (dificuldade == 2) {
      numDeBandeirasPermitidas = 30;
    } else if (dificuldade == 3) {
      numDeBandeirasPermitidas = 100;
    }

    return numDeBandeirasPermitidas;
  }
}
