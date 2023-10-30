import 'dart:io';

import 'package:campo_minado_flutter/db/collections/pontuacao.dart';
import 'package:campo_minado_flutter/exceptions/armazenar_pontuacao_sem_haver_vitoria_exception.dart';
import 'package:campo_minado_flutter/models/campo_minado.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class DBMetodos {
  late Directory dir;
  late Isar isar;

  Future<Pontuacao> armazenarNovaVitoria(
      String nomeDoJogador, CampoMinado campoMinado) async {
    if (!campoMinado.vitoria) {
      throw ArmazenarPontuacaoSemHaverVitoriaException(
          'não é possivel armazenar uma pontuação se não houver vitória');
    }

    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [PontuacaoSchema],
      directory: dir.path,
    );

    final novaPontuacao = Pontuacao()
      ..nomeDoJogador = nomeDoJogador
      ..duracaoEmSegundos = campoMinado.cronometro.elapsedTime.inSeconds
      ..dificuldade = campoMinado.dificuldade;

    await isar.writeTxn(() async {
      await isar.pontuacaos.put(novaPontuacao);
    });

    isar.close();
    return novaPontuacao;
  }

  void removerVitoria(int id) async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [PontuacaoSchema],
      directory: dir.path,
    );

    await isar.pontuacaos.delete(id);
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
