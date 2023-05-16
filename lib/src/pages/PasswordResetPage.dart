import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../../models/usuario.dart';

class PasswordResetPage extends StatefulWidget {
  static const String id = 'password_reset';
  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _verificationController = TextEditingController();
  TextEditingController _verification1Controller = TextEditingController();

  String _responseMessage = "";
  bool _showVerification = false;
  String _securityQuestion = "";
  bool _userFound = false;

  final Map<String, Map<String, dynamic>> _users = {
    "0302114772": {
      "username": "0302114772",
      "verification": "cuenca",
      "verification1": "hola",
      "email": "karen@example.com",
      "password": "password123"
    }
  };

  void _resetPassword(String username) {
    if (!_users.containsKey(username)) {
      setState(() {
        _responseMessage =
            "*Usted es Asesor Financiero porfavor contactarse con servicio tecnico para restablecimiento de su contraseña";
      });
      return;
    }

    Map<String, dynamic>? user = _users[username];

    if (user != null) {
      setState(() {
        _securityQuestion = user["verification"];
        _showVerification = true;
        _userFound = true;
      });
    }
  }

  void _verifyAnswer() {
    String verification = _verificationController.text;
    String verification1 = _verification1Controller.text;
    String username = _usernameController.text;

    Map<String, dynamic>? user = _users[username];

    if (user == null ||
        verification != user["verification"] ||
        verification1 != user["verification1"]) {
      // verifica ambas respuestas
      setState(() {
        _responseMessage = "Respuesta incorrecta.";
        _showVerification = false;
        _verificationController.clear(); // limpia los campos de texto
        _verification1Controller.clear();
        _userFound = false;
      });
      return;
    }

    setState(() {
      _responseMessage = "Tu contraseña ha sido enviada a ${user['email']}.";
      _showVerification = false;
      _usernameController.clear(); // limpia el campo de texto de usuario
      _verificationController
          .clear(); // limpia los campos de texto de respuesta
      _verification1Controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recuperar contraseña"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'images/logo.png',
                    height: 100.0,
                  ),
                  SizedBox(width: 16.0),
                  Text(
                    "Recuperar contraseña",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      height: 2.5,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Column(
                children: [
                  Text(
                    "Nombre de usuario",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(),
                    enabled: !_userFound,
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () => obtenerUsuario(_usernameController.text),
                    child: Text("Buscar"),
                  ),
                  SizedBox(height: 16.0),
                  if (_showVerification)
                    Column(
                      children: [
                        Text(
                          "¿Cuál es el nombre de tu primera mascota?",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          controller: _verificationController,
                          decoration: InputDecoration(),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          "¿Cuál es tu color favorito?",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          controller: _verification1Controller,
                          decoration: InputDecoration(),
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () =>
                              restableceContra(_usernameController.text),
                          child: Text("Verificar"),
                        ),
                      ],
                    ),
                  SizedBox(height: 16.0),
                  Text(_responseMessage),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> obtenerUsuario(String username) async {
    try {
      String url = "http://localhost:8080/api/usuarios/search/$username";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // El servidor devolvió una respuesta exitosa
        final jsonResponse = json.decode(response.body);
        print("Entre al metodo");
        print("udrt" + _usernameController.text);
        Usuario u = Usuario.fromJson(jsonResponse);
        print(u.persona.pers_cedula);
        if (u.rol.rol_id == 3) {
          setState(() {
            _showVerification = true;
            _userFound = true;
          });
        } else if (u.rol.rol_id == 1 ||
            u.rol.rol_id == 2 ||
            u.rol.rol_id == 4) {
          //Cliente
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Usted es empleado comuniquese con el tecnico ')),
          );
        }
      } else {
        // El servidor devolvió un error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuario inválido')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario inválido')),
      );
    }
  }

  Future<void> restableceContra(String username) async {
  try {
    String url = "http://localhost:8080/api/usuarios/restablecer/$username";
    final response = await http.put(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print("Entré al método");
      print("Usuario: " + _usernameController.text);
      Usuario u = Usuario.fromJson(jsonResponse);
      print(u.persona.pers_cedula);
      if (_usernameController.text.isEmpty ||
          _verificationController.text != u.usua_pregunta_uno||
          _verification1Controller.text != u.usua_pregunta_dos) {
        setState(() {
          _responseMessage = "Respuesta incorrecta.";
          _showVerification = false;
          _verificationController.clear();
          _verification1Controller.clear();
          _userFound = false;
        });
        return;
      }

      setState(() {
        _responseMessage =
            "Tu contraseña ha sido enviada a " + u.persona.pers_correo;
        _showVerification = false;
        _usernameController.clear();
        _verificationController.clear();
        _verification1Controller.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario inválido')),
      );
    }
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Usuario inválido')),
    );
  }
}

}
