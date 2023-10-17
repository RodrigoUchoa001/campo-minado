import 'package:campo_minado_flutter/models/zona.dart';
import 'package:flutter/material.dart';

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
    } else {
      return Colors.white; // Zona descoberta.
    }
  }

  Widget _getZonaIcon(Zona zona) {
    if (zona.status == 2) {
      if (zona.temBomba) {
        return const Icon(Icons.zoom_out_map, color: Colors.black, size: 24);
      } else {
        return Text(
          zona.bombasAdjacentes > 0 ? zona.bombasAdjacentes.toString() : '',
          style: const TextStyle(fontSize: 20),
        );
      }
    } else if (zona.status == 1) {
      return const Icon(Icons.flag, color: Colors.black, size: 24);
    } else {
      return Container();
    }
  }
}
