import 'package:moviles/models/sucursal.dart';

import 'bienesraices.dart';
import 'buro.dart';
import 'credito.dart';
import 'domicilio.dart';
import 'empleo.dart';
import 'gastos.dart';
import 'ingresos.dart';
import 'persona.dart';
import 'conyugue.dart';
import 'referenciasbancarias.dart';

class Solicitud {
  final int soli_id;
  final String soli_estadoRegistro;
  final bool soli_estado;
  final Persona persona;
  final Credito credito;
  //final Vehiculo vehiculo;
  //final Deudas deudas;
  // final TarjetasCredito tarjetasCredito;

  Solicitud(
      {required this.soli_id,
      required this.soli_estadoRegistro,
      required this.soli_estado,
      required this.persona,
      required this.credito
      // required this.vehiculo,
      // required this.deudas,
      // required this.tarjetasCredito,
      // required this.sucursal,
      });

  factory Solicitud.fromJson(Map<String, dynamic> json) {
    return Solicitud(
      soli_id: json['soli_id'] ?? 0,
      soli_estadoRegistro: json['soli_estadoRegistro'] ?? '',
      soli_estado: json['soli_estado'] ?? false,
      persona: Persona.fromJson(json['persona'] ?? {}),
      credito: Credito.fromJson(json['credito'] ?? {}),
      //vehiculo: Vehiculo.fromJson(json['vehiculo'] ?? {}),
      // deudas: Deudas.fromJson(json['deudas'] ?? {}),
      //tarjetasCredito: TarjetasCredito.fromJson(json['tarjetasCredito'] ?? ''),
      //rol: json['rol'] != null ? Rol.fromJson(json['rol']) : Rol(rol_descripcion: '', rol_id:0 , rol_nombre: ''),
      //sucursal: Sucursal.fromJson(json['sucursal']),
    );
  }
}
