

class Rol {
  final int rol_id;
  final String rol_nombre;
  final String rol_descripcion;
  bool rol_estado;


  Rol({
    required this.rol_id,
    required this.rol_nombre,
    required this.rol_descripcion,

    this.rol_estado = false,
    
  });

  factory Rol.fromJson(Map<String, dynamic> json) {
    return Rol(
      rol_id: json['rol_id'],
      rol_nombre: json['rol_nombre'],
      rol_descripcion: json['rol_descripcion'],
      rol_estado: json['rol_estado'],
    );
  }
  void toggle() {
    rol_estado = !rol_estado;
  }
}

