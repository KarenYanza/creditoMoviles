import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moviles/src/pages/login_page.dart';
import 'dart:convert';

import '../../models/solicitud.dart';
import '../../models/usuario.dart';

class NextPage1 extends StatefulWidget {
  final Usuario usuario;

  NextPage1({required this.usuario});
  @override
  _NextPageState1 createState() => _NextPageState1();
}

class _NextPageState1 extends State<NextPage1>
    with SingleTickerProviderStateMixin {
  late Usuario usuario;
  List<Solicitud> _solicitudes = [];

  @override
  void initState() {
    usuario = widget.usuario;
    listarSolicitudesUsername(usuario.usua_username);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bienvenido ${usuario.persona.pers_nombres} ${usuario.persona.pers_apellidos}',
        ),
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Cerrar sesión"),
                    content: Text("¿Está seguro de que desea cerrar sesión?"),
                    actions: [
                      TextButton(
                        child: Text("Cancelar"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text("Aceptar"),
                        onPressed: () {
                          Navigator.of(context).pushNamed(LoginPage.id);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularImageWidget(usuario.persona.pers_foto),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: DataTable(
          columns: [
            DataColumn(label: Text('Fecha')),
            DataColumn(label: Text('Monto')),
            DataColumn(label: Text('Estado')),
          ],
          rows: _solicitudes
              .map(
                (solicitud) => DataRow(
                  cells: [
                    DataCell(Text(solicitud.credito.cred_fecha)),
                    DataCell(Text(solicitud.credito.cred_fecha.toString())),
                    DataCell(Text(solicitud.soli_estado)),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Future<void> listarSolicitudesUsername1(String username) async {
    try {
      String url =
          "http://localhost:8080/api/solicitud/listarSolicitudesUsername/$username";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        Solicitud solicitud = Solicitud.fromJson(jsonResponse);
        solicitud.credito.cred_estado;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuario o contraseña inválido')),
        );
      }
    } catch (error) {}
  }

  Future<List<Solicitud>> listarSolicitudesUsername(String username) async {
    try {
      String url =
          "http://localhost:8080/api/solicitud/listarSolicitudesUsername/$username";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        _solicitudes = [];
        for (var item in jsonResponse) {
          _solicitudes.add(Solicitud.fromJson(item));
        }
        return _solicitudes;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }
}

class CircularImageWidget extends StatelessWidget {
  final String base64Image;

  CircularImageWidget(this.base64Image);

  @override
  Widget build(BuildContext context) {
    String base64ImageWithoutHeader = base64Image.split(',').last;
    Uint8List bytes = base64.decode(base64ImageWithoutHeader);

    return ClipOval(
      child: Image.memory(
        bytes,
        fit: BoxFit.cover,
      ),
    );
  }
}
