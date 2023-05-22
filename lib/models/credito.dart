import 'sucursal.dart';

import 'anexocredito.dart';

class Credito {
  final int cred_id;
  final String cred_fecha;
  final double cred_monto;
  final String cred_plazo;
  final int cred_numero;
  bool cred_estado;
  final Sucursal sucursal;

  Credito(
      {required this.cred_id,
      required this.cred_fecha,
      required this.cred_monto,
      required this.cred_plazo,
      required this.cred_numero,
      required this.cred_estado,
      required this.sucursal});

  factory Credito.fromJson(Map<String, dynamic> json) {
    return Credito(
      cred_id: json['cred_id'],
      cred_fecha: json['cred_fecha'],
      cred_monto: json['cred_monto'],
      cred_plazo: json['cred_plazo'],
      cred_numero: json['cred_numero'],
      cred_estado: json['cred_estado'],
      sucursal: Sucursal.fromJson(json['sucursal']),
    );
  }
  void toggle() {
    cred_estado = !cred_estado;
  }
}
