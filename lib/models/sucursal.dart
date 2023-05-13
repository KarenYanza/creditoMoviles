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

  factory Sucursal.fromJson(Map<String, dynamic> json) {
    return Sucursal(
      sucu_id: json['sucu_id'],
      sucu_estado: json['sucu_estado'],
      usuario: Usuario.fromJson(json['usuario']),
      direccion: Direccion.fromJson(json['direccion']),
      credito: Credito.fromJson(json['credito']),
    );
  }
  
  void toggle() {
    sucu_estado = !sucu_estado;
  }
}
