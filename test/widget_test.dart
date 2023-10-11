// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:campo_minado_flutter/exceptions/bandeira_em_zona_descoberta_exception.dart';
import 'package:campo_minado_flutter/models/tabuleiro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:campo_minado_flutter/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  group("Testes de Zonas", () {
    test("testa se todas as zonas começam cobertas", () {
      int dificuldade = 1;
      Tabuleiro tabuleiro = Tabuleiro(dificuldade);

      bool temDiferenteDeCoberto = false;

      for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
          if (tabuleiro.tabuleiro[i][j].status != 0) {
            temDiferenteDeCoberto = true;
          }
        }
      }

      expect(temDiferenteDeCoberto, false);
    });
    test("todas as zonas começam como sem bandeira", () {
      int dificuldade = 1;
      Tabuleiro tabuleiro = Tabuleiro(dificuldade);

      bool temZonaComBandeira = false;

      for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
          if (tabuleiro.tabuleiro[i][j].status != 0) {
            temZonaComBandeira = true;
          }
        }
      }

      expect(temZonaComBandeira, false);
    });
    test(
      "não se pode colocar bandeira em zona descoberta",
      () => expect(
        () {
          int dificuldade = 1;
          Tabuleiro tabuleiro = Tabuleiro(dificuldade);

          tabuleiro.tabuleiro[0][0].status = 2;
          tabuleiro.tabuleiro[0][0].status = 1;
        },
        throwsA(isA<BandeiraEmZonaDescobertaException>()),
      ),
    );
  });
  group('testes de tabuleiro', () {
    test("testa se escolhendo dificuldade fácil o tabuleiro tem 8x8", () {
      int dificuldade = 1;
      Tabuleiro tabuleiro = Tabuleiro(dificuldade);

      int numLinhas = tabuleiro.tabuleiro.length;
      int numColunas = tabuleiro.tabuleiro[0].length;

      expect(numLinhas, 8);
      expect(numColunas, 8);
    });
    test("testa se escolhendo dificuldade médio o tabuleiro tem 10x16", () {
      int dificuldade = 2;
      Tabuleiro tabuleiro = Tabuleiro(dificuldade);

      int numLinhas = tabuleiro.tabuleiro.length;
      int numColunas = tabuleiro.tabuleiro[0].length;

      expect(numLinhas, 10);
      expect(numColunas, 16);
    });
    test("testa se escolhendo dificuldade dificil o tabuleiro tem 24x24", () {
      int dificuldade = 3;
      Tabuleiro tabuleiro = Tabuleiro(dificuldade);

      int numLinhas = tabuleiro.tabuleiro.length;
      int numColunas = tabuleiro.tabuleiro[0].length;

      expect(numLinhas, 24);
      expect(numColunas, 24);
    });
    test('testa se na dificuldade fácil o numero de bombas é 10', () {
      int dificuldade = 1;
      Tabuleiro tabuleiro = Tabuleiro(dificuldade);

      int quantidadeDeBombas = 0;

      for (int i = 0; i < tabuleiro.tabuleiro.length; i++) {
        for (int j = 0; j < tabuleiro.tabuleiro[i].length; j++) {
          if (tabuleiro.tabuleiro[i][j].temBomba) {
            quantidadeDeBombas++;
          }
        }
      }

      expect(quantidadeDeBombas, 10);
    });
    test('testa se na dificuldade médio o numero de bombas é 30', () {
      int dificuldade = 2;
      Tabuleiro tabuleiro = Tabuleiro(dificuldade);

      int quantidadeDeBombas = 0;

      for (int i = 0; i < tabuleiro.tabuleiro.length; i++) {
        for (int j = 0; j < tabuleiro.tabuleiro[i].length; j++) {
          if (tabuleiro.tabuleiro[i][j].temBomba) {
            quantidadeDeBombas++;
          }
        }
      }

      expect(quantidadeDeBombas, 30);
    });
    test('testa se na dificuldade dificil o numero de bombas é 100', () {
      int dificuldade = 3;
      Tabuleiro tabuleiro = Tabuleiro(dificuldade);

      int quantidadeDeBombas = 0;

      for (int i = 0; i < tabuleiro.tabuleiro.length; i++) {
        for (int j = 0; j < tabuleiro.tabuleiro[i].length; j++) {
          if (tabuleiro.tabuleiro[i][j].temBomba) {
            quantidadeDeBombas++;
          }
        }
      }

      expect(quantidadeDeBombas, 100);
    });
  });
}
