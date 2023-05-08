

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

  factory Rol.fromMap(Map rolmap) {
    return Rol(
      rol_id: rolmap['rol_id'],
      rol_nombre: rolmap['rol_nombre'],
      rol_descripcion: rolmap['rol_descripcion'],
      rol_estado: rolmap['rol_estado'],
      
    );
  }
  void toggle() {
    rol_estado = !rol_estado;
  }
}

