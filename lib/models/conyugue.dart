import 'package:moviles/models/usuario.dart';


class Conyugue {
  final int cony_id;
  bool cony_estado;
 

  Conyugue({
    required this.cony_id,
    required this.cony_estado,
    
  });

  factory Conyugue.fromJson(Map<String, dynamic> json) {
    return Conyugue(
      cony_id: json['cony_id'],
      cony_estado: json['cony_estado'],
    );
  }
  void toggle() {
    cony_estado = !cony_estado;
  }
}
