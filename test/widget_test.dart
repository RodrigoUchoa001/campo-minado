// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

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
  });
}
