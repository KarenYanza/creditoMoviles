import 'package:moviles/models/conyugue.dart';
import 'package:moviles/models/direccion.dart';
import 'package:moviles/models/provincia.dart';
import 'package:moviles/models/sucursal.dart';

class Empleo {
  final int empl_id;
  final String empl_tipoEmpleado;
  final String empl_actividadEmpresa;
  final String empl_nombreEmpresa;
  final String empl_cargoEmpresa;
  bool empl_estado;
  final String empl_telefonoEmpresa;
  final String empl_referenciaEmpresa;
  final String empl_tiempoEmpresa;
  final Direccion direccion;
  final Conyugue conyugue;

  Empleo({
    required this.empl_id,
    required this.empl_tipoEmpleado,
    required this.empl_actividadEmpresa,
    required this.empl_nombreEmpresa,
    required this.empl_cargoEmpresa,
    this.empl_estado = false,
    required this.empl_telefonoEmpresa,
    required this.empl_referenciaEmpresa,
    required this.empl_tiempoEmpresa,
    required this.direccion,
    required this.conyugue,
  });

  factory Empleo.fromJson(Map<String, dynamic> json) {
    return Empleo(
      empl_id: json['empl_id'],
      empl_tipoEmpleado: json['empl_tipoEmpleado'],
      empl_actividadEmpresa: json['empl_actividadEmpresa'],
      empl_nombreEmpresa: json['empl_nombreEmpresa'],
      empl_cargoEmpresa: json['empl_cargoEmpresa'],
      empl_estado: json['empl_estado'],
      empl_telefonoEmpresa: json['empl_telefonoEmpresa'],
      empl_referenciaEmpresa: json['empl_referenciaEmpresa'],
      empl_tiempoEmpresa: json['empl_tiempoEmpresa'],
      direccion: Direccion.fromJson(json['direccion']),
      conyugue: Conyugue.fromJson(json['conyugue']),
    );
  }
  void toggle() {
    empl_estado = !empl_estado;
  }
}