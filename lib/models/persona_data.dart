import 'package:flutter/cupertino.dart';
import 'package:moviles/Services/database_services.dart';
import 'package:moviles/models/Persona.dart';

class SucursalData extends ChangeNotifier {
  List<Persona> personas = [];

  void updateTask(Persona personas) {
    personas.toggle();
    DatabaseServices.updateTask(personas.pers_id);
    notifyListeners();
  }
}