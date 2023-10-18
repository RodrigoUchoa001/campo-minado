class TentativaDeAlteracaoDeBombaException implements Exception {
  final String mensagem;

  TentativaDeAlteracaoDeBombaException(this.mensagem);

  @override
  String toString() {
    return 'TentativaDeAlteracaoDeBombaException: $mensagem';
  }
}
