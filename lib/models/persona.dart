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
  final Usuario usuario;
  final Conyugue conyugue;

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
    required this.usuario,
    required this.conyugue,
  });

  factory Persona.fromMap(Map personamap) {
    return Persona(
      pers_id: personamap['pers_id'],
      pers_cedula: personamap['pers_cedula'],
      pers_nombres: personamap['pers_nombres'],
      pers_apellidos: personamap['pers_apellidos'],
      pers_fechaNacimiento: personamap['pers_fechaNacimiento'],
      pers_sexo: personamap['pers_sexo'],
      pers_genero: personamap['pers_genero'],
      pers_foto: personamap['pers_foto'],
      pers_estadoCivil: personamap['pers_estadoCivil'],
      pers_nivelInstruccion: personamap['pers_nivelInstruccion'],
      pers_profesion: personamap['pers_profesion'],
      pers_correo: personamap['pers_correo'],
      pers_celular: personamap['pers_celular'],
      pers_telefono: personamap['pers_telefono'],
      pers_nacionalidad: personamap['pers_nacionalidad'],
      pers_codigoPostal: personamap['pers_codigoPostal'],
      pers_estado: personamap['pers_estado'],
      usuario: personamap['usuario'],
      conyugue: personamap['conyugue'],
    );
  }
  void toggle() {
    pers_estado = !pers_estado;
  }
}
