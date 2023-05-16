import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moviles/Services/database_services.dart';
import 'package:moviles/models/usuario.dart';
import 'package:moviles/src/pages/PasswordResetPage.dart';
import 'NavigationBar.dart';
import 'NavigationBar1.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

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

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Center(
        child: Stack(
          children: [
            Lottie.network(
                'https://assets6.lottiefiles.com/packages/lf20_C67qsN3hAk.json'),

            //child: Lottie.asset('assets/loading.json'),
          ],
        ),
      );
    }
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/logo.png',
                    height: 300.0,
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
                ],
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

          login(_userController.text, _passwordController.text);
        }
      },
      child: Text('Iniciar sesión'),
    );
  }

  Future<void> login(String username, String password) async {
    setState(() {
      _loading = true;
    });
    try {
      String url =
          "http://localhost:8080/api/usuarios/login/$username/$password";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // El servidor devolvió una respuesta exitosa
        final jsonResponse = json.decode(response.body);
        Usuario u = Usuario.fromJson(jsonResponse);

        if (u.rol.rol_id == 3) {
          //Administrador
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NextPage(usuario: u)));
        } else if (u.rol.rol_id == 4) {
          //Cliente
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NextPage1(usuario: u)));
        }
      } else {
        // El servidor devolvió un error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuario o contraseña inválido')),
        );
      }
    } catch (error) {
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
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
