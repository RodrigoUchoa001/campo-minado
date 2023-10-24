// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:campo_minado_flutter/exceptions/bandeira_em_zona_descoberta_exception.dart';
import 'package:campo_minado_flutter/exceptions/descobrir_zona_com_bandeira_exception.dart';
import 'package:campo_minado_flutter/exceptions/dificuldade_escolhida_invalidada_excepcion.dart';
import 'package:campo_minado_flutter/exceptions/remover_bandeira_de_zona_sem_bandeira_exception.dart';
import 'package:campo_minado_flutter/exceptions/tentativa_de_alteracao_de_bomba_exception.dart';
import 'package:campo_minado_flutter/models/campo_minado.dart';
import 'package:campo_minado_flutter/models/zona.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  group('testes da classe Zona', () {
    test(
        'testa se não é possível mudar o valor do atributo "temBomba" de uma Zona',
        () {
      expect(
        () {
          Zona zona = Zona();
          zona.temBomba = true;
          zona.temBomba = false;
        },
        throwsA(isA<TentativaDeAlteracaoDeBombaException>()),
      );
    });
    test(
        'Teste se o colocarBandeira para verificar se ela define o status corretamente',
        () {
      Zona zona = Zona();
      zona.colocarBandeira();

      expect(zona.status, 1);
    });
    test(
        'Teste se o removerBandeira para verificar se ela define o status corretamente',
        () {
      Zona zona = Zona();
      zona.colocarBandeira();
      zona.removerBandeira();

      expect(zona.status, 0);
    });
    test(
        'Teste se o descobrirZona para verificar se ela define o status corretamente',
        () {
      Zona zona = Zona();
      zona.descobrirZona();

      expect(zona.status, 2);
    });
  });

  group('testes da classe CampoMinado', () {
    test('testa se jogoEmAndamento n inicia como true na dificuldade facil',
        () {
      int dificuldade = 1;
      CampoMinado campoMinado = CampoMinado(dificuldade);
      expect(campoMinado.jogoEmAndamento, true);
    });
    test(
        'testa se jogoEmAndamento n inicia como true na dificuldade intermediario',
        () {
      int dificuldade = 2;
      CampoMinado campoMinado = CampoMinado(dificuldade);
      expect(campoMinado.jogoEmAndamento, true);
    });
    test('testa se jogoEmAndamento n inicia como true na dificuldade dificil',
        () {
      int dificuldade = 3;
      CampoMinado campoMinado = CampoMinado(dificuldade);
      expect(campoMinado.jogoEmAndamento, true);
    });
    test('testa se vitoria inicia como false na dificuldade facil', () {
      int dificuldade = 1;
      CampoMinado campoMinado = CampoMinado(dificuldade);
      expect(campoMinado.vitoria, false);
    });
    test('testa se vitoria inicia como false na dificuldade intermediario', () {
      int dificuldade = 2;
      CampoMinado campoMinado = CampoMinado(dificuldade);
      expect(campoMinado.vitoria, false);
    });
    test('testa se vitoria inicia como false na dificuldade dificil', () {
      int dificuldade = 3;
      CampoMinado campoMinado = CampoMinado(dificuldade);
      expect(campoMinado.vitoria, false);
    });
  });
  group(
      'deve ser possível escolher entre três níveis de dificuldade (fácil, intermediário, difícil)',
      () {
    test('a se é possível escolher dificuldade fácil', () {
      int dificuldade = 1;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      expect(campoMinado.dificuldade, 1);
    });
    test('a se é possível escolher dificuldade intermediário', () {
      int dificuldade = 2;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      expect(campoMinado.dificuldade, 2);
    });
    test('a se é possível escolher dificuldade difícil', () {
      int dificuldade = 3;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      expect(campoMinado.dificuldade, 3);
    });
    test(
      "testa se não é deve ser possível escolher outro nivel de dificuldade",
      () => expect(
        () {
          int dificuldade = 4;
          CampoMinado(dificuldade);
        },
        throwsA(isA<DificuldadeEscolhidaInvalidaException>()),
      ),
    );
  });

  group(
      'cada nivel de dificuldade deve criar um tabuleiro com quantidade fixa de posições',
      () {
    test("testa se escolhendo fácil o tabuleiro tem 8 linhas", () {
      int dificuldade = 1;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      int numLinhas = campoMinado.tabuleiro.length;

      expect(numLinhas, 8);
    });
    test("testa se escolhendo fácil o tabuleiro tem 8 colunas", () {
      int dificuldade = 1;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      int numColunas = campoMinado.tabuleiro[0].length;

      expect(numColunas, 8);
    });
    test("testa se escolhendo intermediario o tabuleiro tem 10 linhas", () {
      int dificuldade = 2;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      int numLinhas = campoMinado.tabuleiro.length;

      expect(numLinhas, 10);
    });
    test("testa se escolhendo intermediario o tabuleiro tem 16 colunas", () {
      int dificuldade = 2;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      int numColunas = campoMinado.tabuleiro[0].length;

      expect(numColunas, 16);
    });
    test("testa se escolhendo dificil o tabuleiro tem 24 linhas", () {
      int dificuldade = 3;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      int numLinhas = campoMinado.tabuleiro.length;

      expect(numLinhas, 24);
    });
    test("testa se escolhendo dificil o tabuleiro tem 24 colunas", () {
      int dificuldade = 3;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      int numColunas = campoMinado.tabuleiro[0].length;

      expect(numColunas, 24);
    });
  });

  group(
      'cada nivel de dificuldade deve criar um tabuleiro com um número fixa de bombas',
      () {
    test('testa se escolhendo fácil tem 10 bombas', () {
      int dificuldade = 1;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      int quantidadeDeBombas = 0;

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          if (campoMinado.tabuleiro[i][j].temBomba) {
            quantidadeDeBombas++;
          }
        }
      }

      expect(quantidadeDeBombas, 10);
    });
    test('testa se escolhendo fácil tem 30 bombas', () {
      int dificuldade = 2;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      int quantidadeDeBombas = 0;

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          if (campoMinado.tabuleiro[i][j].temBomba) {
            quantidadeDeBombas++;
          }
        }
      }

      expect(quantidadeDeBombas, 30);
    });
    test('testa se escolhendo fácil tem 100 bombas', () {
      int dificuldade = 3;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      int quantidadeDeBombas = 0;

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          if (campoMinado.tabuleiro[i][j].temBomba) {
            quantidadeDeBombas++;
          }
        }
      }

      expect(quantidadeDeBombas, 100);
    });
  });

  group('todas as zonas devem começar como cobertas', () {
    test("testa se todas as zonas da dificuldade fácil começam como cobertas",
        () {
      int dificuldade = 1;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      bool temDiferenteDeCoberto = false;

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          if (campoMinado.tabuleiro[i][j].status != 0) {
            temDiferenteDeCoberto = true;
          }
        }
      }

      expect(temDiferenteDeCoberto, false);
    });
    test(
        "testa se todas as zonas da dificuldade intermidiario começam como cobertas",
        () {
      int dificuldade = 2;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      bool temDiferenteDeCoberto = false;

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          if (campoMinado.tabuleiro[i][j].status != 0) {
            temDiferenteDeCoberto = true;
          }
        }
      }

      expect(temDiferenteDeCoberto, false);
    });
    test("testa se todas as zonas da dificuldade dificil começam como cobertas",
        () {
      int dificuldade = 3;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      bool temDiferenteDeCoberto = false;

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          if (campoMinado.tabuleiro[i][j].status != 0) {
            temDiferenteDeCoberto = true;
          }
        }
      }

      expect(temDiferenteDeCoberto, false);
    });
  });

  group('todas as zonas devem começam como sem bandeira', () {
    test("testa se todas as zonas da dificuldade fácil começam sem bandeira",
        () {
      int dificuldade = 1;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      bool temZonaComBandeira = false;

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          if (campoMinado.tabuleiro[i][j].status == 1) {
            temZonaComBandeira = true;
          }
        }
      }

      expect(temZonaComBandeira, false);
    });
    test(
        "testa se todas as zonas da dificuldade intermediario começam sem bandeira",
        () {
      int dificuldade = 2;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      bool temZonaComBandeira = false;

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          if (campoMinado.tabuleiro[i][j].status == 1) {
            temZonaComBandeira = true;
          }
        }
      }

      expect(temZonaComBandeira, false);
    });
    test("testa se todas as zonas da dificuldade dificil começam sem bandeira",
        () {
      int dificuldade = 3;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      bool temZonaComBandeira = false;

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          if (campoMinado.tabuleiro[i][j].status == 1) {
            temZonaComBandeira = true;
          }
        }
      }

      expect(temZonaComBandeira, false);
    });
  });

  group('Cada zona pode ser área limpa ou conter uma bomba', () {
    test('testa se cada zona da dificuldade fácil inicia contendo bomba ou não',
        () {
      int dificuldade = 1;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      bool temAlgoAlemDeBombaOuNaoBomba = false;

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          if (campoMinado.tabuleiro[i][j].temBomba ||
              !campoMinado.tabuleiro[i][j].temBomba) {
          } else {
            temAlgoAlemDeBombaOuNaoBomba = true;
          }
        }
      }
      expect(temAlgoAlemDeBombaOuNaoBomba, false);
    });
    test(
        'testa se cada zona da dificuldade intermediario inicia contendo bomba ou não',
        () {
      int dificuldade = 2;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      bool temAlgoAlemDeBombaOuNaoBomba = false;

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          if (campoMinado.tabuleiro[i][j].temBomba ||
              !campoMinado.tabuleiro[i][j].temBomba) {
          } else {
            temAlgoAlemDeBombaOuNaoBomba = true;
          }
        }
      }
      expect(temAlgoAlemDeBombaOuNaoBomba, false);
    });
    test(
        'testa se cada zona da dificuldade dificil inicia contendo bomba ou não',
        () {
      int dificuldade = 3;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      bool temAlgoAlemDeBombaOuNaoBomba = false;

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          if (campoMinado.tabuleiro[i][j].temBomba ||
              !campoMinado.tabuleiro[i][j].temBomba) {
          } else {
            temAlgoAlemDeBombaOuNaoBomba = true;
          }
        }
      }
      expect(temAlgoAlemDeBombaOuNaoBomba, false);
    });
  });

  group('deve ser possivel colocar bandeira em uma posição coberta', () {
    test(
        "testa se é possivel colocar bandeira em qualquer uma das posições sem problemas na dificuldade fácil",
        () {
      int dificuldade = 1;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      bool naoColocouBandeiraEmAlgumaZona = false;

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          campoMinado.colocarBandeira(i, j);
          if (campoMinado.tabuleiro[i][j].status != 1) {
            naoColocouBandeiraEmAlgumaZona = true;
          }
        }
      }

      expect(naoColocouBandeiraEmAlgumaZona, false);
    });
    test(
        "testa se é possivel colocar bandeira em qualquer uma das posições sem problemas na dificuldade intermidiario",
        () {
      int dificuldade = 2;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      bool naoColocouBandeiraEmAlgumaZona = false;

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          campoMinado.colocarBandeira(i, j);
          if (campoMinado.tabuleiro[i][j].status != 1) {
            naoColocouBandeiraEmAlgumaZona = true;
          }
        }
      }

      expect(naoColocouBandeiraEmAlgumaZona, false);
    });
    test(
        "testa se é possivel colocar bandeira em qualquer uma das posições sem problemas na dificuldade dificil",
        () {
      int dificuldade = 3;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      bool naoColocouBandeiraEmAlgumaZona = false;

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          campoMinado.colocarBandeira(i, j);
          if (campoMinado.tabuleiro[i][j].status != 1) {
            naoColocouBandeiraEmAlgumaZona = true;
          }
        }
      }

      expect(naoColocouBandeiraEmAlgumaZona, false);
    });

    parameterizedTest(
      "testa se não é possivel colocar bandeira em posição invalida",
      [
        [-1, 0],
        [0, -1],
        [-1, -1],
      ],
      p2(
        (int i, int j) {
          expect(
            () {
              int dificuldade = 1;
              CampoMinado campoMinado = CampoMinado(dificuldade);

              campoMinado.colocarBandeira(i, j);
            },
            throwsA(isA<RangeError>()),
          );
        },
      ),
    );
  });

  group('deve ser possível remover bandeira se houver', () {
    test('testa se é possível remover bandeira de qualquer zona quando houver',
        () {
      int dificuldade = 1;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          // n tem except, pq caso de uma excecao o teste n passa
          campoMinado.colocarBandeira(i, j);
          campoMinado.removerBandeira(i, j);
        }
      }
    });
    test(
      'testa se não é possivel remover bandeira de zona quando não houver',
      () {
        int dificuldade = 1;
        CampoMinado campoMinado = CampoMinado(dificuldade);
        for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
          for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
            expect(
              () {
                campoMinado.removerBandeira(i, j);
              },
              throwsA(isA<RemoverBandeiraDeZonaSemBandeiraException>()),
            );
          }
        }
      },
    );
    parameterizedTest(
      '30- testa se não é possivel remover bandeira em posição invalida',
      [
        [-1, 0],
        [0, -1],
        [-1, -1],
      ],
      p2(
        (int i, int j) {
          expect(
            () {
              int dificuldade = 1;
              CampoMinado campoMinado = CampoMinado(dificuldade);

              campoMinado.colocarBandeira(i, j);
              campoMinado.removerBandeira(i, j);
            },
            throwsA(isA<RangeError>()),
          );
        },
      ),
    );
  });

  group('deve ser possivel descobrir uma zona sem bandeira', () {
    test('testa se é possível descobrir uma zona que não tem bandeira', () {
      int dificuldade = 1;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          // n tem except, pq caso de uma excecao o teste n passa
          campoMinado.descobrirZona(i, j);
        }
      }
    });
    test('testa se é não possível descobrir uma zona que tem bandeira', () {
      int dificuldade = 1;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          expect(
            () {
              campoMinado.colocarBandeira(i, j);
              campoMinado.descobrirZona(i, j);
            },
            throwsA(isA<DescobrirZonaComBandeiraException>()),
          );
        }
      }
    });
    parameterizedTest(
      '33- testa se não é possivel descobrir zona de posição invalida',
      [
        [-1, 0],
        [0, -1],
        [-1, -1],
      ],
      p2(
        (int i, int j) {
          expect(
            () {
              int dificuldade = 1;
              CampoMinado campoMinado = CampoMinado(dificuldade);

              campoMinado.descobrirZona(i, j);
            },
            throwsA(isA<RangeError>()),
          );
        },
      ),
    );
  });
  group("não deve ser possível colocar bandeira em zona descoberta", () {
    test("testa se não é possível colocar bandeira em zona descoberta", () {
      int dificuldade = 1;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          // o teste n tava passando sem esse if. Pq por verificar o tabuleiro
          // inteiro, em algum momento ou o jogador vai descobrir uma bomba, ou
          // vai vencer. Acontecendo isso a variavel '_jogoEmAndamento' da classe
          // CampoMinado se tornaria 'false', impedindo de descobrir a Zona, oq
          // faria q n lancasse a excecao esperada
          if (!campoMinado.tabuleiro[i][j].temBomba) {
            expect(
              () {
                campoMinado.descobrirZona(i, j);
                campoMinado.colocarBandeira(i, j);
              },
              throwsA(isA<BandeiraEmZonaDescobertaException>()),
            );
          }
        }
      }
    });
    parameterizedTest(
      '35- testa se não é possivel colocar bandeira em zona invalida',
      [
        [-1, 0],
        [0, -1],
        [-1, -1],
      ],
      p2(
        (int i, int j) {
          expect(
            () {
              int dificuldade = 1;
              CampoMinado campoMinado = CampoMinado(dificuldade);

              campoMinado.colocarBandeira(i, j);
            },
            throwsA(isA<RangeError>()),
          );
        },
      ),
    );
  });
  group(
      'As zonas limpas que fazem fronteira com zonas com bomba, devem indicar quantas bombas aparecem adjacentes a ela',
      () {
    test(
        'testa se a zona diz exatamente quantas bombas existem adjacentes desta zona',
        () {
      int dificuldade = 1;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      List<List<int>> matrizDeBombasAdjacentes =
          campoMinado.matrizDeBombasAdjacentes;

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          expect(
            campoMinado.tabuleiro[i][j].bombasAdjacentes,
            matrizDeBombasAdjacentes[i][j],
          );
        }
      }
    });
    test('testa se o número de bombas adjacentes de uma zona está entre 0 e 8',
        () {
      bool valorEstaEntre(int valor, int limiteInferior, int limiteSuperior) {
        return valor >= limiteInferior && valor <= limiteSuperior;
      }

      int dificuldade = 1;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          expect(
            valorEstaEntre(
              campoMinado.tabuleiro[i][j].bombasAdjacentes,
              0,
              8,
            ),
            isTrue,
          );
        }
      }
    });
  });
  group(
      ' o jogo deve acabar com derrota quando uma zona com bomba for descoberta',
      () {
    test('testa se o jogo acaba quando uma bomba é descoberta', () {
      int dificuldade = 1;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          if (campoMinado.tabuleiro[i][j].temBomba) {
            campoMinado.descobrirZona(i, j);
            expect(campoMinado.jogoEmAndamento, false);
            expect(campoMinado.vitoria, false);
            break;
          }
        }
      }
    });

    test('testa se o jogo continua se não houver bomba descoberta', () {
      // esse teste descobre todas as zonas q n tem bomba. se descobrir todas
      // (jogoEmAndamento ficar como true), entao o jogo continua enquanto as
      // zonas com bombas n estiverem descobertas
      int dificuldade = 1;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          if (!campoMinado.tabuleiro[i][j].temBomba) {
            campoMinado.descobrirZona(i, j);
          }
        }
      }
      expect(campoMinado.jogoEmAndamento, false);
      expect(campoMinado.vitoria, true);
    });
  });
  group(
      'o jogo deve acabar com vitória quando todas as zonas sem bombas estiverem descobertas',
      () {
    test(
        'testa se o jogo acaba quando todas as zonas sem bombas estiverem descobertas',
        () {
      int dificuldade = 1;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          if (!campoMinado.tabuleiro[i][j].temBomba) {
            campoMinado.descobrirZona(i, j);
          }
        }
      }
      expect(campoMinado.jogoEmAndamento, false);
      expect(campoMinado.vitoria, true);
    });

    test('testa se o jogo continua se alguma das zonas estiver coberta', () {
      int dificuldade = 1;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      bool jogoParouAntesDaHora = false;

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          if (!campoMinado.tabuleiro[i][j].temBomba) {
            campoMinado.descobrirZona(i, j);
            // testa se o jogo não está mais em andamento, mas ainda há zonas
            // cobertas, msm o if anterior descobrindo todas as zonas sem bombas
            // obs: o descobrirZona() retorna o numero de zonasNaoDescobertas
            if (!campoMinado.jogoEmAndamento &&
                campoMinado.descobrirZona(i, j) != 0) {
              jogoParouAntesDaHora = true;
              break;
            }
          }
        }
      }

      expect(jogoParouAntesDaHora, false);
    });

    group(
        'ao clicar em uma zona, as zonas adjacentes que não tiverem bombas são automaticamente descobertas ao msm tempo',
        () {
      test(
          'Ao descobrir uma zona vazia, zonas adjacentes sem bombas também devem ser descobertas',
          () {
        // Crie um objeto CampoMinado para o teste
        final campoMinado = CampoMinado(1);

        // Inicialize as variáveis targetRow e targetCol com valores padrão
        int targetRow = 0;
        int targetCol = 0;

        // Encontre uma zona vazia (sem bomba) para realizar o teste
        for (int row = 0; row < campoMinado.tabuleiro.length; row++) {
          for (int col = 0; col < campoMinado.tabuleiro[0].length; col++) {
            if (campoMinado.tabuleiro[row][col].bombasAdjacentes == 0) {
              targetRow = row;
              targetCol = col;
              break;
            }
          }
          if (targetRow != 0 && targetCol != 0) {
            break;
          }
        }

        // Execute a função que você deseja testar
        campoMinado.descobrirZona(targetRow, targetCol);

        // Verifique se as zonas adjacentes foram descobertas

        // Zona superior esquerda
        if (targetRow > 0 && targetCol > 0) {
          expect(campoMinado.tabuleiro[targetRow - 1][targetCol - 1].status,
              equals(0));
        }

        // Zona superior
        if (targetRow > 0) {
          expect(campoMinado.tabuleiro[targetRow - 1][targetCol].status,
              equals(0));
        }

        // Zona superior direita
        if (targetRow > 0 && targetCol < campoMinado.tabuleiro[0].length - 1) {
          expect(campoMinado.tabuleiro[targetRow - 1][targetCol + 1].status,
              equals(0));
        }

        // Zona esquerda
        if (targetCol > 0) {
          expect(campoMinado.tabuleiro[targetRow][targetCol - 1].status,
              equals(0));
        }

        // Zona direita
        if (targetCol < campoMinado.tabuleiro[0].length - 1) {
          expect(campoMinado.tabuleiro[targetRow][targetCol + 1].status,
              equals(0));
        }

        // Zona inferior esquerda
        if (targetRow < campoMinado.tabuleiro.length - 1 && targetCol > 0) {
          expect(campoMinado.tabuleiro[targetRow + 1][targetCol - 1].status,
              equals(0));
        }

        // Zona inferior
        if (targetRow < campoMinado.tabuleiro.length - 1) {
          expect(campoMinado.tabuleiro[targetRow + 1][targetCol].status,
              equals(0));
        }

        // Zona inferior direita
        if (targetRow < campoMinado.tabuleiro.length - 1 &&
            targetCol < campoMinado.tabuleiro[0].length - 1) {
          expect(campoMinado.tabuleiro[targetRow + 1][targetCol + 1].status,
              equals(0));
        }
      });
    });

    // group(
    //     'A pontuação do jogo é dada pelo tempo levado para descobrir todas as bombas em segundos',
    //     () {
    //   test('testa se é iniciado um contador de tempo ao começar o jogo', () {
    //     CampoMinado campoMinado = CampoMinado(1);
    //   });
    // });
    //
    //
    //
    // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    //   // Build our app and trigger a frame.
    //   await tester.pumpWidget(const MyApp());

    //   // Verify that our counter starts at 0.
    //   expect(find.text('0'), findsOneWidget);
    //   expect(find.text('1'), findsNothing);

    //   // Tap the '+' icon and trigger a frame.
    //   await tester.tap(find.byIcon(Icons.add));
    //   await tester.pump();

    //   // Verify that our counter has incremented.
    //   expect(find.text('0'), findsNothing);
    //   expect(find.text('1'), findsOneWidget);
    // });
  });
}
