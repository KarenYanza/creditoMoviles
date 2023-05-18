import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviles/models/usuario.dart';
import 'package:moviles/src/pages/DetallePage.dart';
import 'package:moviles/src/pages/login_page.dart';
import 'package:http/http.dart' as http;
import '../../models/solicitud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/rendering.dart' as rendering;
import 'dart:ui' as ui;

class NextPage extends StatefulWidget {
  final Usuario usuario;

  NextPage({required this.usuario});
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage>
    with SingleTickerProviderStateMixin {
  late Usuario usuario;
  late TabController _tabController;
  List<Tab> _tabs = [
    Tab(text: 'Todos'),
    Tab(text: 'Pendientes'),
    Tab(text: 'Aprobados'),
    Tab(text: 'Rechazados'),
  ];

  // Agrega una variable para almacenar el estado seleccionado
  String _selectedEstado = 'Todos';
/*class _NextPageState extends State<NextPage>
    with SingleTickerProviderStateMixin {
  late Usuario usuario;
  late TabController _tabController;
  List<Tab> _tabs = [
    Tab(text: 'Todos'),
    Tab(text: 'Pendientes'),
    Tab(text: 'Aprobados'),
    Tab(text: 'Rechazados'),
  ];

  static List<Factura> _data = [
    Factura(
        id: 1, nombre: 'Karen Yanzaguano', fecha: '01/01/2022', monto: 100.0),
    Factura(
        id: 2, nombre: 'Anthony Morocho', fecha: '02/01/2022', monto: 200.0),
    Factura(id: 3, nombre: 'Laura Zambrano', fecha: '03/01/2022', monto: 300.0),
  ];*/
  @override
  void initState() {
    usuario = widget.usuario;
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    print(usuario.usua_preguntaDos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Bienvenido ${usuario.persona.pers_nombres} ${usuario.persona.pers_apellidos}  '),
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs,
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
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTodosScreen(),
          _buildPendientesScreen(),
          _buildAprobadosScreen(),
          _buildRechazadosScreen(),
        ],
      ),
    );
  }

  Widget _buildTodosScreen() {
    return FutureBuilder<List<Solicitud>>(
      future: listarSolicitudesEstado('Todos'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Solicitud> solicitudes = snapshot.data!;
          print(solicitudes);
          return ListView.builder(
            itemCount: solicitudes.length,
            itemBuilder: (context, index) {
              final solicitud = solicitudes[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => DetallePage(
                        id: solicitud.soli_id,
                        nombre: solicitud.persona.pers_nombres +
                            solicitud.persona.pers_apellidos,
                        fecha: solicitud.credito.cred_fecha,
                        monto: solicitud.credito.cred_monto,
                      ),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(solicitud.persona.pers_nombres),
                  subtitle: Text(
                      'Fecha: ${solicitud.credito.cred_fecha} - Monto: ${solicitud.credito.cred_monto}'),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error al cargar las solicitudes');
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildPendientesScreen() {
    return FutureBuilder<List<Solicitud>>(
      future: listarSolicitudesEstado('Pendientes'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Solicitud> solicitudes = snapshot.data!;
          // Construye la pantalla utilizando las solicitudes pendientes
          // ...
          return ListView.builder(
            itemCount: solicitudes.length,
            itemBuilder: (context, index) {
              Solicitud solicitud = solicitudes[index];
              return ListTile(
                title: Text(solicitud.credito.cred_fecha),
                subtitle: Text(solicitud.credito.cred_plazo),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error al cargar las solicitudes pendientes');
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildAprobadosScreen() {
    return FutureBuilder<List<Solicitud>>(
      future: listarSolicitudesEstado('Aprobados'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Solicitud> solicitudes = snapshot.data!;
          // Construir la pantalla utilizando las solicitudes aprobadas
          return ListView.builder(
            itemCount: solicitudes.length,
            itemBuilder: (context, index) {
              Solicitud solicitud = solicitudes[index];
              return ListTile(
                title: Text(solicitud.credito.cred_fecha),
                subtitle: Text(solicitud.credito.cred_plazo),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error al cargar las solicitudes aprobadas');
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildRechazadosScreen() {
    return FutureBuilder<List<Solicitud>>(
      future: listarSolicitudesEstado('Rechazados'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Solicitud> solicitudes = snapshot.data!;
          // Construir la pantalla utilizando las solicitudes rechazadas
          return ListView.builder(
            itemCount: solicitudes.length,
            itemBuilder: (context, index) {
              Solicitud solicitud = solicitudes[index];
              return ListTile(
                title: Text(solicitud.credito.cred_fecha),
                subtitle: Text(solicitud.credito.cred_plazo),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error al cargar las solicitudes rechazadas');
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  MemoryImage? imageFromBase64String(String base64String) {
    try {
      Uint8List bytes = base64Decode(base64String);
      img.Image originalImage = img.decodeImage(bytes)!;
      img.Image resizedImage =
          img.copyResize(originalImage, width: 200, height: 200);
      Uint8List resizedBytes = img.encodePng(resizedImage) as Uint8List;
      return MemoryImage(resizedBytes);
    } catch (error) {
      print('Error al cargar la imagen: $error');
      return null;
    }
  }

  Future<List<Solicitud>> listarSolicitudesEstado(String estado) async {
    try {
      String url = "http://localhost:8080/api/solicitud/listarSoliEstado";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        List<Solicitud> solicitudes = [];
        for (var item in jsonResponse) {
          solicitudes.add(Solicitud.fromJson(item));
        }
        return solicitudes;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }
/*
class Factura {
  final int id;
  final String nombre;
  final String fecha;
  final double monto;

  Factura({
    required this.id,
    required this.nombre,
    required this.fecha,
    required this.monto,
  });
}*/
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
