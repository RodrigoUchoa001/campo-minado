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
import 'package:campo_minado_flutter/models/campo_minado.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
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

  group(
      'II - deve ser possível escolher entre três níveis de dificuldade (fácil, intermediário, difícil)',
      () {
    test('1- testa se é possível escolher dificuldade fácil', () {
      int dificuldade = 1;
      CampoMinado campoMinado = CampoMinado(dificuldade);
      // n precisa de expect, se der exception vai da erro no teste
    });
    test('2- testa se é possível escolher dificuldade intermediário', () {
      int dificuldade = 2;
      CampoMinado campoMinado = CampoMinado(dificuldade);
      // n precisa de expect, se der exception vai da erro no teste
    });
    test('3- testa se é possível escolher dificuldade difícil', () {
      int dificuldade = 3;
      CampoMinado campoMinado = CampoMinado(dificuldade);
      // n precisa de expect, se der exception vai da erro no teste
    });
    test(
      "4- testa se não é deve ser possível escolher outro nivel de dificuldade",
      () => expect(
        () {
          int dificuldade = 4;
          CampoMinado campoMinado = CampoMinado(dificuldade);
        },
        throwsA(isA<DificuldadeEscolhidaInvalidaException>()),
      ),
    );
  });

  group(
      'II - cada nivel de dificuldade deve criar um tabuleiro com quantidade fixa de posições',
      () {
    test("5- testa se escolhendo fácil tem 8x8 posições", () {
      int dificuldade = 1;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      int numLinhas = campoMinado.tabuleiro.length;
      int numColunas = campoMinado.tabuleiro[0].length;

      expect(numLinhas, 8);
      expect(numColunas, 8);
    });
    test("6- testa se escolhendo fácil tem 10x16 posições", () {
      int dificuldade = 2;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      int numLinhas = campoMinado.tabuleiro.length;
      int numColunas = campoMinado.tabuleiro[0].length;

      expect(numLinhas, 10);
      expect(numColunas, 16);
    });
    test("7- testa se escolhendo fácil tem 24x24 posições", () {
      int dificuldade = 3;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      int numLinhas = campoMinado.tabuleiro.length;
      int numColunas = campoMinado.tabuleiro[0].length;

      expect(numLinhas, 24);
      expect(numColunas, 24);
    });
  });

  group(
      'III - cada nivel de dificuldade deve criar um tabuleiro com um número fixa de bombas',
      () {
    test('8- testa se escolhendo fácil tem 10 bombas', () {
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
    test('9- testa se escolhendo fácil tem 30 bombas', () {
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
    test('10- testa se escolhendo fácil tem 100 bombas', () {
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

  group('IV - todas as zonas devem começar como cobertas', () {
    test(
        "11- testa se todas as zonas da dificuldade fácil começam como cobertas",
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
        "12- testa se todas as zonas da dificuldade intermidiario começam como cobertas",
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
    test(
        "13- testa se todas as zonas da dificuldade dificil começam como cobertas",
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

  group('V - todas as zonas devem começam como sem bandeira', () {
    test(
        "14- testa se todas as zonas da dificuldade fácil começam sem bandeira",
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
        "14- testa se todas as zonas da dificuldade intermediario começam sem bandeira",
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
    test(
        "14- testa se todas as zonas da dificuldade dificil começam sem bandeira",
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

  group('VI - Cada zona pode ser área limpa ou conter uma bomba', () {
    test(
        '17- testa se cada zona da dificuldade fácil inicia contendo bomba ou não',
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
        '18- testa se cada zona da dificuldade intermediario inicia contendo bomba ou não',
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
        '19- testa se cada zona da dificuldade dificil inicia contendo bomba ou não',
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
        "20- testa se é possivel colocar bandeira em qualquer uma das posições sem problemas na dificuldade fácil",
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
        "21- testa se é possivel colocar bandeira em qualquer uma das posições sem problemas na dificuldade intermidiario",
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
        "22- testa se é possivel colocar bandeira em qualquer uma das posições sem problemas na dificuldade dificil",
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
      "23- testa se não é possivel colocar bandeira em posição invalida",
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
    test(
        '24- testa se é possível remover bandeira de qualquer zona quando houver',
        () {
      int dificuldade = 1;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          campoMinado.colocarBandeira(i, j);
          campoMinado.removerBandeira(i, j);
        }
      }
    });
    test(
      '25- testa se não é possivel remover bandeira de zona quando não houver',
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
      '26- testa se não é possivel remover bandeira em posição invalida',
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

              campoMinado.removerBandeira(i, j);
            },
            throwsA(isA<RangeError>()),
          );
        },
      ),
    );
  });

  group('IX- deve ser possivel descobrir uma zona sem bandeira', () {
    test('27- testa se é possível descobrir uma zona que não tem bandeira', () {
      int dificuldade = 1;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          campoMinado.descobrirZona(i, j);
        }
      }
    });
    test('28- testa se é não possível descobrir uma zona que tem bandeira', () {
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
      '29- testa se não é possivel descobrir zona de posição invalida',
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
  group("X- não deve ser possível colocar bandeira em zona descoberta", () {
    test("30- testa se não é possível colocar bandeira em zona descoberta", () {
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
      '31- testa se não é possivel colocar bandeira em zona invalida',
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
      'XI - As zonas limpas que fazem fronteira com zonas com bomba, devem indicar quantas bombas aparecem adjacentes a ela',
      () {
    test(
        '32- testa se a zona diz exatamente quantas bombas existem adjacentes desta zona',
        () {
      int dificuldade = 1;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      List<List<int>> matrizDeBombasAdjacentes =
          campoMinado.contarBombasAdjacentes();

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          expect(
            campoMinado.tabuleiro[i][j].bombasAdjacentes,
            matrizDeBombasAdjacentes[i][j],
          );
        }
      }
    });
    test(
        '33- testa se o número de bombas adjacentes de uma zona está entre 0 e 8',
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
      'XII - o jogo deve acabar com derrota quando uma zona com bomba for descoberta',
      () {
    test('34- testa se o jogo acaba quando uma bomba é descoberta', () {
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

    test('35- testa se o jogo continua se não houver bomba descoberta', () {
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
}
