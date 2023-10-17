import 'package:campo_minado_flutter/models/zona.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ZonaWidget extends StatelessWidget {
  final Zona zona;
  const ZonaWidget({super.key, required this.zona});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        border: Border.all(),
        color: _getZonaColor(zona),
      ),
      child: Center(
        child: _getZonaIcon(zona),
      ),
    );
  }

  Color _getZonaColor(Zona zona) {
    if (zona.status == 0) {
      return Colors.grey; // Zona não descoberta.
    } else if (zona.status == 1) {
      return Colors.blue; // Zona com bandeira.
    } else if (zona.temBomba) {
      return Colors.red;
    } else {
      return Colors.white; // Zona descoberta.
    }
  }

  Widget _getZonaIcon(Zona zona) {
    if (zona.status == 2) {
      if (zona.temBomba) {
        return const FaIcon(FontAwesomeIcons.bomb,
            color: Colors.black, size: 24);
      } else {
        return Text(
          zona.bombasAdjacentes > 0 ? zona.bombasAdjacentes.toString() : '',
          style: const TextStyle(fontSize: 20),
        );
      }
    } else if (zona.status == 1) {
      return const FaIcon(FontAwesomeIcons.flag, color: Colors.black, size: 24);
    } else {
      return Container();
    }
  }
}
