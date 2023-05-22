import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moviles/src/pages/login_page.dart';
import 'dart:convert';

import '../../Services/globals.dart';
import '../../models/solicitud1.dart';
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
  List<Solicitud1> solicitudes = [];
  bool _isLoading = true;

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
                child: ConditionalCircularImageWidget(
                  base64Image: usuario.persona.pers_foto,
                  fallbackImage: 'images/logo.png',
                ),
              ),
            ),
          ],
        ),
        body: ListView.separated(
            itemCount: solicitudes.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final solicitud = solicitudes[index];
              return ListTile(
                title: Text(usuario.persona.pers_cedula.toString()),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ID: ' + solicitud.soliid.toString()),
                    Text('Fecha: ' + solicitud.cred_fecha.toString()),
                    Text('Monto: ' + solicitud.cred_monto.toString()),
                    Text(
                        'Estado: ' + solicitud.soli_estado_registro.toString()),
                  ],
                ),
              );
            }));
    /*body: Table(
        border: TableBorder.all(color: Colors.black),
        children: [
          TableRow(
            children: [
              TableCell(
                  child: Text('ID',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              TableCell(
                  child: Text('Fecha',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              TableCell(
                  child: Text('Monto',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              TableCell(
                  child: Text('Estado',
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
          ...solicitudes.map((solicitud1) => TableRow(
                children: [
                  TableCell(child: Text(solicitud1.soliid.toString())),
                  TableCell(child: Text(solicitud1.cred_fecha.toString())),
                  TableCell(child: Text(solicitud1.cred_monto.toString())),
                  TableCell(
                      child: Text(solicitud1.soli_estado_registro.toString())),
                ],
              )),
        ],
      ),
    );*/
  }

  Future<void> listarSolicitudesUsername(String username) async {
    print("ingresa");
    String url =
        "${APIConfig.baseURL}solicitud/listarSolicitudesUsername/$username";
    final response = await http.get(Uri.parse(url));
    print(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print("Solicitudes obtenidad: ${jsonData}");
      setState(() {
        solicitudes = jsonData
            .map<Solicitud1>((item) => Solicitud1.fromJson(item))
            .toList();
      });
    } else {
      print("Error al obtener la lista");
    }
  }
}

class ConditionalCircularImageWidget extends StatelessWidget {
  final String base64Image;
  final String fallbackImage;

  ConditionalCircularImageWidget(
      {required this.base64Image, required this.fallbackImage});

  @override
  Widget build(BuildContext context) {
    if (base64Image == null || base64Image.isEmpty) {
      return ClipOval(
        child: Image.asset(
          fallbackImage,
          fit: BoxFit.cover,
        ),
      );
    } else {
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
}
