import 'package:moviles/models/provincia.dart';
import 'package:moviles/models/sucursal.dart';

import 'empleo.dart';

class Direccion {
  final int dire_id;
  final String dire_calle;
  final String dire_numero;
  final String dire_interseccion;
  final String dire_sector;
  bool dire_estado;
  final Sucursal sucursal;
  final Provincia provincia;
  final Empleo empleo;
  

  Direccion({
    required this.dire_id,
    required this.dire_calle,
    required this.dire_numero,
    required this.dire_interseccion,
    required this.dire_sector,
    this.dire_estado = false,
    required this.sucursal,
    required this.provincia,
    required this.empleo,
  });

  factory Direccion.fromMap(Map direccionmap) {
    return Direccion(
      dire_id: direccionmap['dire_id'],
      dire_calle: direccionmap['dire_calle'],
      dire_numero: direccionmap['dire_numero'],
      dire_interseccion: direccionmap['dire_interseccion'],
      dire_sector: direccionmap['dire_sector'],
      dire_estado: direccionmap['dire_estado'],
      sucursal: direccionmap['sucursal'],
      provincia: direccionmap['provincia'],
      empleo: direccionmap['empleo'],
    );
  }
  void toggle() {
    dire_estado = !dire_estado;
  }
}
