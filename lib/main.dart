import 'package:flutter/material.dart';
import 'package:moviles/src/pages/NavigationBar.dart';
import 'package:moviles/src/pages/NavigationBar1.dart';
import 'package:moviles/src/pages/PasswordResetPage.dart';
import 'package:moviles/src/pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: LoginPage.id,
      routes: {
        LoginPage.id: (context) => LoginPage(),
        PasswordResetPage.id: (context) => PasswordResetPage(),
        NextPage.id: (context) => NextPage(),
        NextPage1.id: (context) => NextPage1(),
      },
    );
  }
}