class BandeiraEmZonaDescobertaException implements Exception {
  final String mensagem;

  BandeiraEmZonaDescobertaException(this.mensagem);

  @override
  String toString() {
    return 'BandeiraEmZonaDescobertaException: $mensagem';
  }
}
