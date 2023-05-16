import 'buro.dart';

class TablaBuro {
  final int tabBuro_id;
  final String tabBuro_score;
  final String tabBuro_calificacion;
  bool tabBuro_estado;
  final Buro buro;
 
  //final Sucursal sucursal;

  TablaBuro({
    required this.tabBuro_id,
    required this.tabBuro_score,
    required this.tabBuro_calificacion,
    required this.tabBuro_estado,
    required this.buro,
    
    // required this.sucursal,
  });
//0106977176
  factory TablaBuro.fromJson(Map<String, dynamic> json) {
    return TablaBuro(
      tabBuro_id: json['tabBuro_id'],
      tabBuro_score: json['tabBuro_score'] ?? '',
      tabBuro_calificacion: json['tabBuro_calificacion'] ?? '',
      tabBuro_estado: json['tabBuro_estado'] ?? false,
      buro: Buro.fromJson(json['buro'] ?? ''),
      //persona: json['persona'] != null ? Persona.fromJson(json['persona']) : Persona(pers_apellidos: '', pers_celular: '', pers_cedula: '', pers_codigoPostal: '', pers_correo: '', pers_estadoCivil: '', pers_fechaNacimiento: '', pers_foto: '', pers_genero: '', pers_id: 0, pers_nacionalidad: '', pers_nivelInstruccion: '', pers_nombres: '', pers_profesion: '', pers_sexo: '', pers_telefono: ''),
      
      //rol: json['rol'] != null ? Rol.fromJson(json['rol']) : Rol(rol_descripcion: '', rol_id:0 , rol_nombre: ''),
      //sucursal: Sucursal.fromJson(json['sucursal']),
    );
  }
}
