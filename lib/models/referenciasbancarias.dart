import 'package:moviles/src/pages/NavigationBar1.dart';

class ReferenciasBancarias {
  final int refBanc_id;
  final String refBanc_nombre;
  final String refBanc_numero;
  final String refBanc_tipo;
  final String refBanc_apertura;
  final double refBanc_cifrasPromedio;
  final double refBanc_saldo;
  bool refBanc_estado;
  //final Sucursal sucursal;

  ReferenciasBancarias({
    required this.refBanc_id,
    required this.refBanc_nombre,
    required this.refBanc_numero,
    required this.refBanc_tipo,
    required this.refBanc_apertura,
    required this.refBanc_cifrasPromedio,
    required this.refBanc_saldo,
    required this.refBanc_estado,
    // required this.sucursal,
  });
//0106977176
  factory ReferenciasBancarias.fromJson(Map<String, dynamic> json) {
    return ReferenciasBancarias(
      refBanc_id: json['refBanc_id'],
      refBanc_nombre: json['refBanc_nombre'] ?? '',
      refBanc_numero: json['refBanc_numero'] ?? '',
      refBanc_tipo: json['refBanc_tipo'] ?? '',
      refBanc_apertura: json['refBanc_apertura'] ?? '',
      refBanc_cifrasPromedio: json['refBanc_cifrasPromedio'] ?? '',
      refBanc_saldo: json['refBanc_saldo'] ?? '',
      refBanc_estado: json['refBanc_estado'] ?? false,
      //persona: json['persona'] != null ? Persona.fromJson(json['persona']) : Persona(pers_apellidos: '', pers_celular: '', pers_cedula: '', pers_codigoPostal: '', pers_correo: '', pers_estadoCivil: '', pers_fechaNacimiento: '', pers_foto: '', pers_genero: '', pers_id: 0, pers_nacionalidad: '', pers_nivelInstruccion: '', pers_nombres: '', pers_profesion: '', pers_sexo: '', pers_telefono: ''),
      //rol: json['rol'] != null ? Rol.fromJson(json['rol']) : Rol(rol_descripcion: '', rol_id:0 , rol_nombre: ''),
      //sucursal: Sucursal.fromJson(json['sucursal']),
    );
  }
}
