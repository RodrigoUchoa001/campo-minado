// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:campo_minado_flutter/db/collections/pontuacao.dart';
import 'package:campo_minado_flutter/db/db_metodos.dart';
import 'package:campo_minado_flutter/exceptions/armazenar_pontuacao_sem_haver_vitoria_exception.dart';
import 'package:campo_minado_flutter/exceptions/bandeira_em_zona_descoberta_exception.dart';
import 'package:campo_minado_flutter/exceptions/descobrir_zona_com_bandeira_exception.dart';
import 'package:campo_minado_flutter/exceptions/dificuldade_escolhida_invalidada_excepcion.dart';
import 'package:campo_minado_flutter/exceptions/numero_de_bandeiras_colocadas_ultrapassou_o_maximo_exception.dart';
import 'package:campo_minado_flutter/exceptions/remover_bandeira_de_zona_sem_bandeira_exception.dart';
import 'package:campo_minado_flutter/exceptions/tentativa_de_alteracao_de_bomba_exception.dart';
import 'package:campo_minado_flutter/models/campo_minado.dart';
import 'package:campo_minado_flutter/models/cronometro.dart';
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
        'testa se colocarBandeira, depois removerBandeira, depois colocarBandeira de novo é possivel',
        () {
      Zona zona = Zona();
      zona.colocarBandeira();
      zona.removerBandeira();
      zona.colocarBandeira();

      expect(zona.status, 1);
    });
    test(
        'Teste se o descobrirZona para verificar se ela define o status corretamente',
        () {
      Zona zona = Zona();
      zona.descobrirZona();

      expect(zona.status, 2);
    });
    test('testa se descobrir a zona após colocar e remover bandeira é possivel',
        () {
      Zona zona = Zona();
      zona.colocarBandeira();
      zona.removerBandeira();
      zona.descobrirZona();

      expect(zona.status, 2);
    });
  });

  group('testes da classe Cronometro', () {
    test('testa se o cronômetro inicia como zero', () {
      Cronometro cronometro = Cronometro();

      expect(cronometro.elapsedTime, Duration.zero);
    });
    test('testa se o cronômetro conta o tempo corretamente', () async {
      Cronometro cronometro = Cronometro();
      cronometro.start();

      await Future.delayed(const Duration(seconds: 3));

      cronometro.stop();

      // a divisao a seguir usa uma margem de erro na contagem de tempo, já q
      // pode variar por causa do await
      final tempoEmSegundos = cronometro.elapsedTime.inMilliseconds / 1000.0;
      expect(tempoEmSegundos, closeTo(3.0, 0.1));
    });
    test('testa se o reset reinicia o tempo corretamente', () async {
      Cronometro cronometro = Cronometro();
      cronometro.start();

      await Future.delayed(const Duration(seconds: 3));

      cronometro.stop();
      cronometro.reset();

      expect(cronometro.elapsedTime, equals(Duration.zero));
    });
    test('testa se o isRunning funciona corretamente', () {
      Cronometro cronometro = Cronometro();

      cronometro.start();
      expect(cronometro.isRunning, true);

      cronometro.stop();
      expect(cronometro.isRunning, false);
    });
    test(
        'testa se o cronometro conta o tempo corretamente se pausado em algum momento',
        () async {
      Cronometro cronometro = Cronometro();

      cronometro.start();
      await Future.delayed(const Duration(seconds: 2));
      cronometro.stop();

      //espera 2 segundos até contar novamente
      await Future.delayed(const Duration(seconds: 2));

      cronometro.start();
      await Future.delayed(const Duration(seconds: 2));
      cronometro.stop();

      final tempoEmSegundos = cronometro.elapsedTime.inMilliseconds / 1000.0;
      expect(tempoEmSegundos, closeTo(4.0, 0.1));
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
    test(
        'testa se o numero de zonas adjacentes com bomba é apresentado corretamente no caso de 1 bombas',
        () {
      final tabuleiroFake = List.generate(
        8,
        (row) => List.generate(
          8,
          (col) => Zona(),
        ),
      );

      // Configurar o tabuleiro com 8 bombas ao redor da zona central.
      tabuleiroFake[3][3].temBomba = false; // Zona central com bomba

      // Bombas ao redor da zona central
      tabuleiroFake[2][2].temBomba = true;

      // Crie uma instância de CampoMinado usando o tabuleiro fake.
      final campoMinado = CampoMinado.paraTeste(tabuleiroFake);

      // Verifique se o número de bombas adjacentes da zona central é 8.
      expect(campoMinado.tabuleiro[3][3].bombasAdjacentes, 1);
    });
    test(
        'testa se o numero de zonas adjacentes com bomba é apresentado corretamente no caso de 2 bombas',
        () {
      final tabuleiroFake = List.generate(
        8,
        (row) => List.generate(
          8,
          (col) => Zona(),
        ),
      );

      // Configurar o tabuleiro com 8 bombas ao redor da zona central.
      tabuleiroFake[3][3].temBomba = false; // Zona central com bomba

      // Bombas ao redor da zona central
      tabuleiroFake[2][2].temBomba = true;
      tabuleiroFake[2][3].temBomba = true;

      // Crie uma instância de CampoMinado usando o tabuleiro fake.
      final campoMinado = CampoMinado.paraTeste(tabuleiroFake);

      // Verifique se o número de bombas adjacentes da zona central é 8.
      expect(campoMinado.tabuleiro[3][3].bombasAdjacentes, 2);
    });
    test(
        'testa se o numero de zonas adjacentes com bomba é apresentado corretamente no caso de 3 bombas',
        () {
      final tabuleiroFake = List.generate(
        8,
        (row) => List.generate(
          8,
          (col) => Zona(),
        ),
      );

      // Configurar o tabuleiro com 8 bombas ao redor da zona central.
      tabuleiroFake[3][3].temBomba = false; // Zona central com bomba

      // Bombas ao redor da zona central
      tabuleiroFake[2][2].temBomba = true;
      tabuleiroFake[2][3].temBomba = true;
      tabuleiroFake[2][4].temBomba = true;

      // Crie uma instância de CampoMinado usando o tabuleiro fake.
      final campoMinado = CampoMinado.paraTeste(tabuleiroFake);

      // Verifique se o número de bombas adjacentes da zona central é 8.
      expect(campoMinado.tabuleiro[3][3].bombasAdjacentes, 3);
    });
    test(
        'testa se o numero de zonas adjacentes com bomba é apresentado corretamente no caso de 4 bombas',
        () {
      final tabuleiroFake = List.generate(
        8,
        (row) => List.generate(
          8,
          (col) => Zona(),
        ),
      );

      // Configurar o tabuleiro com 8 bombas ao redor da zona central.
      tabuleiroFake[3][3].temBomba = false; // Zona central com bomba

      // Bombas ao redor da zona central
      tabuleiroFake[2][2].temBomba = true;
      tabuleiroFake[2][3].temBomba = true;
      tabuleiroFake[2][4].temBomba = true;
      tabuleiroFake[3][2].temBomba = true;

      // Crie uma instância de CampoMinado usando o tabuleiro fake.
      final campoMinado = CampoMinado.paraTeste(tabuleiroFake);

      // Verifique se o número de bombas adjacentes da zona central é 8.
      expect(campoMinado.tabuleiro[3][3].bombasAdjacentes, 4);
    });
    test(
        'testa se o numero de zonas adjacentes com bomba é apresentado corretamente no caso de 5 bombas',
        () {
      final tabuleiroFake = List.generate(
        8,
        (row) => List.generate(
          8,
          (col) => Zona(),
        ),
      );

      // Configurar o tabuleiro com 8 bombas ao redor da zona central.
      tabuleiroFake[3][3].temBomba = false; // Zona central com bomba

      // Bombas ao redor da zona central
      tabuleiroFake[2][2].temBomba = true;
      tabuleiroFake[2][3].temBomba = true;
      tabuleiroFake[2][4].temBomba = true;
      tabuleiroFake[3][2].temBomba = true;
      tabuleiroFake[3][4].temBomba = true;

      // Crie uma instância de CampoMinado usando o tabuleiro fake.
      final campoMinado = CampoMinado.paraTeste(tabuleiroFake);

      // Verifique se o número de bombas adjacentes da zona central é 8.
      expect(campoMinado.tabuleiro[3][3].bombasAdjacentes, 5);
    });
    test(
        'testa se o numero de zonas adjacentes com bomba é apresentado corretamente no caso de 6 bombas',
        () {
      final tabuleiroFake = List.generate(
        8,
        (row) => List.generate(
          8,
          (col) => Zona(),
        ),
      );

      // Configurar o tabuleiro com 8 bombas ao redor da zona central.
      tabuleiroFake[3][3].temBomba = false; // Zona central com bomba

      // Bombas ao redor da zona central
      tabuleiroFake[2][2].temBomba = true;
      tabuleiroFake[2][3].temBomba = true;
      tabuleiroFake[2][4].temBomba = true;
      tabuleiroFake[3][2].temBomba = true;
      tabuleiroFake[3][4].temBomba = true;
      tabuleiroFake[4][2].temBomba = true;

      // Crie uma instância de CampoMinado usando o tabuleiro fake.
      final campoMinado = CampoMinado.paraTeste(tabuleiroFake);

      // Verifique se o número de bombas adjacentes da zona central é 8.
      expect(campoMinado.tabuleiro[3][3].bombasAdjacentes, 6);
    });
    test(
        'testa se o numero de zonas adjacentes com bomba é apresentado corretamente no caso de 7 bombas',
        () {
      final tabuleiroFake = List.generate(
        8,
        (row) => List.generate(
          8,
          (col) => Zona(),
        ),
      );

      // Configurar o tabuleiro com 8 bombas ao redor da zona central.
      tabuleiroFake[3][3].temBomba = false; // Zona central com bomba

      // Bombas ao redor da zona central
      tabuleiroFake[2][2].temBomba = true;
      tabuleiroFake[2][3].temBomba = true;
      tabuleiroFake[2][4].temBomba = true;
      tabuleiroFake[3][2].temBomba = true;
      tabuleiroFake[3][4].temBomba = true;
      tabuleiroFake[4][2].temBomba = true;
      tabuleiroFake[4][3].temBomba = true;

      // Crie uma instância de CampoMinado usando o tabuleiro fake.
      final campoMinado = CampoMinado.paraTeste(tabuleiroFake);

      // Verifique se o número de bombas adjacentes da zona central é 8.
      expect(campoMinado.tabuleiro[3][3].bombasAdjacentes, 7);
    });
    test(
        'testa se o numero de zonas adjacentes com bomba é apresentado corretamente no caso de 8 bombas',
        () {
      final tabuleiroFake = List.generate(
        8,
        (row) => List.generate(
          8,
          (col) => Zona(),
        ),
      );

      // Configurar o tabuleiro com 8 bombas ao redor da zona central.
      tabuleiroFake[3][3].temBomba = false; // Zona central com bomba

      // Bombas ao redor da zona central
      tabuleiroFake[2][2].temBomba = true;
      tabuleiroFake[2][3].temBomba = true;
      tabuleiroFake[2][4].temBomba = true;
      tabuleiroFake[3][2].temBomba = true;
      tabuleiroFake[3][4].temBomba = true;
      tabuleiroFake[4][2].temBomba = true;
      tabuleiroFake[4][3].temBomba = true;
      tabuleiroFake[4][4].temBomba = true;

      // Crie uma instância de CampoMinado usando o tabuleiro fake.
      final campoMinado = CampoMinado.paraTeste(tabuleiroFake);

      // Verifique se o número de bombas adjacentes da zona central é 8.
      expect(campoMinado.tabuleiro[3][3].bombasAdjacentes, 8);
    });
    test(
        'testa se ao clicar em uma zona que tem zonas adjacentes sem bombas, essas zonas são descobertas também',
        () {
      // Crie um tabuleiro fake.
      final tabuleiroFake = List.generate(
        5,
        (row) => List.generate(
          5,
          (col) => Zona(),
        ),
      );

      // Configurar o tabuleiro com uma zona sem bombas (meio) e zonas adjacentes sem bombas.
      for (int i = 2; i <= 2; i++) {
        for (int j = 2; j <= 2; j++) {
          tabuleiroFake[i][j].temBomba = false; // Zonas sem bombas
        }
      }

      // Crie uma instância de CampoMinado usando o tabuleiro fake.
      final campoMinado = CampoMinado.paraTeste(tabuleiroFake);

      // Chame o método descobrirZona para a zona no meio.
      campoMinado.descobrirZonasAdjacentes(2, 2);

      // Verifique se a zona no meio foi descoberta.
      expect(campoMinado.tabuleiro[2][2].status, 2); // Deve ser descoberto

      // Verifique se as zonas adjacentes sem bombas também foram descobertas.
      for (int i = 1; i <= 3; i++) {
        for (int j = 1; j <= 3; j++) {
          expect(campoMinado.tabuleiro[i][j].status, 2); // Deve ser descoberto
        }
      }
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

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          campoMinado.colocarBandeira(i, j);
          expect(campoMinado.tabuleiro[i][j].status, 1);
          campoMinado.removerBandeira(i, j);
        }
      }
    });
    test(
        "testa se é possivel colocar bandeira em qualquer uma das posições sem problemas na dificuldade intermidiario",
        () {
      int dificuldade = 2;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          campoMinado.colocarBandeira(i, j);
          expect(campoMinado.tabuleiro[i][j].status, 1);
          campoMinado.removerBandeira(i, j);
        }
      }
    });
    test(
        "testa se é possivel colocar bandeira em qualquer uma das posições sem problemas na dificuldade dificil",
        () {
      int dificuldade = 3;
      CampoMinado campoMinado = CampoMinado(dificuldade);

      for (int i = 0; i < campoMinado.tabuleiro.length; i++) {
        for (int j = 0; j < campoMinado.tabuleiro[i].length; j++) {
          campoMinado.colocarBandeira(i, j);
          expect(campoMinado.tabuleiro[i][j].status, 1);
          campoMinado.removerBandeira(i, j);
        }
      }
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
          campoMinado.removerBandeira(i, j);
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
    group(
        'A pontuação do jogo é dada pelo tempo levado para descobrir todas as bombas em segundos',
        () {
      test(
          'testa se o contador de tempo é iniciado ao descobrir a primeira zona sem bomba',
          () {
        int dificuldade = 1;
        CampoMinado campoMinado = CampoMinado(dificuldade);
        outerLoop: //nomeando o for para fazer o break sair de todos os for
        for (int row = 0; row < campoMinado.tabuleiro.length; row++) {
          for (int col = 0; col < campoMinado.tabuleiro[0].length; col++) {
            if (!campoMinado.tabuleiro[row][col].temBomba) {
              campoMinado.descobrirZona(row, col);
              expect(campoMinado.cronometro.isRunning, true);

              break outerLoop;
            }
          }
        }
      });
      // test(
      //     'testa se no fim do jogo (APENAS NO CASO DE VITÓRIA) a pontuação é armazenada com nome do jogador',
      //     () async {
      //   WidgetsFlutterBinding.ensureInitialized();
      //   int dificuldade = 1;
      //   CampoMinado campoMinado = CampoMinado(dificuldade);

      //   for (int row = 0; row < campoMinado.tabuleiro.length; row++) {
      //     for (int col = 0; col < campoMinado.tabuleiro[0].length; col++) {
      //       if (!campoMinado.tabuleiro[row][col].temBomba) {
      //         campoMinado.descobrirZona(row, col);
      //       }
      //     }
      //   }

      //   DBMetodos db = DBMetodos();
      //   Pontuacao pontuacaoRegistrada =
      //       await db.armazenarNovaVitoria('jogador teste123', campoMinado);
      //   db.removerVitoria(pontuacaoRegistrada.id);
      // });
    });

    group(
        'só deve ser possível colocar um número de bandeiras no máximo igual ao número de bombas',
        () {
      test(
          'testa se a contagem de bandeiras colocadas está correta para dificuldade fácil',
          () {
        int dificuldade = 1;
        CampoMinado campoMinado = CampoMinado(dificuldade);

        int bandeirasColocadas = 0;

        outerLoop:
        for (int row = 0; row < campoMinado.tabuleiro.length; row++) {
          for (int col = 0; col < campoMinado.tabuleiro[0].length; col++) {
            // o if impede de tentar colocar bandeiras acima do numero permitido,
            // o numero de bombas
            if (campoMinado.bandeirasColocadas < 10) {
              campoMinado.colocarBandeira(row, col);
              bandeirasColocadas++;
              expect(campoMinado.bandeirasColocadas, bandeirasColocadas);
            } else {
              break outerLoop;
            }
          }
        }
      });
      test(
          'testa se a contagem de bandeiras colocadas está correta para dificuldade intermediario',
          () {
        int dificuldade = 2;
        CampoMinado campoMinado = CampoMinado(dificuldade);

        int bandeirasColocadas = 0;

        outerLoop:
        for (int row = 0; row < campoMinado.tabuleiro.length; row++) {
          for (int col = 0; col < campoMinado.tabuleiro[0].length; col++) {
            // o if impede de tentar colocar bandeiras acima do numero permitido,
            // o numero de bombas
            if (campoMinado.bandeirasColocadas < 30) {
              campoMinado.colocarBandeira(row, col);
              bandeirasColocadas++;
              expect(campoMinado.bandeirasColocadas, bandeirasColocadas);
            } else {
              break outerLoop;
            }
          }
        }
      });
      test(
          'testa se a contagem de bandeiras colocadas está correta para dificuldade dificil',
          () {
        int dificuldade = 3;
        CampoMinado campoMinado = CampoMinado(dificuldade);

        int bandeirasColocadas = 0;

        outerLoop:
        for (int row = 0; row < campoMinado.tabuleiro.length; row++) {
          for (int col = 0; col < campoMinado.tabuleiro[0].length; col++) {
            // o if impede de tentar colocar bandeiras acima do numero permitido,
            // o numero de bombas
            if (campoMinado.bandeirasColocadas < 100) {
              campoMinado.colocarBandeira(row, col);
              bandeirasColocadas++;
              expect(campoMinado.bandeirasColocadas, bandeirasColocadas);
            } else {
              break outerLoop;
            }
          }
        }
      });
      test(
          'deve ser possível colocar bandeiras até no máximo igual ao número de bombas para dificuldade fácil',
          () {
        int dificuldade = 1;
        CampoMinado campoMinado = CampoMinado(dificuldade);

        outerLoop:
        for (int row = 0; row < campoMinado.tabuleiro.length; row++) {
          for (int col = 0; col < campoMinado.tabuleiro[0].length; col++) {
            if (campoMinado.bandeirasColocadas < 10) {
              campoMinado.colocarBandeira(row, col);
            } else {
              break outerLoop;
            }
          }
        }
      });
      test(
          'deve ser possível colocar bandeiras até no máximo igual ao número de bombas para dificuldade intermediário',
          () {
        int dificuldade = 2;
        CampoMinado campoMinado = CampoMinado(dificuldade);

        outerLoop:
        for (int row = 0; row < campoMinado.tabuleiro.length; row++) {
          for (int col = 0; col < campoMinado.tabuleiro[0].length; col++) {
            if (campoMinado.bandeirasColocadas < 30) {
              campoMinado.colocarBandeira(row, col);
            } else {
              break outerLoop;
            }
          }
        }
      });
      test(
          'deve ser possível colocar bandeiras até no máximo igual ao número de bombas para dificuldade dificil',
          () {
        int dificuldade = 3;
        CampoMinado campoMinado = CampoMinado(dificuldade);

        outerLoop:
        for (int row = 0; row < campoMinado.tabuleiro.length; row++) {
          for (int col = 0; col < campoMinado.tabuleiro[0].length; col++) {
            if (campoMinado.bandeirasColocadas < 100) {
              campoMinado.colocarBandeira(row, col);
            } else {
              break outerLoop;
            }
          }
        }
      });
      test(
          'não deve ser possível colocar um número de bandeiras maior que o número de bombas para dificuldade fácil',
          () {
        int dificuldade = 1;
        CampoMinado campoMinado = CampoMinado(dificuldade);

        for (int row = 0; row < campoMinado.tabuleiro.length; row++) {
          for (int col = 0; col < campoMinado.tabuleiro[0].length; col++) {
            if (campoMinado.bandeirasColocadas < 10) {
              campoMinado.colocarBandeira(row, col);
            } else {
              expect(
                () {
                  campoMinado.colocarBandeira(row, col);
                },
                throwsA(isA<NumeroDeBandeirasUltrapassouOMaximoException>()),
              );
            }
          }
        }
      });
      test(
          'não deve ser possível colocar um número de bandeiras maior que o número de bombas para dificuldade intermediario',
          () {
        int dificuldade = 2;
        CampoMinado campoMinado = CampoMinado(dificuldade);

        for (int row = 0; row < campoMinado.tabuleiro.length; row++) {
          for (int col = 0; col < campoMinado.tabuleiro[0].length; col++) {
            if (campoMinado.bandeirasColocadas < 30) {
              campoMinado.colocarBandeira(row, col);
            } else {
              expect(
                () {
                  campoMinado.colocarBandeira(row, col);
                },
                throwsA(isA<NumeroDeBandeirasUltrapassouOMaximoException>()),
              );
            }
          }
        }
      });
      test(
          'não deve ser possível colocar um número de bandeiras maior que o número de bombas para dificuldade dificil',
          () {
        int dificuldade = 3;
        CampoMinado campoMinado = CampoMinado(dificuldade);

        for (int row = 0; row < campoMinado.tabuleiro.length; row++) {
          for (int col = 0; col < campoMinado.tabuleiro[0].length; col++) {
            if (campoMinado.bandeirasColocadas < 100) {
              campoMinado.colocarBandeira(row, col);
            } else {
              expect(
                () {
                  campoMinado.colocarBandeira(row, col);
                },
                throwsA(isA<NumeroDeBandeirasUltrapassouOMaximoException>()),
              );
            }
          }
        }
      });
    });
    group(
        'deve ser possivel ganhar quando colocar bandeira em todas os local de bomba',
        () {
      test(
          'testa se colocando bandeira em todos os locais de bomba faz uma vitória na dificuldade fácil',
          () {
        int dificuldade = 1;
        CampoMinado campoMinado = CampoMinado(dificuldade);

        for (int row = 0; row < campoMinado.tabuleiro.length; row++) {
          for (int col = 0; col < campoMinado.tabuleiro[0].length; col++) {
            if (campoMinado.tabuleiro[row][col].temBomba) {
              campoMinado.colocarBandeira(row, col);
            }
          }
        }
        expect(campoMinado.vitoria, true);
      });
      test(
          'testa se colocando bandeira em todos os locais de bomba faz uma vitória na dificuldade intermediário',
          () {
        int dificuldade = 2;
        CampoMinado campoMinado = CampoMinado(dificuldade);

        for (int row = 0; row < campoMinado.tabuleiro.length; row++) {
          for (int col = 0; col < campoMinado.tabuleiro[0].length; col++) {
            if (campoMinado.tabuleiro[row][col].temBomba) {
              campoMinado.colocarBandeira(row, col);
            }
          }
        }
        expect(campoMinado.vitoria, true);
      });
      test(
          'testa se colocando bandeira em todos os locais de bomba faz uma vitória na dificuldade dificil',
          () {
        int dificuldade = 1;
        CampoMinado campoMinado = CampoMinado(dificuldade);

        for (int row = 0; row < campoMinado.tabuleiro.length; row++) {
          for (int col = 0; col < campoMinado.tabuleiro[0].length; col++) {
            if (campoMinado.tabuleiro[row][col].temBomba) {
              campoMinado.colocarBandeira(row, col);
            }
          }
        }
        expect(campoMinado.vitoria, true);
      });
    });
    group(
        'ao haver uma vitória, todas as zonas com bombas devem ser descobertas',
        () {
      test(
          'testa se havendo vitória todas as zonas com bombas são descobertas na dificuldade fácil',
          () {
        int dificuldade = 1;
        CampoMinado campoMinado = CampoMinado(dificuldade);

        // descobrindo todas as zonas sem bombas
        for (int row = 0; row < campoMinado.tabuleiro.length; row++) {
          for (int col = 0; col < campoMinado.tabuleiro[0].length; col++) {
            if (!campoMinado.tabuleiro[row][col].temBomba) {
              campoMinado.descobrirZonasAdjacentes(row, col);
            }
          }
        }

        // verificando se cada zona com bomba está descoberta
        for (int row = 0; row < campoMinado.tabuleiro.length; row++) {
          for (int col = 0; col < campoMinado.tabuleiro[0].length; col++) {
            if (campoMinado.tabuleiro[row][col].temBomba) {
              expect(campoMinado.tabuleiro[row][col].status, 2);
            }
          }
        }
      });
      test(
          'testa se havendo vitória todas as zonas com bombas são descobertas na dificuldade intermediário',
          () {
        int dificuldade = 2;
        CampoMinado campoMinado = CampoMinado(dificuldade);

        // descobrindo todas as zonas sem bombas
        for (int row = 0; row < campoMinado.tabuleiro.length; row++) {
          for (int col = 0; col < campoMinado.tabuleiro[0].length; col++) {
            if (!campoMinado.tabuleiro[row][col].temBomba) {
              campoMinado.descobrirZonasAdjacentes(row, col);
            }
          }
        }

        // verificando se cada zona com bomba está descoberta
        for (int row = 0; row < campoMinado.tabuleiro.length; row++) {
          for (int col = 0; col < campoMinado.tabuleiro[0].length; col++) {
            if (campoMinado.tabuleiro[row][col].temBomba) {
              expect(campoMinado.tabuleiro[row][col].status, 2);
            }
          }
        }
      });
      test(
          'testa se havendo vitória todas as zonas com bombas são descobertas na dificuldade dificil',
          () {
        int dificuldade = 3;
        CampoMinado campoMinado = CampoMinado(dificuldade);

        // descobrindo todas as zonas sem bombas
        for (int row = 0; row < campoMinado.tabuleiro.length; row++) {
          for (int col = 0; col < campoMinado.tabuleiro[0].length; col++) {
            if (!campoMinado.tabuleiro[row][col].temBomba) {
              campoMinado.descobrirZonasAdjacentes(row, col);
            }
          }
        }

        // verificando se cada zona com bomba está descoberta
        for (int row = 0; row < campoMinado.tabuleiro.length; row++) {
          for (int col = 0; col < campoMinado.tabuleiro[0].length; col++) {
            if (campoMinado.tabuleiro[row][col].temBomba) {
              expect(campoMinado.tabuleiro[row][col].status, 2);
            }
          }
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
