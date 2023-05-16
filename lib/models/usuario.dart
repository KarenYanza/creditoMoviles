import 'dart:convert';

import 'package:moviles/models/persona.dart';
import 'package:moviles/models/rol.dart';
import 'package:moviles/models/sucursal.dart';

class Usuario {
  final int id;
  final String usua_username;
  final String usua_password;
  final String usua_fechaRegistro;
  final String usua_pregunta_uno;
  final String usua_pregunta_dos;
  bool usua_estado;
  final Persona persona;
  final Rol rol;
  //final Sucursal sucursal;

  Usuario({
    required this.id,
    required this.usua_username,
    required this.usua_password,
    required this.usua_fechaRegistro,
    required this.usua_pregunta_uno,
    required this.usua_pregunta_dos,
    required this.usua_estado,
    required this.persona,
    required this.rol,
   // required this.sucursal,
  });
//0106977176
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['usuario_id'],
      usua_username: json['username']?? '',
      usua_password: json['password']?? '',
      usua_fechaRegistro: json['fecha_registro'] ?? '',
      usua_pregunta_uno: json['pregunta_uno'] ?? '',
      usua_pregunta_dos: json['pregunta_dos'] ?? '',
      usua_estado: json['usuario_estado'] ?? false,
      persona: Persona.fromJson(json['persona'] ?? ''),
      //persona: json['persona'] != null ? Persona.fromJson(json['persona']) : Persona(pers_apellidos: '', pers_celular: '', pers_cedula: '', pers_codigoPostal: '', pers_correo: '', pers_estadoCivil: '', pers_fechaNacimiento: '', pers_foto: '', pers_genero: '', pers_id: 0, pers_nacionalidad: '', pers_nivelInstruccion: '', pers_nombres: '', pers_profesion: '', pers_sexo: '', pers_telefono: ''),
      rol: Rol.fromJson(json['rol']??''),
      //rol: json['rol'] != null ? Rol.fromJson(json['rol']) : Rol(rol_descripcion: '', rol_id:0 , rol_nombre: ''),
    //sucursal: Sucursal.fromJson(json['sucursal']),
    );
  }

   
  void toggle() {
    usua_estado = !usua_estado;
  }

  toJson() {}
}
