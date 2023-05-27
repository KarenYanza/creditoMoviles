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
    return WillPopScope(
      onWillPop: () async {
        // Evitar que el usuario retroceda
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bienvenid@',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 4), // Espacio entre los textos
              Text(
                '${usuario.persona.pers_nombres} ${usuario.persona.pers_apellidos}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
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
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  'Solicitudes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Cédula: ${usuario.persona.pers_cedula}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 20,
                      columns: [
                        DataColumn(
                          label: Container(
                            width: 60,
                            child: Text(
                              'ID',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Fecha',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Monto',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Estado',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                      rows: solicitudes.map((solicitud1) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Container(
                                width: 60,
                                child: Text(
                                  solicitud1.soliid.toString(),
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    String estadoRegistro = solicitud1
                                        .soli_estado_registro
                                        .toLowerCase();
                                    IconData icono = Icons.sentiment_satisfied;
                                    Color colorBarra = Colors.blue;
                                    double valorProgreso = 1.0;

                                    if (estadoRegistro == 'registrada') {
                                      icono = Icons.sentiment_satisfied;
                                      colorBarra =
                                          Color.fromARGB(255, 105, 137, 163);
                                      valorProgreso = 0.1;
                                    } else if (estadoRegistro == 'validada') {
                                      icono = Icons.sentiment_neutral;
                                      colorBarra = Colors.yellow;
                                      valorProgreso = 0.5;
                                    } else if (estadoRegistro == 'aprobada') {
                                      icono = Icons.sentiment_satisfied_alt;
                                      colorBarra = Colors.green;
                                      valorProgreso = 1.0;
                                    } else if (estadoRegistro == 'rechazada') {
                                      icono = Icons.sentiment_dissatisfied;
                                      colorBarra = Colors.red;
                                      valorProgreso = 1.0;
                                    }

                                    return AlertDialog(
                                      title: Text(
                                          'Solicitud # ${solicitud1.soliid}'),
                                      content: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                              'Fecha: ${solicitud1.cred_fecha.toString()}'),
                                          Text(
                                              'Monto: ${solicitud1.cred_monto.toString()}'),
                                          SizedBox(height: 20),
                                          Row(
                                            children: [
                                              Icon(icono, size: 40),
                                              SizedBox(width: 20),
                                              Expanded(
                                                child: LinearProgressIndicator(
                                                  value: valorProgreso,
                                                  backgroundColor: Colors.grey,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(colorBarra),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          child: Text('Cerrar'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            DataCell(
                              Text(
                                solicitud1.cred_fecha.toString(),
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            DataCell(
                              Text(
                                solicitud1.cred_monto.toString(),
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            DataCell(
                              Text(
                                solicitud1.soli_estado_registro.toString(),
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
