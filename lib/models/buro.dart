import 'solicitud.dart';
import 'tablaburo.dart';

class Buro {
  final int buro_id;
  final String buro_deudasVencidas;
  bool buro_estado;
  final TablaBuro tablaBuro;
  final Solicitud solicitud;
  //final Sucursal sucursal;

  Buro({
    required this.buro_id,
    required this.buro_deudasVencidas,
    required this.buro_estado,
    required this.tablaBuro,
    required this.solicitud,
    // required this.sucursal,
  });
//0106977176
  factory Buro.fromJson(Map<String, dynamic> json) {
    return Buro(
      buro_id: json['buro_id'],
      buro_deudasVencidas: json['buro_deudasVencidas'] ?? '',
      buro_estado: json['buro_estado'] ?? false,
      tablaBuro: TablaBuro.fromJson(json['tablaBuro'] ?? ''),
      //persona: json['persona'] != null ? Persona.fromJson(json['persona']) : Persona(pers_apellidos: '', pers_celular: '', pers_cedula: '', pers_codigoPostal: '', pers_correo: '', pers_estadoCivil: '', pers_fechaNacimiento: '', pers_foto: '', pers_genero: '', pers_id: 0, pers_nacionalidad: '', pers_nivelInstruccion: '', pers_nombres: '', pers_profesion: '', pers_sexo: '', pers_telefono: ''),
      solicitud: Solicitud.fromJson(json['solicitud'] ?? ''),
      //rol: json['rol'] != null ? Rol.fromJson(json['rol']) : Rol(rol_descripcion: '', rol_id:0 , rol_nombre: ''),
      //sucursal: Sucursal.fromJson(json['sucursal']),
    );
  }
}
