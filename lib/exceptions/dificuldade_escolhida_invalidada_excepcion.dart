class DificuldadeEscolhidaInvalidaException implements Exception {
  final String mensagem;

  DificuldadeEscolhidaInvalidaException(this.mensagem);

  @override
  String toString() {
    return 'DificuldadeEscolhidaInvalidaException: $mensagem';
  }
}
