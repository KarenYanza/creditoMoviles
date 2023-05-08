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
  final  Persona persona;
  final Rol rol;
  final Sucursal sucursal;

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
    required this.sucursal,
  });

  factory Usuario.fromMap(Map usuariomap) {
    return Usuario(
      id: usuariomap['id'],
      usua_username: usuariomap['usuario'],
      usua_password: usuariomap['password'],
      usua_fechaRegistro: usuariomap['fecha_registro'],
      usua_preguntaUno: usuariomap['pregunta_uno'],
      usua_PreguntaDos: usuariomap['pregunta_dos'],
      usua_estado: usuariomap['estado_usu'],
      persona: usuariomap['persona'],
      rol: usuariomap['rol'],
      sucursal: usuariomap['sucursal'],
    );
  }
  void toggle() {
    usua_estado = !usua_estado;
  }
}

