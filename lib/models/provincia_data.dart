import 'package:flutter/cupertino.dart';
import 'package:moviles/Services/database_services.dart';
import 'package:moviles/models/Provincia.dart';

class SucursalData extends ChangeNotifier {
  List<Provincia> provincia = [];

  void updateTask(Provincia provincia) {
    provincia.toggle();
    DatabaseServices.updateTask(provincia.prov_id);
    notifyListeners();
  }
}