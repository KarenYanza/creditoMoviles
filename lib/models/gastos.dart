import 'solicitud.dart';

class Gastos {
  final int gast_id;
  final double gast_alimentacion;
  final double gast_vivienda;
  final double gast_salud;
  final double gast_educacion;
  final double gast_serviciosBasicos;
  final double gast_otros;
  final double gast_totalGastos;
  final double gast_estado;
  final Solicitud solicitud;
  //final Sucursal sucursal;

  Gastos({
    required this.gast_id,
    required this.gast_alimentacion,
    required this.gast_vivienda,
    required this.gast_salud,
    required this.gast_educacion,
    required this.gast_serviciosBasicos,
    required this.gast_otros,
    required this.gast_totalGastos,
    required this.gast_estado,
    required this.solicitud,
    // required this.sucursal,
  });
//0106977176
  factory Gastos.fromJson(Map<String, dynamic> json) {
    return Gastos(
      gast_id: json['gast_id'],
      gast_alimentacion: json['gast_alimentacion'] ?? '',
      gast_vivienda: json['gast_vivienda'] ?? '',
      gast_salud: json['gast_salud'] ?? '',
      gast_educacion: json['gast_educacion'] ?? '',
      gast_serviciosBasicos: json['gast_serviciosBasicos'] ?? '',
      gast_otros: json['gast_otros'] ?? '',
      gast_totalGastos: json['gast_totalGastos'] ?? '',
      gast_estado: json['gast_estado'] ?? '',
      //persona: json['persona'] != null ? Persona.fromJson(json['persona']) : Persona(pers_apellidos: '', pers_celular: '', pers_cedula: '', pers_codigoPostal: '', pers_correo: '', pers_estadoCivil: '', pers_fechaNacimiento: '', pers_foto: '', pers_genero: '', pers_id: 0, pers_nacionalidad: '', pers_nivelInstruccion: '', pers_nombres: '', pers_profesion: '', pers_sexo: '', pers_telefono: ''),
      solicitud: Solicitud.fromJson(json['solicitud'] ?? ''),
      //rol: json['rol'] != null ? Rol.fromJson(json['rol']) : Rol(rol_descripcion: '', rol_id:0 , rol_nombre: ''),
      //sucursal: Sucursal.fromJson(json['sucursal']),
    );
  }
}
