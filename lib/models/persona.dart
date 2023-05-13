import 'package:moviles/models/usuario.dart';
import 'package:moviles/models/conyugue.dart';

class Persona {
  final int pers_id;
  final String pers_cedula;
  final String pers_nombres;
  final String pers_apellidos;
  final String pers_fechaNacimiento;
  final String pers_sexo;
  final String pers_genero;
  final String pers_foto;
  final String pers_estadoCivil;
  final String pers_nivelInstruccion;
  final String pers_profesion;
  final String pers_correo;
  final String pers_celular;
  final String pers_telefono;
  final String pers_nacionalidad;
  final String pers_codigoPostal;
  bool pers_estado;
  

  Persona({
    required this.pers_id,
    required this.pers_cedula,
    required this.pers_nombres,
    required this.pers_apellidos,
    required this.pers_fechaNacimiento,
    required this.pers_sexo,
    required this.pers_genero,
    required this.pers_foto,
    required this.pers_estadoCivil,
    required this.pers_nivelInstruccion,
    required this.pers_profesion,
    required this.pers_correo,
    required this.pers_celular,
    required this.pers_telefono,
    required this.pers_nacionalidad,
    required this.pers_codigoPostal,
    this.pers_estado = false,
   
  });

  factory Persona.fromJson(Map<String, dynamic> json) {
    return Persona(
      pers_id: json['pers_id'],
      pers_cedula: json['pers_cedula'],
      pers_nombres: json['pers_nombres'],
      pers_apellidos: json['pers_apellidos'],
      pers_fechaNacimiento: json['pers_fechaNacimiento'],
      pers_sexo: json['pers_sexo'],
      pers_genero: json['pers_genero'],
      pers_foto: json['pers_foto']??'',
      pers_estadoCivil: json['pers_estadoCivil'],
      pers_nivelInstruccion: json['pers_nivelInstruccion'],
      pers_profesion: json['pers_profesion'],
      pers_correo: json['pers_correo'],
      pers_celular: json['pers_celular'],
      pers_telefono: json['pers_telefono']??'',
      pers_nacionalidad: json['pers_nacionalidad'],
      pers_codigoPostal: json['pers_codigoPostal'],
      pers_estado: json['pers_estado'],
     
      
    );
  }
  void toggle() {
    pers_estado = !pers_estado;
  }
}
