import 'dart:async';

class Cronometro {
  final _stopwatch = Stopwatch();
  Duration _elapsedTime = Duration.zero;
  final _elapsedTimeStream = StreamController<Duration>.broadcast();

  // Getter para o stream
  Stream<Duration> get elapsedTimeStream => _elapsedTimeStream.stream;

  bool get isRunning => _stopwatch.isRunning;

  Duration get elapsedTime => _elapsedTime;

  void start() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      _updateTimer();
    }
  }

  void stop() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
    }
  }

  void reset() {
    _stopwatch.reset();
    _elapsedTime = Duration.zero;
  }

  void _updateTimer() {
    if (_stopwatch.isRunning) {
      _elapsedTime = _stopwatch.elapsed;
      _elapsedTimeStream.add(_elapsedTime); // Notifique os ouvintes do stream
      Future.delayed(const Duration(milliseconds: 100), _updateTimer);
    }
  }
}
