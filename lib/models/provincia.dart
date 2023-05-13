import 'package:moviles/models/sucursal.dart';

class Provincia {
  final int prov_id;
  final String prov_codigo;
  final String prov_nombre;
  bool prov_estado;
  final Sucursal sucursal;
  final Provincia provincia;


  Provincia({
    required this.prov_id,
    required this.prov_codigo,
    required this.prov_nombre,
    this.prov_estado = false,
    required this.sucursal,
    required this.provincia,
   
  });

  factory Provincia.fromJson(Map<String, dynamic> json) {
    return Provincia(
      prov_id: json['prov_id'],
      prov_codigo: json['prov_codigo'],
      prov_nombre: json['prov_nombre'],
      prov_estado: json['prov_estado'],
      sucursal: Sucursal.fromJson(json['sucursal']),
      provincia: Provincia.fromJson(json['provincia']),
    );
  }
  void toggle() {
    prov_estado = !prov_estado;
  }
}
