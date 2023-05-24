
class AnexoCredito {
  final int persid;
  final int soliid;
  final double ane_credid;
  String ane_cred_cedula_conyugue;
  String ane_cred_cedula_solicitante;
  final bool ane_cred_estado;
  String ane_cred_estado_tarjetas_credito;
  String ane_cred_facturas_alimentacion;
  String ane_cred_facturas_educacion;
  String ane_cred_facturas_otros;
  String ane_cred_facturas_salud;
  String ane_cred_facturas_servicios;
  String ane_cred_matriculas;
  String ane_cred_predios;
  String ane_cred_recibos_vivienda;
  String ane_cred_remesas;
  String ane_cred_roles_pago;
  final int credid;
  final String nombres;
  String base64String;
  //final Sucursal sucursal;

  AnexoCredito({
    required this.persid,
    required this.soliid,
    required this.ane_credid,
    required this.ane_cred_cedula_conyugue,
    required this.ane_cred_cedula_solicitante,
    required this.ane_cred_estado,
    required this.ane_cred_estado_tarjetas_credito,
    required this.ane_cred_facturas_alimentacion,
    required this.ane_cred_facturas_educacion,
    required this.ane_cred_facturas_otros,
    required this.ane_cred_facturas_salud,
    required this.ane_cred_facturas_servicios,
    required this.ane_cred_matriculas,
    required this.ane_cred_predios,
    required this.ane_cred_recibos_vivienda,
    required this.ane_cred_remesas,
    required this.ane_cred_roles_pago,
    required this.credid,
    required this.nombres,
    required this.base64String,
    // required this.sucursal,
  });
//0106977176
  factory AnexoCredito.fromJson(Map<String, dynamic> json) {
    return AnexoCredito(
      persid: json['persid'] ?? 0,
      soliid: json['soliid'] ?? 0,
      ane_credid: json['ane_credid'] ?? 0,
      ane_cred_cedula_conyugue: json['ane_cred_cedula_conyugue'] ?? '',
      ane_cred_cedula_solicitante: json['ane_cred_cedula_solicitante'] ?? '',
      ane_cred_estado: json['ane_cred_estado'] ?? false,
      ane_cred_estado_tarjetas_credito:
          json['ane_cred_estado_tarjetas_credito'] ?? '',
      ane_cred_facturas_alimentacion:
          json['ane_cred_facturas_alimentacion'] ?? '',
      ane_cred_facturas_educacion: json['ane_cred_facturas_educacion'] ?? '',
      ane_cred_facturas_otros: json['ane_cred_facturas_otros'] ?? '',
      ane_cred_facturas_salud: json['ane_cred_facturas_salud'] ?? '',
      ane_cred_facturas_servicios: json['ane_cred_facturas_servicios'] ?? '',
      ane_cred_matriculas: json['ane_cred_matriculas'] ?? '',
      ane_cred_predios: json['ane_cred_predios'] ?? '',
      ane_cred_recibos_vivienda: json['ane_cred_recibos_vivienda'] ?? '',
      ane_cred_remesas: json['ane_cred_remesas'] ?? '',
      ane_cred_roles_pago: json['ane_cred_roles_pago'] ?? '',
      credid: json['credid'] ?? 0,
      nombres: json['nombres'] ?? '',
      base64String: json['base64String'] ?? '',
    );
  }
}
