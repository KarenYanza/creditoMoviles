import 'package:moviles/models/usuario.dart';


class Conyugue {
  final int cony_id;
  bool cony_estado;
 

  Conyugue({
    required this.cony_id,
    required this.cony_estado,
    
  });

  factory Conyugue.fromMap(Map conyuguemap) {
    return Conyugue(
      cony_id: conyuguemap['cony_id'],
      cony_estado: conyuguemap['cony_estado'],
      
    );
  }
  void toggle() {
    cony_estado = !cony_estado;
  }
}
