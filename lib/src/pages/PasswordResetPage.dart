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
  int id = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Evitar que el usuario retroceda
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cambiar contraseña"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(
                  context); // Navegar hacia atrás al presionar el botón de retroceso
            },
          ),
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
                      "Cambio de contraseña",
                      style: TextStyle(
                        fontSize: 20.0,
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
                      "Usuario",
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
      ),
    );
  }

  Future<void> obtenerUsuario(String username) async {
    try {
      String url = "${APIConfig.baseURL}usuarios/search/$username";
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer ${APIConfig.authtoken}',
      });
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        Usuario u = Usuario.fromJson(jsonResponse);
        print(u.persona.pers_cedula);
        if (u.rol.rol_id == 4) {
          id = u.id;
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
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer ${APIConfig.authtoken}',
      });
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
          });
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String nuevaContrasena = '';
              String confirmacionContrasena = '';
              bool mostrarContrasena = false;
              bool mostrarContrasena1 = false;
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return CustomAlertDialog(
                    title: "Cambio de contraseña",
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              nuevaContrasena = value;
                            });
                          },
                          obscureText: !mostrarContrasena,
                          decoration: InputDecoration(
                            labelText: 'Nueva contraseña',
                            suffixIcon: IconButton(
                              icon: Icon(
                                mostrarContrasena
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  mostrarContrasena = !mostrarContrasena;
                                });
                              },
                            ),
                          ),
                        ),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              confirmacionContrasena = value;
                            });
                          },
                          obscureText: !mostrarContrasena1,
                          decoration: InputDecoration(
                            labelText: 'Confirmación de contraseña',
                            suffixIcon: IconButton(
                              icon: Icon(
                                mostrarContrasena1
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  mostrarContrasena1 = !mostrarContrasena1;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: Text("Aceptar"),
                        onPressed: () async {
                          if (nuevaContrasena.isEmpty ||
                              confirmacionContrasena.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Llenar todos los campos.'),
                              ),
                            );
                          } else if (nuevaContrasena.length < 8) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'La contraseña debe tener al menos 8 caracteres.'),
                              ),
                            );
                          } else if (!RegExp(r'[a-zA-Z]')
                                  .hasMatch(nuevaContrasena) ||
                              !RegExp(r'\d').hasMatch(nuevaContrasena) ||
                              !RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                                  .hasMatch(nuevaContrasena)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'La contraseña debe contener letras, números y al menos un carácter especial.'),
                              ),
                            );
                          } else if (nuevaContrasena !=
                              confirmacionContrasena) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Las contraseñas no coinciden.'),
                              ),
                            );
                          } else {
                            if (nuevaContrasena == confirmacionContrasena) {
                              var url = Uri.parse(
                                  '${APIConfig.baseURL}usuarios/restablecer/$id?password=$nuevaContrasena');
                              print(url);
                              var response = await http.put(url, headers: {
                                'Authorization':
                                    'Bearer ${APIConfig.authtoken}',
                              });
                              print(response.statusCode);
                              if (response.statusCode == 201) {
                                Navigator.of(context).pushNamed(LoginPage.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Contraseña cambiada exitosamente'),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Error al cambiar la contraseña'),
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Las contraseñas no coinciden.'),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            },
          );
        } else {}
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Preguntas sin contestar')),
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

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget> actions;

  CustomAlertDialog({
    required this.title,
    required this.content,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(LoginPage.id);
                  },
                  child: Icon(
                    Icons.close,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            content,
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: actions,
            ),
          ],
        ),
      ),
    );
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
