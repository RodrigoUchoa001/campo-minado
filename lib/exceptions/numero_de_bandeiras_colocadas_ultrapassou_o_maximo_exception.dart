class NumeroDeBandeirasUltrapassouOMaximoException implements Exception {
  final String mensagem;

  NumeroDeBandeirasUltrapassouOMaximoException(this.mensagem);

  @override
  String toString() {
    return 'NumeroDeBandeirasUltrapassouOMaximoException: $mensagem';
  }
}
