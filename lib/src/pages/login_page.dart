import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviles/Services/globals.dart';

import 'package:moviles/models/usuario.dart';
import 'package:moviles/sqlite/base.dart';
import 'package:moviles/src/pages/PasswordResetPage.dart';
import 'NavigationBar.dart';
import 'NavigationBar1.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:local_auth/local_auth.dart';
import 'package:connectivity/connectivity.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late List<Map<Usuario, dynamic>> _users;
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool _obscureText = true;
  String logoImage = 'images/logo.png';
  int failedAttempts = 0;
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _isFingerprintEnabled = false;
  String tokens = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkFingerprintEnabled();
  }

  Future<void> _checkFingerprintEnabled() async {
    bool hasFingerprint = await _localAuthentication.canCheckBiometrics;

    setState(() {
      _isFingerprintEnabled = hasFingerprint;
    });
  }

  Future<void> _getSavedLogin() async {
    final loginData = await DatabaseHelper.instance.getLogin();

    if (loginData != null) {
      _userController.text = loginData['username'];
      _passwordController.text = loginData['password'];

      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        print('No hay conexión a Internet');
      } else {
        obtenerUsuarioYLogin();
      }
    }
  }

  Future<void> _authenticateWithFingerprint() async {
    bool isAuthenticated = false;

    try {
      isAuthenticated = await _localAuthentication.authenticate(
        localizedReason: 'Please authenticate to log in',
      );
    } catch (e) {
      print(e.toString());
    }

    if (isAuthenticated) {
      _getSavedLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          // Bloquear el botón de retroceso
          return false;
        },
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ConditionalCircularImageWidget(
                        base64Image: logoImage,
                        fallbackImage: 'images/logo.png',
                        width: 300.0,
                        height: 300.0,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    _buildUserFormField(),
                    SizedBox(
                      height: 15.0,
                    ),
                    _buildPasswordFormField(),
                    SizedBox(
                      height: 15.0,
                    ),
                    _buildLoginButton(),
                    SizedBox(
                      height: 15.0,
                    ),
                    _buildRegisterButton(),
                    if (_isFingerprintEnabled) ...[
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _authenticateWithFingerprint,
                        child: Text('Iniciar Sesion Con Huella'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserFormField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: _userController,
        decoration: InputDecoration(
          hintText: 'Introduce tu usuario',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduce tu usuario';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordFormField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: _passwordController,
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: 'Introduce tu contraseña',
          border: OutlineInputBorder(),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduce tu contraseña';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          bool userFound = false;
          obtenerUsuarioYLogin();
        }
      },
      child: Text('Iniciar sesión'),
    );
  }

  Future<void> generarToken(String username, String password) async {
    final url = Uri.parse('${APIConfig.baseURLlogin}generate-token');
    print(url);
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'username': username,
      'password': password,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final token = jsonResponse['token'] as String;
        setState(() {
          APIConfig.authtoken = token;
        });
        print(token);
      } else {
        print('Error al generar el token ${response.statusCode}');
      }
    } catch (e) {
      print('Error de conexión: $e');
    }
  }

  Future<void> obtenerUsuarioYLogin() async {
    generarToken(_userController.text, _passwordController.text);
    try {
      String url =
          '${APIConfig.baseURL}usuarios/search/${_userController.text}';
      final response = await http.get(Uri.parse(url));
      //String domain = 'http://192.168.0.106:8080/api/usuarios/search/$username';
      //final response = await http.get(Uri.parse(domain));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        Usuario u = Usuario.fromJson(jsonResponse);
        if (u.usua_password == _passwordController.text) {
          // Usuario y contraseña coinciden
          if (u.rol.rol_id == 3) {
            // Administrador
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NextPage(usuario: u)),
            );
          } else if (u.rol.rol_id == 4) {
            // Cliente
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NextPage1(usuario: u)),
            );
          } else if (u.rol.rol_id == 2 || u.rol.rol_id == 1) {
            showErrorMessage(
                'Su rol no tiene permiso para iniciar sesión en la aplicación móvil.');
            _userController.clear();
            _passwordController.clear();
            setState(() {
              logoImage = 'images/logo.png';
            });
          }
          await DatabaseHelper.instance.saveLogin(_userController.text,
              _passwordController.text, _isFingerprintEnabled);
        } else {
          failedAttempts++; // Incrementar el contador de intentos fallidos

          if (failedAttempts >= 3) {
            showErrorMessage(
                'Has excedido el número máximo de intentos fallidos');
            _userController.clear();
            _passwordController.clear();
            setState(() {
              logoImage = 'images/logo.png';
            });
          } else {
            showErrorMessage('Contraseña incorrecta');
            _passwordController.clear();
            if (u.persona.pers_foto.isNotEmpty) {
              setState(() {
                logoImage = u.persona.pers_foto;
              });
            }
          }
        }
      } else {
        showErrorMessage('Usuario no existe');
      }
    } catch (error) {
      showErrorMessage('Usuario invalido');
      _userController.clear();
      _passwordController.clear();
    }
  }

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return TextButton(
      onPressed: () {
        // Aquí iría el código para navegar a la pantalla de registro
        Navigator.pushNamed(context, PasswordResetPage.id);
      },
      child: Text('Olvidaste tu contraseña?'),
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
    this.width = 300.0,
    this.height = 300.0,
  });

  @override
  Widget build(BuildContext context) {
    if (base64Image.isEmpty) {
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
