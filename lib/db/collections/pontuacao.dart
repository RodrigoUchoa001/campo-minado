import 'package:isar/isar.dart';

part 'pontuacao.g.dart';

@collection
class Pontuacao {
  Id id = Isar
      .autoIncrement; // você também pode attribuir id = null para incrementar automaticamente

  late String nomeDoJogador;
  late int duracaoEmSegundos;
  late int dificuldade;
}
