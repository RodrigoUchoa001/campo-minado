import 'package:campo_minado_flutter/exceptions/bandeira_em_zona_descoberta_exception.dart';
import 'package:campo_minado_flutter/exceptions/descobrir_zona_com_bandeira_exception.dart';
import 'package:campo_minado_flutter/exceptions/quantidade_de_bombas_adjacentes_invalida_exception.dart';
import 'package:campo_minado_flutter/exceptions/remover_bandeira_de_zona_sem_bandeira_exception.dart';
import 'package:campo_minado_flutter/exceptions/tentativa_de_alteracao_de_bomba_exception.dart';

/// classe que representa uma zona do campo minado
/// 0 = coberto
/// 1 = com bandeira
/// 2 = descoberto
class Zona {
  int _status = 0;
  bool _temBomba = false;
  int _bombasAdjacentes = 0;

  bool _temBombaDefinida = false;

  int get status => _status;
  bool get temBomba => _temBomba;
  int get bombasAdjacentes => _bombasAdjacentes;

  set bombasAdjacentes(int numBombasAdjacentes) {
    if (numBombasAdjacentes >= 0 && numBombasAdjacentes <= 8) {
      _bombasAdjacentes = numBombasAdjacentes;
    } else {
      throw QuantidadeDeBombasAdjacentesInvalidaException(
          "O numero de bombas adjacentes foi menor que 0 ou mair que 8");
    }
  }

  void colocarBandeira() {
    if (_status == 0) {
      _status = 1;
    } else {
      throw BandeiraEmZonaDescobertaException(
          "Não se pode colocar bandeira em zona descoberta");
    }
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
    } else if (_status == 2) {
    } else {
      throw DescobrirZonaComBandeiraException(
          "Não é possivel descobrir zona com bandeira");
    }
  }

  // apenas para alteracao visual ao vencer
  void forcarDescobrirZona() {
    _status = 2;
  }

  /// impede de alterar o valor do temBomba após ser setado pela primeira vez
  set temBomba(bool temBomba) {
    if (!_temBombaDefinida) {
      _temBomba = temBomba;
      _temBombaDefinida = true;
    } else {
      throw TentativaDeAlteracaoDeBombaException(
          'não é possível alterar o atributo temBomba após já ser modificado uma primeira vez');
    }
  }
}
