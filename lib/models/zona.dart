import 'package:campo_minado_flutter/exceptions/bandeira_em_zona_descoberta_exception.dart';
import 'package:campo_minado_flutter/exceptions/descobrir_zona_com_bandeira_exception.dart';
import 'package:campo_minado_flutter/exceptions/remover_bandeira_de_zona_sem_bandeira_exception.dart';

/// classe que representa uma zona do campo minado
/// 0 = coberto
/// 1 = com bandeira
/// 2 = descoberto
class Zona {
  int _status = 0;
  bool _temBomba = false;

  int get status => _status;

  void colocarBandeira() {
    _status = 1;
  }

  void removerBandeira() {
    if (_status == 1) {
      _status = 0;
    } else {
      throw RemoverBandeiraDeZonaSemBandeiraException(
          "Não é possivel remover bandeira de zona que não há bandeira");
    }
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
