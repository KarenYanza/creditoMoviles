import 'solicitud.dart';

class Ingresos {
  final int ingr_id;
  final double ingr_sueldoMensual;
  final double ingr_sueldoConyugue;
  final double ingr_remesas;
  final double ingr_pensionJubilados;
  final double ingr_ingresosServicios;
  final double ingr_otrosIngresos;
  final double ingr_totalIngresos;
  bool ingr_estado;
  final Solicitud solicitud;
  //final Sucursal sucursal;

  Ingresos({
    required this.ingr_id,
    required this.ingr_sueldoMensual,
    required this.ingr_sueldoConyugue,
    required this.ingr_remesas,
    required this.ingr_pensionJubilados,
    required this.ingr_ingresosServicios,
    required this.ingr_otrosIngresos,
    required this.ingr_totalIngresos,
    required this.ingr_estado,
    required this.solicitud,
    // required this.sucursal,
  });
//0106977176
  factory Ingresos.fromJson(Map<String, dynamic> json) {
    return Ingresos(
      ingr_id: json['ingr_id'],
      ingr_sueldoMensual: json['ingr_sueldoMensual'] ?? '',
      ingr_sueldoConyugue: json['ingr_sueldoConyugue'] ?? '',
      ingr_remesas: json['ingr_remesas'] ?? '',
      ingr_pensionJubilados: json['ingr_pensionJubilados'] ?? '',
      ingr_ingresosServicios: json['ingr_ingresosServicios'] ?? '',
      ingr_otrosIngresos: json['ingr_otrosIngresos'] ?? '',
      ingr_totalIngresos: json['ingr_totalIngresos'] ?? '',
      ingr_estado: json['ingr_estado'] ?? false,
      solicitud: Solicitud.fromJson(json['solicitud'] ?? ''),
      //persona: json['persona'] != null ? Persona.fromJson(json['persona']) : Persona(pers_apellidos: '', pers_celular: '', pers_cedula: '', pers_codigoPostal: '', pers_correo: '', pers_estadoCivil: '', pers_fechaNacimiento: '', pers_foto: '', pers_genero: '', pers_id: 0, pers_nacionalidad: '', pers_nivelInstruccion: '', pers_nombres: '', pers_profesion: '', pers_sexo: '', pers_telefono: ''),
      //rol: json['rol'] != null ? Rol.fromJson(json['rol']) : Rol(rol_descripcion: '', rol_id:0 , rol_nombre: ''),
      //sucursal: Sucursal.fromJson(json['sucursal']),
    );
  }
}
