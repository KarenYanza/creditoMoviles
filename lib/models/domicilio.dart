import 'direccion.dart';
import 'solicitud.dart';

class Domicilio {
  final int domi_id;
  final String domi_color;
  final String domi_tenencia;
  bool domi_hipoteca;
  final int domi_aniosResidencia;
  final String domi_referencia;
  final String domi_propietario;
  final String domi_telefonPropietario;
  bool domi_estado;
  final Direccion direccion;
  final Solicitud solicitud;
  //final Sucursal sucursal;

  Domicilio({
    required this.domi_id,
    required this.domi_color,
    required this.domi_tenencia,
    required this.domi_hipoteca,
    required this.domi_aniosResidencia,
    required this.domi_referencia,
    required this.domi_propietario,
    required this.domi_telefonPropietario,
    required this.domi_estado,
    required this.direccion,
    required this.solicitud,
   // required this.sucursal,
  });
//0106977176
  factory Domicilio.fromJson(Map<String, dynamic> json) {
    return Domicilio(
      domi_id: json['domi_id'],
      domi_color: json['domi_color']?? '',
      domi_tenencia: json['domi_tenencia']?? '',
      domi_hipoteca: json['domi_hipoteca'] ?? '',
      domi_aniosResidencia: json['domi_aniosResidencia'] ?? '',
      domi_referencia: json['domi_referencia'] ?? '',
      domi_propietario: json['domi_propietario'] ?? '',
      domi_telefonPropietario: json['domi_telefonPropietario'] ?? '',
      domi_estado: json['domi_estado'] ?? false,
      direccion: Direccion.fromJson(json['direccion'] ?? ''),
      //persona: json['persona'] != null ? Persona.fromJson(json['persona']) : Persona(pers_apellidos: '', pers_celular: '', pers_cedula: '', pers_codigoPostal: '', pers_correo: '', pers_estadoCivil: '', pers_fechaNacimiento: '', pers_foto: '', pers_genero: '', pers_id: 0, pers_nacionalidad: '', pers_nivelInstruccion: '', pers_nombres: '', pers_profesion: '', pers_sexo: '', pers_telefono: ''),
      solicitud: Solicitud.fromJson(json['solicitud']??''),
      //rol: json['rol'] != null ? Rol.fromJson(json['rol']) : Rol(rol_descripcion: '', rol_id:0 , rol_nombre: ''),
    //sucursal: Sucursal.fromJson(json['sucursal']),
    );
  }
}