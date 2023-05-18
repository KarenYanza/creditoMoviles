import 'package:flutter/material.dart';
import 'package:moviles/models/usuario.dart';
import 'package:moviles/src/pages/DetallePage.dart';
import 'package:moviles/src/pages/login_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/solicitud.dart';

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

  /*final List<Solicitud> solicitudes = [
    Solicitud(fecha: '02/05/2023', monto: 200.0, estado: 'Aprobado'),
    Solicitud(fecha: '01/05/2023', monto: 150.0, estado: 'Rechazado'),
    Solicitud(fecha: '29/04/2023', monto: 100.0, estado: 'Pendiente'),
  ];*/
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
            'Bienvenido ${usuario.persona.pers_nombres} ${usuario.persona.pers_apellidos}  '),
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
              child: CircleAvatar(
                // backgroundImage: AssetImage('images/logo.png'),

                //backgroundImage: Image.network(
                  //'https://estaticos-cdn.sport.es/clip/ca7f0dcb-54dc-4929-9cf4-b085528d8219_media-libre-aspect-ratio_default_0.jpg',
                  //usuario.persona.pers_foto+"",
               // ).image,
              ),
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
        .map((solicitud) => DataRow(
              cells: [
                DataCell(Text(solicitud.credito.cred_fecha)),
                DataCell(Text(solicitud.credito.cred_fecha.toString())),
                DataCell(Text(solicitud.soli_estado)),
              ],
            ))
        .toList(),
  ),
),
      /*body: SingleChildScrollView(
        child: DataTable(
          columns: [
            DataColumn(label: Text('Fecha')),
            DataColumn(label: Text('Monto')),
            DataColumn(label: Text('Estado')),
          ],
          rows: solicitudes
              .map((solicitud) => DataRow(
                    cells: [
                      DataCell(Text(solicitud.fecha)),
                      DataCell(Text(solicitud.monto.toString())),
                      DataCell(Text(solicitud.estado)),
                    ],
                  ))
              .toList(),
        ),
      ),*/
    );
  }
  Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
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

/*class Solicitud {
  final String fecha;
  final double monto;
  final String estado;

  Solicitud({required this.fecha, required this.monto, required this.estado});
}*/
