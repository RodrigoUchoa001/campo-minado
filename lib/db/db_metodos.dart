import 'dart:io';

import 'package:campo_minado_flutter/db/collections/pontuacao.dart';
import 'package:campo_minado_flutter/exceptions/dificuldade_escolhida_invalidada_excepcion.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class DBMetodos {
  late Directory dir;
  late Isar isar;

  void armazenarNovaVitoria(
      String nomeDoJogador, Duration duracao, int dificuldade) async {
    if (dificuldade < 1 || dificuldade > 3) {
      throw DificuldadeEscolhidaInvalidaException(
          'dificuldade escolhida inválida');
    }

    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [PontuacaoSchema],
      directory: dir.path,
    );

    final novaPontuacao = Pontuacao()
      ..nomeDoJogador = nomeDoJogador
      ..duracaoEmSegundos = duracao.inSeconds
      ..dificuldade = dificuldade;

    await isar.writeTxn(() async {
      await isar.pontuacaos.put(novaPontuacao);
    });

    isar.close();
  }

  Future<List<Pontuacao>> listarTodasVitoriasFacil() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [PontuacaoSchema],
      directory: dir.path,
    );

    final pontuacoes = isar.pontuacaos
        .where()
        .filter()
        .dificuldadeEqualTo(1)
        .sortByDuracaoEmSegundos()
        .findAll();

    isar.close();

    return pontuacoes;
  }

  Future<List<Pontuacao>> listarTodasVitoriasIntermediario() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [PontuacaoSchema],
      directory: dir.path,
    );

    final pontuacoes = isar.pontuacaos
        .where()
        .filter()
        .dificuldadeEqualTo(2)
        .sortByDuracaoEmSegundos()
        .findAll();

    isar.close();

    return pontuacoes;
  }

  Future<List<Pontuacao>> listarTodasVitoriasDificil() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [PontuacaoSchema],
      directory: dir.path,
    );

    final pontuacoes = isar.pontuacaos
        .where()
        .filter()
        .dificuldadeEqualTo(3)
        .sortByDuracaoEmSegundos()
        .findAll();

    isar.close();

    return pontuacoes;
  }
}
