import 'package:campo_minado_flutter/exceptions/bandeira_em_zona_descoberta_exception.dart';
import 'package:campo_minado_flutter/exceptions/descobrir_zona_com_bandeira_exception.dart';

/// classe que representa uma zona do campo minado
/// 0 = coberto
/// 1 = com bandeira
/// 2 = descoberto
class Zona {
  int _status = 0;
  bool _temBomba = false;

  int get status => _status;

  // set status(int status) {
  //   if (status == 1 && _status == 2) {
  //     throw BandeiraEmZonaDescobertaException(
  //         "não se pode colocar bandeira em zona descoberta!");
  //   }
  //   _status = status;
  // }

  void colocarBandeira() {
    _status = 1;
  }

  void removerBandeira() {
    _status = 0;
  }

  void descobrirZona() {
    if (_status == 0) {
      _status = 2;
    } else {
      throw DescobrirZonaComBandeiraException(
          "Não é possivel descobrir zona com bandeira");
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
