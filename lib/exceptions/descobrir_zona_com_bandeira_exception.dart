class DescobrirZonaComBandeiraException implements Exception {
  final String mensagem;

  DescobrirZonaComBandeiraException(this.mensagem);

  @override
  String toString() {
    return 'DescobrirZonaComBandeiraException: $mensagem';
  }
}
