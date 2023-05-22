import 'package:moviles/models/sucursal.dart';

class Solicitud1 {
  final int soliid;
  final String cred_fecha;
  final double cred_monto;
  final String soli_estado_registro;
  final String usuario_username;
  Solicitud1(
      {required this.soliid,
      required this.cred_fecha,
      required this.cred_monto,
      required this.soli_estado_registro,
      required this.usuario_username});
  factory Solicitud1.fromJson(Map<String, dynamic> json) {
    return Solicitud1(
      soliid: json['soliid'] ?? 0,
      cred_fecha: json['cred_fecha'] ?? '',
      cred_monto: json['cred_monto'] ?? 0,
      soli_estado_registro: json['soli_estado_registro'] ?? '',
      usuario_username: json['usuario_username'] ?? '',
    );
  }
}
