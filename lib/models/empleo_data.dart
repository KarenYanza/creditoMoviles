import 'package:flutter/cupertino.dart';
import 'package:moviles/Services/database_services.dart';
import 'package:moviles/models/Empleo.dart';

class SucursalData extends ChangeNotifier {
  List<Empleo> empleos = [];

  void updateTask(Empleo empleos) {
    empleos.toggle();
    DatabaseServices.updateTask(empleos.empl_id);
    notifyListeners();
  }
}