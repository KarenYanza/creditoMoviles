import 'package:flutter/cupertino.dart';
import 'package:moviles/Services/database_services.dart';
import 'package:moviles/models/Direccion.dart';

class SucursalData extends ChangeNotifier {
  List<Direccion> direcciones = [];

  void updateTask(Direccion direcciones) {
    direcciones.toggle();
    DatabaseServices.updateTask(direcciones.dire_id);
    notifyListeners();
  }
}