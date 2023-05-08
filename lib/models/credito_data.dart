import 'package:flutter/cupertino.dart';
import 'package:moviles/Services/database_services.dart';
import 'package:moviles/models/Credito.dart';

class SucursalData extends ChangeNotifier {
  List<Credito> creditos = [];

  void updateTask(Credito creditos) {
    creditos.toggle();
    DatabaseServices.updateTask(creditos.cred_id);
    notifyListeners();
  }
}