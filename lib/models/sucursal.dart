import 'package:moviles/models/usuario.dart';

import 'direccion.dart';
import 'credito.dart';

class Sucursal {
  final int sucu_id;
  bool sucu_estado;
  final Direccion direccion;

  Sucursal({
    required this.sucu_id,
    required this.sucu_estado,
    required this.direccion,
  });

  factory Sucursal.fromJson(Map<String, dynamic> json) {
    return Sucursal(
      sucu_id: json['sucu_id'],
      sucu_estado: json['sucu_estado'],
      direccion: Direccion.fromJson(json['direccion']),
    );
  }

  void toggle() {
    sucu_estado = !sucu_estado;
  }
}
