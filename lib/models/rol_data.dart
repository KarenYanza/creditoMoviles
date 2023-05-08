import 'package:flutter/cupertino.dart';
import 'package:moviles/Services/database_services.dart';
import 'package:moviles/models/rol.dart';

class SucursalData extends ChangeNotifier {
  List<Rol> roles = [];

  void updateTask(Rol roles) {
    roles.toggle();
    DatabaseServices.updateTask(roles.rol_id);
    notifyListeners();
  }
}