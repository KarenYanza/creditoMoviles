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

  factory Provincia.fromMap(Map provinciamap) {
    return Provincia(
      prov_id: provinciamap['prov_id'],
      prov_codigo: provinciamap['prov_codigo'],
      prov_nombre: provinciamap['prov_nombre'],
      prov_estado: provinciamap['prov_estado'],
      sucursal: provinciamap['sucursal'],
      provincia: provinciamap['provincia'],
    );
  }
  void toggle() {
    prov_estado = !prov_estado;
  }
}
