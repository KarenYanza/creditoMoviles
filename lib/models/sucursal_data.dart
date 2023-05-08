import 'package:flutter/cupertino.dart';
import 'package:moviles/Services/database_services.dart';
import 'package:moviles/models/sucursal.dart';

class SucursalData extends ChangeNotifier {
  List<Sucursal> usuarios = [];

  void updateTask(Sucursal sucursales) {
    sucursales.toggle();
    DatabaseServices.updateTask(sucursales.sucu_id);
    notifyListeners();
  }
}