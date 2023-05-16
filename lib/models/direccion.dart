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
  
  

  Direccion({
    required this.dire_id,
    required this.dire_calle,
    required this.dire_numero,
    required this.dire_interseccion,
    required this.dire_sector,
    this.dire_estado = false,
    required this.sucursal,
    required this.provincia,
   
  });

 factory Direccion.fromJson(Map<String, dynamic> json) {
    return Direccion(
      dire_id: json['dire_id'],
      dire_calle: json['dire_calle'],
      dire_numero: json['dire_numero'],
      dire_interseccion: json['dire_interseccion'],
      dire_sector: json['dire_sector'],
      dire_estado: json['dire_estado'],
      sucursal: Sucursal.fromJson(json['sucursal']),
      provincia: Provincia.fromJson(json['provincia']),
      
    );
  }
  void toggle() {
    dire_estado = !dire_estado;
  }
}
