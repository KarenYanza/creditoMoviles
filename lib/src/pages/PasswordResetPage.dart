import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moviles/src/pages/login_page.dart';
import 'dart:async';
import 'dart:convert';

import '../../Services/globals.dart';
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
  String logoImage = 'images/logo.png';

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
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ConditionalCircularImageWidget(
                      base64Image: logoImage,
                      fallbackImage: 'images/logo.png',
                      width: 100.0,
                      height: 100.0,
                    ),
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
                          "¿Cuál es tu color favorito?",
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
                          "¿Cuál es el nombre de tu primera mascota? ",
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
                          onPressed: () => login(
                              _usernameController.text,
                              _verificationController.text,
                              _verification1Controller.text),
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
      String url = "${APIConfig.baseURL}usuarios/search/$username";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        Usuario u = Usuario.fromJson(jsonResponse);
        print(u.persona.pers_cedula);
        if (u.rol.rol_id == 4) {
          setState(() {
            _showVerification = true;
            _userFound = true;
            if (u.persona.pers_foto != null || u.persona.pers_foto.isEmpty) {
              logoImage = u.persona.pers_foto;
            }
          });
        } else if (u.rol.rol_id == 1 ||
            u.rol.rol_id == 2 ||
            u.rol.rol_id == 3) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Usted es empleado por favor contactarse con servicio técnico para restablecimiento de su contraseña')),
          );
          Navigator.of(context).pushNamed(LoginPage.id);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuario inválido')),
        );
        _usernameController.clear();
      }
    } catch (error) {
      _usernameController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario inválido')),
      );
    }
  }

  Future<void> login(
      String username, String preguntaUno, String preguntaDos) async {
    try {
      String url =
          "${APIConfig.baseURL}usuarios/restablecerC/$username/$preguntaUno/$preguntaDos";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        Usuario u = Usuario.fromJson(jsonResponse);
        if (_usernameController.text.toLowerCase() ==
                u.usua_username.toLowerCase() &&
            _verificationController.text.toLowerCase() ==
                u.usua_preguntaUno.toLowerCase() &&
            _verification1Controller.text.toLowerCase() ==
                u.usua_preguntaDos.toLowerCase()) {
          setState(() {
            _showVerification = false;
            _usernameController.clear();
            _verificationController.clear();
            _verification1Controller.clear();
            Navigator.of(context).pushNamed(LoginPage.id);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text("Tu contraseña ha sido enviada a " +
                      u.persona.pers_correo)),
            );
          });
        } else {}
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuario inválido')),
        );
      }
    } catch (error) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Respuestas incorrectas.')),
        );
        _showVerification = false;
        _verificationController.clear();
        _verification1Controller.clear();
        _userFound = false;
      });
    }
  }
}

class ConditionalCircularImageWidget extends StatelessWidget {
  final String base64Image;
  final String fallbackImage;
  final double width;
  final double height;

  ConditionalCircularImageWidget({
    required this.base64Image,
    required this.fallbackImage,
    this.width = 100.0,
    this.height = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    if (base64Image == null || base64Image.isEmpty) {
      return ClipOval(
        child: Image.asset(
          fallbackImage,
          fit: BoxFit.cover,
          width: width,
          height: height,
        ),
      );
    } else {
      try {
        String base64ImageWithoutHeader = base64Image.split(',').last;
        Uint8List bytes = base64.decode(base64ImageWithoutHeader);
        return ClipOval(
          child: Image.memory(
            bytes,
            fit: BoxFit.cover,
            width: width,
            height: height,
          ),
        );
      } catch (error) {
        print('Error decoding base64 image: $error');
        return ClipOval(
          child: Image.asset(
            fallbackImage,
            fit: BoxFit.cover,
            width: width,
            height: height,
          ),
        );
      }
    }
  }
}
