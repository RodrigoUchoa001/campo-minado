/// classe que representa uma zona do campo minado
/// 0 = coberto
/// 1 = com bandeira
/// 2 = descoberto
class Zona {
  late int _status = 0;
  late bool _temBomba;

  int get status => _status;

  /// impede de alterar o valor do status após ser setado pela primeira vez
  set status(int status) {
    if (_status != 0 || _status != 1 || _status != 2) {
      _status = status;
    }
  }

  bool get temBomba => _temBomba;

  /// impede de alterar o valor do temBomba após ser setado pela primeira vez
  set temBomba(bool temBomba) {
    if (_temBomba != true || _temBomba != false) {
      _temBomba = temBomba;
    }
  }
}
