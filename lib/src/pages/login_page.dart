import 'package:flutter/material.dart';
import 'package:moviles/src/pages/PasswordResetPage.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
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
                    'images/logo.JPG',
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
          // Aquí iría el código para validar el inicio de sesión
        }
      },
      child: Text('Iniciar sesión'),
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
