import 'package:flutter/cupertino.dart';
import 'package:moviles/Services/database_services.dart';
import 'package:moviles/models/Conyugue.dart';

class SucursalData extends ChangeNotifier {
  List<Conyugue> conyugue = [];

  void updateTask(Conyugue conyugue) {
    conyugue.toggle();
    DatabaseServices.updateTask(conyugue.cony_id);
    notifyListeners();
  }
}
