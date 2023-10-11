class RemoverBandeiraDeZonaSemBandeiraException implements Exception {
  final String mensagem;

  RemoverBandeiraDeZonaSemBandeiraException(this.mensagem);

  @override
  String toString() {
    return 'RemoverBandeiraDeZonaSemBandeiraException: $mensagem';
  }
}
