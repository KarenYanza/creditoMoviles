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
  final String soli_estado;
  final BienesRaices bienesRaices;
  final Buro buro;
  final Gastos gastos;
  final Ingresos ingresos;
  final Domicilio domicilio;
  final Empleo empleo;
  final Conyugue conyugue;
  final Persona persona;
  final Credito credito;
  final ReferenciasBancarias referenciasBancarias;
  //final Vehiculo vehiculo;
  //final Deudas deudas;
 // final TarjetasCredito tarjetasCredito;
  //final Sucursal sucursal;

  Solicitud({
    required this.soli_id,
    required this.soli_estadoRegistro,
    required this.soli_estado,
     required this.bienesRaices,
    required this.buro,
    required this.gastos,
    required this.ingresos,
     required this.domicilio,
    required this.empleo,
     required this.conyugue,
    required this.persona,
     required this.credito,
    required this.referenciasBancarias,
   // required this.vehiculo,
    // required this.deudas,
   // required this.tarjetasCredito,
    // required this.sucursal,
  });
//0106977176
  factory Solicitud.fromJson(Map<String, dynamic> json) {
    return Solicitud(
      soli_id: json['soli_id'],
      soli_estadoRegistro: json['soli_estadoRegistro'] ?? '',
      soli_estado: json['soli_estado'] ?? '',
      bienesRaices: BienesRaices.fromJson(json['bienesRaices'] ?? ''),
      //persona: json['persona'] != null ? Persona.fromJson(json['persona']) : Persona(pers_apellidos: '', pers_celular: '', pers_cedula: '', pers_codigoPostal: '', pers_correo: '', pers_estadoCivil: '', pers_fechaNacimiento: '', pers_foto: '', pers_genero: '', pers_id: 0, pers_nacionalidad: '', pers_nivelInstruccion: '', pers_nombres: '', pers_profesion: '', pers_sexo: '', pers_telefono: ''),
      buro: Buro.fromJson(json['buro'] ?? ''),
      gastos: Gastos.fromJson(json['gastos'] ?? ''),
      ingresos: Ingresos.fromJson(json['ingresos'] ?? ''),
      domicilio: Domicilio.fromJson(json['domicilio'] ?? ''),
      empleo: Empleo.fromJson(json['empleo'] ?? ''),
      conyugue: Conyugue.fromJson(json['conyugue'] ?? ''),
      persona: Persona.fromJson(json['persona'] ?? ''),
      credito: Credito.fromJson(json['credito'] ?? ''),
      referenciasBancarias: ReferenciasBancarias.fromJson(json['referenciasBancarias'] ?? ''),
      //vehiculo: Vehiculo.fromJson(json['vehiculo'] ?? ''),
     // deudas: Deudas.fromJson(json['deudas'] ?? ''),
      //tarjetasCredito: TarjetasCredito.fromJson(json['tarjetasCredito'] ?? ''),
      //rol: json['rol'] != null ? Rol.fromJson(json['rol']) : Rol(rol_descripcion: '', rol_id:0 , rol_nombre: ''),
      //sucursal: Sucursal.fromJson(json['sucursal']),
    );
  }
}
