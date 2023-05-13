import 'dart:convert';

import 'package:moviles/models/persona.dart';
import 'package:moviles/models/rol.dart';
import 'package:moviles/models/sucursal.dart';

class Usuario {
  final int id;
  final String usua_username;
  final String usua_password;
  final String usua_fechaRegistro;
  final String usua_preguntaUno;
  final String usua_PreguntaDos;
  bool usua_estado;
  final Persona persona;
  final Rol rol;
  //final Sucursal sucursal;

  Usuario({
    required this.id,
    required this.usua_username,
    required this.usua_password,
    required this.usua_fechaRegistro,
    required this.usua_preguntaUno,
    required this.usua_PreguntaDos,
    this.usua_estado = false,
    required this.persona,
    required this.rol,
   // required this.sucursal,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['usuario_id'],
      usua_username: json['username'],
      usua_password: json['password'],
      usua_fechaRegistro: json['fecha_registro'],
      usua_preguntaUno: json['pregunta_uno'],
      usua_PreguntaDos: json['pregunta_dos'],
      usua_estado: json['usuario_estado'],
      persona: Persona.fromJson(json['persona']),
      rol: Rol.fromJson(json['rol']),
    //  sucursal: Sucursal.fromJson(json['sucursal']),
    );
  }
  
  void toggle() {
    usua_estado = !usua_estado;
  }
}
