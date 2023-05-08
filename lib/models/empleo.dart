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

  factory Empleo.fromMap(Map empleomap) {
    return Empleo(
      empl_id: empleomap['empl_id'],
      empl_tipoEmpleado: empleomap['empl_tipoEmpleado'],
      empl_actividadEmpresa: empleomap['empl_actividadEmpresa'],
      empl_nombreEmpresa: empleomap['empl_nombreEmpresa'],
      empl_cargoEmpresa: empleomap['empl_cargoEmpresa'],
      empl_estado: empleomap['empl_estado'],
      empl_telefonoEmpresa: empleomap['empl_telefonoEmpresa'],
      empl_referenciaEmpresa: empleomap['empl_referenciaEmpresa'],
      empl_tiempoEmpresa: empleomap['empl_tiempoEmpresa'],
      direccion: empleomap['direccion'],
      conyugue: empleomap['conyugue'],
    );
  }
  void toggle() {
    empl_estado = !empl_estado;
  }
}