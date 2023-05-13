import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/task.dart';
import '../models/usuario.dart';
import 'globals.dart';

class DatabaseServices {
  static Future<List<Usuario>> getTasks() async {
    var url = Uri.parse(baseURL + "/users/list");
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);
    List<dynamic> responseList = jsonDecode(response.body);
    List<Usuario> tasks = [];
    for (dynamic taskMap in responseList) {
      Usuario task = Usuario.fromJson(taskMap);
      tasks.add(task);
    }
    print(tasks.length);
    return tasks;
  }

  Future<Usuario> login(String username, String password) async {
    String url = "http://localhost:8080/api/usuarios/$username/$password";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // El servidor devolvió una respuesta exitosa
      final jsonResponse = json.decode(response.body);
      return Usuario.fromJson(jsonResponse);
    } else {
      // El servidor devolvió un error
      throw Exception('Error al cargar el usuario');
    }
  }

  static Future<http.Response> updateTask(int id) async {
    var url = Uri.parse(baseURL + '/buscar/$id');
    http.Response response = await http.put(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }
}
