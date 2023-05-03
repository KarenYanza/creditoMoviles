import 'package:flutter/material.dart';

class PasswordResetPage extends StatefulWidget {
  static const String id = 'password_reset';
  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _verificationController = TextEditingController();

  String _responseMessage = "";
  bool _showVerification = false;
  String _securityQuestion = "";

  final Map<String, Map<String, dynamic>> _users = {
    "karen": {
      "username": "karen",
      "verification": "cuenca",
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

    if (user == null || verification != user["verification"]) {
      setState(() {
        _responseMessage = "Respuesta incorrecta.";
        _showVerification = false;
      });
      return;
    }

    setState(() {
      _responseMessage = "Tu contraseña ha sido enviada a ${user['email']}.";
      _showVerification = false;
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
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'images/logo.JPG',
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
            Expanded(
              child: Column(
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
                          "Pregunta",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          controller: _verificationController,
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
            ),
          ],
        ),
      ),
    );
  }
}
