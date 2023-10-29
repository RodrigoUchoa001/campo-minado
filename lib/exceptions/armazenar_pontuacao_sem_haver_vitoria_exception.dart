class ArmazenarPontuacaoSemHaverVitoriaException implements Exception {
  final String mensagem;

  ArmazenarPontuacaoSemHaverVitoriaException(this.mensagem);

  @override
  String toString() {
    return 'ArmazenarPontuacaoSemHaverVitoriaException: $mensagem';
  }
}
