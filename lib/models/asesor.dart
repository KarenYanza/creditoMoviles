class Asesor {
  final int soliid;
  final String cred_fecha;
  final double cred_monto;
  final String soli_estado_registro;
  final String usuario_username;
  final int sucuid;
  final String nombres;
  final String correo_username;
  Asesor(
      {required this.soliid,
      required this.cred_fecha,
      required this.cred_monto,
      required this.soli_estado_registro,
      required this.usuario_username,
      required this.sucuid,
      required this.nombres,
      required this.correo_username});

  factory Asesor.fromJson(Map<String, dynamic> json) {
    return Asesor(
      soliid: json['soliid'] ?? 0,
      cred_fecha: json['cred_fecha'] ?? '',
      cred_monto: json['cred_monto'] ?? 0,
      soli_estado_registro: json['soli_estado_registro'] ?? '',
      usuario_username: json['usuario_username'] ?? '',
      sucuid: json['sucuid'] ?? 0,
      nombres: json['nombres'] ?? '',
      correo_username: json['pers_correo'] ?? '',
    );
  }
}
