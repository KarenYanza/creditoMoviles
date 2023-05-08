import 'package:moviles/models/usuario.dart';

import 'direccion.dart';
import 'credito.dart';

class Sucursal {
  final int sucu_id;
  bool sucu_estado;
  final Usuario usuario;
  final Direccion direccion;
  final Credito credito;

  Sucursal({
    required this.sucu_id,
    required this.sucu_estado,
    required this.usuario,
    required this.direccion,
    required this.credito,
  });

  factory Sucursal.fromMap(Map sucursalmap) {
    return Sucursal(
      sucu_id: sucursalmap['sucu_id'],
      sucu_estado: sucursalmap['sucu_estado'],
      usuario: sucursalmap['usuario'],
      direccion: sucursalmap['direccion'],
      credito: sucursalmap['credito'],
    );
  }
  
  void toggle() {
    sucu_estado = !sucu_estado;
  }
}
