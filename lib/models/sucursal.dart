import 'package:moviles/models/usuario.dart';

import 'direccion.dart';
import 'credito.dart';

class Sucursal {
  final int sucu_id;
  final String sucu_nombre;
  final bool sucu_estado;
  final Direccion direccion;

  Sucursal({
    required this.sucu_id,
    required this.sucu_nombre,
    required this.sucu_estado,
    required this.direccion,
  });

  factory Sucursal.fromJson(Map<String, dynamic> json) {
    return Sucursal(
      sucu_id: json['sucu_id'] ?? 0,
      sucu_nombre: json['sucu_nombre'] ?? '',
      sucu_estado: json['sucu_estado'] ?? false,
      direccion: Direccion.fromJson(json['direccion'] ?? ''),
    );
  }
}
