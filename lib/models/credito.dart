import 'package:moviles/models/sucursal.dart';

class Credito {
  final int cred_id;
  final String cred_fecha;
  final int cred_monto;
  final String cred_plazo;
  final int cred_numero;
  bool cred_estado;
  final Sucursal sucursal;
 
  Credito({
    required this.cred_id,
    required this.cred_fecha,
    required this.cred_monto,
    required this.cred_plazo,
    required this.cred_numero,
    required this.cred_estado,
    required this.sucursal,

  });

  factory Credito.fromMap(Map creditomap) {
    return Credito(
      cred_id: creditomap['cred_id'],
      cred_fecha: creditomap['cred_fecha'],
      cred_monto: creditomap['cred_monto'],
      cred_plazo: creditomap['cred_plazo'],
      cred_numero: creditomap['cred_numero'],
      cred_estado: creditomap['cred_estado'],
      sucursal: creditomap['sucursal'],
      );
  }
  
  void toggle() {
    cred_estado = !cred_estado;
  }
}
