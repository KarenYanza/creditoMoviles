import 'credito.dart';

class AnexoCredito {
  final int aneCred_id;
  final String aneCred_cedulaSolicitante;
  final String aneCred_cedulaConyugue;
  final String aneCred_predios;
  final String aneCred_matriculas;
  final String aneCred_rolesPago;
  final String aneCred_recibosVivienda;
  final String aneCred_remesas;
  final String aneCred_estadoTarjetasCredito;
  final String aneCred_facturasAlimentacion;
  final String aneCred_facturasServicios;
  final String aneCred_facturasSalud;
  final String aneCred_facturasEducacion;
  final String aneCred_facturasOtros;
  bool aneCred_estado;
  final Credito credito;
  //final Sucursal sucursal;

  AnexoCredito({
    required this.aneCred_id,
    required this.aneCred_cedulaSolicitante,
    required this.aneCred_cedulaConyugue,
    required this.aneCred_predios,
    required this.aneCred_matriculas,
    required this.aneCred_rolesPago,
     required this.aneCred_recibosVivienda,
    required this.aneCred_remesas,
    required this.aneCred_estadoTarjetasCredito,
    required this.aneCred_facturasAlimentacion,
    required this.aneCred_facturasServicios,
    required this.aneCred_facturasSalud,
     required this.aneCred_facturasEducacion,
    required this.aneCred_facturasOtros,
    required this.aneCred_estado,
    required this.credito,
    // required this.sucursal,
  });
//0106977176
  factory AnexoCredito.fromJson(Map<String, dynamic> json) {
    return AnexoCredito(
      aneCred_id: json['aneCred_id'],
      aneCred_cedulaSolicitante: json['aneCred_cedulaSolicitante'] ?? '',
      aneCred_cedulaConyugue: json['aneCred_cedulaConyugue'] ?? '',
      aneCred_predios: json['aneCred_predios'] ?? '',
      aneCred_matriculas: json['aneCred_matriculas'] ?? '',
      aneCred_rolesPago: json['aneCred_rolesPago'] ?? '',
      aneCred_recibosVivienda: json['aneCred_recibosVivienda'],
      aneCred_remesas: json['aneCred_remesas'] ?? '',
      aneCred_estadoTarjetasCredito: json['aneCred_estadoTarjetasCredito'] ?? '',
      aneCred_facturasAlimentacion: json['aneCred_facturasAlimentacion'] ?? '',
      aneCred_facturasServicios: json['aneCred_facturasServicios'] ?? '',
      aneCred_facturasSalud: json['aneCred_facturasSalud'] ?? '',
      aneCred_facturasEducacion: json['aneCred_facturasEducacion'],
      aneCred_facturasOtros: json['aneCred_facturasOtros'] ?? '',
      aneCred_estado: json['aneCred_estado'] ?? false,
      //persona: json['persona'] != null ? Persona.fromJson(json['persona']) : Persona(pers_apellidos: '', pers_celular: '', pers_cedula: '', pers_codigoPostal: '', pers_correo: '', pers_estadoCivil: '', pers_fechaNacimiento: '', pers_foto: '', pers_genero: '', pers_id: 0, pers_nacionalidad: '', pers_nivelInstruccion: '', pers_nombres: '', pers_profesion: '', pers_sexo: '', pers_telefono: ''),
      credito: Credito.fromJson(json['credito'] ?? ''),
      //rol: json['rol'] != null ? Rol.fromJson(json['rol']) : Rol(rol_descripcion: '', rol_id:0 , rol_nombre: ''),
      //sucursal: Sucursal.fromJson(json['sucursal']),
    );
  }
}
