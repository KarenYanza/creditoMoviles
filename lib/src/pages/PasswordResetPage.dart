import 'package:flutter/material.dart';

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

  final Map<String, Map<String, dynamic>> _users = {
    "0302114772": {
      "username": "0302114772",
      "verification": "cuenca",
      "verification1": "hola",
      "email": "karen@example.com",
      "password": "password123"
    }
  };

  void _resetPassword() {
    String username = _usernameController.text;

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
      });
    }
  }

  void _verifyAnswer() {
    String verification = _verificationController.text;
    String verification1 = _verification1Controller.text;
    String username = _usernameController.text;

    if (!_users.containsKey(username)) {
      setState(() {
        _responseMessage =
            "*Usted es Asesor Financiero porfavor contactarse con servicio tecnico para restablecimiento de su contraseña";
        _showVerification = false;
      });
      return;
    }

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
                  ),
                  SizedBox(height: 16.0),
                  if (_showVerification)
                    Column(
                      children: [
                        Text(
                          "¿Cual es el nombre de tu primera mascota?",
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
                          "¿Cual es tu color favorito?",
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
                      ],
                    ),
                  ElevatedButton(
                    onPressed:
                        _showVerification ? _verifyAnswer : _resetPassword,
                    child: Text(_showVerification ? "Verificar" : "Buscar"),
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
}
