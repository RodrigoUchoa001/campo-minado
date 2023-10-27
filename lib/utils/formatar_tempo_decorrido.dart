String formatarTempoDecorrido(Duration tempoDecorrido) {
  return '${tempoDecorrido.inMinutes.remainder(60).toString().padLeft(2, '0')}:${tempoDecorrido.inSeconds.remainder(60).toString().padLeft(2, '0')}';
}
