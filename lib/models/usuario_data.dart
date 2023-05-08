import 'package:flutter/cupertino.dart';
import 'package:moviles/Services/database_services.dart';
import 'package:moviles/models/usuario.dart';

class UsuarioData extends ChangeNotifier {
  List<Usuario> usuarios = [];

  void updateTask(Usuario usuarios) {
    usuarios.toggle();
    DatabaseServices.updateTask(usuarios.id);
    notifyListeners();
  }
}