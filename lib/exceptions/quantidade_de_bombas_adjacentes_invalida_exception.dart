class QuantidadeDeBombasAdjacentesInvalidaException implements Exception {
  final String mensagem;

  QuantidadeDeBombasAdjacentesInvalidaException(this.mensagem);

  @override
  String toString() {
    return 'QuantidadeDeBombasAdjacentesInvalidaException: $mensagem';
  }
}
