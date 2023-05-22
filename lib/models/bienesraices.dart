import 'solicitud.dart';

class BienesRaices {
  final int bienRaic_id;
  final String bienRaic_tipo;
  final String bienRaic_numeroPredio;
  final double bienRaic_valor;
  final String bienRaic_hipoteca;
  DateTime? bienRaic_fechaAdquisicion;
  final String bienRaic_institucionPersona;
  bool bienRaic_estado;

  //final Sucursal sucursal;

  BienesRaices({
    required this.bienRaic_id,
    required this.bienRaic_tipo,
    required this.bienRaic_numeroPredio,
    required this.bienRaic_valor,
    required this.bienRaic_hipoteca,
    this.bienRaic_fechaAdquisicion,
    required this.bienRaic_institucionPersona,
    required this.bienRaic_estado,

    // required this.sucursal,
  });
//0106977176
  factory BienesRaices.fromJson(Map<String, dynamic> json) {
    return BienesRaices(
      bienRaic_id: json['bienRaic_id'],
      bienRaic_tipo: json['bienRaic_tipo'] ?? '',
      bienRaic_numeroPredio: json['bienRaic_numeroPredio'] ?? '',
      bienRaic_valor: json['bienRaic_valor'] ?? '',
      bienRaic_hipoteca: json['bienRaic_hipoteca'] ?? '',
      bienRaic_fechaAdquisicion:
          DateTime.parse(json['bienRaic_fechaAdquisicion']),
      bienRaic_institucionPersona: json['bienRaic_institucionPersona'] ?? '',
      bienRaic_estado: json['bienRaic_estado'] ?? false,
      //persona: json['persona'] != null ? Persona.fromJson(json['persona']) : Persona(pers_apellidos: '', pers_celular: '', pers_cedula: '', pers_codigoPostal: '', pers_correo: '', pers_estadoCivil: '', pers_fechaNacimiento: '', pers_foto: '', pers_genero: '', pers_id: 0, pers_nacionalidad: '', pers_nivelInstruccion: '', pers_nombres: '', pers_profesion: '', pers_sexo: '', pers_telefono: ''),
      //rol: json['rol'] != null ? Rol.fromJson(json['rol']) : Rol(rol_descripcion: '', rol_id:0 , rol_nombre: ''),
      //sucursal: Sucursal.fromJson(json['sucursal']),
    );
  }
}
