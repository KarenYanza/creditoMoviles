import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviles/models/asesor.dart';
import 'package:moviles/models/usuario.dart';
import 'package:moviles/src/pages/DetallePage.dart';
import 'package:moviles/src/pages/login_page.dart';
import 'package:http/http.dart' as http;
import '../../Services/globals.dart';
import '../../models/solicitud.dart';

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
  List<Asesor> asslist = [];
  List<Tab> _tabs = [
    Tab(text: 'Todos'),
    Tab(text: 'Pendientes'),
    Tab(text: 'Aprobados'),
    Tab(text: 'Rechazados'),
  ];

  String _selectedEstado = 'Todos';

  @override
  void initState() {
    usuario = widget.usuario;
    super.initState();
    listarSolicitudesUsername(usuario.sucursal.sucu_id);
    print("sicirsal");
    print(usuario.sucursal.sucu_id);
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
              child: ConditionalCircularImageWidget(
                base64Image: usuario.persona.pers_foto,
                fallbackImage: 'images/logo.png',
              ),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: asslist.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          final asesor = asslist[index];
          return ListTile(
            title: Text(usuario.sucursal.sucu_nombre.toString()),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Solicitid: " + asesor.soliid.toString()),
                Text("Cedula: " + asesor.usuario_username.toString()),
                Text("Nombre: " + asesor.nombres.toString()),
                Text("Moto: " + asesor.cred_monto.toString()),
                Text("Estado: " + asesor.soli_estado_registro.toString()),
              ],
            ),
          );
        },
      ),

      /*TabBarView(
        controller: _tabController,
        children: [
          _buildTodosScreen(),
          _buildPendientesScreen(),
          _buildAprobadosScreen(),
          _buildRechazadosScreen(),
        ],
      ),*/
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
                  if (solicitud.soli_estado == "En proceso") {
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
                  }
                },
                child: ListTile(
                  title: Text(solicitud.persona.pers_nombres),
                  subtitle: Text(
                    'Fecha: ${solicitud.credito.cred_fecha} - Monto: ${solicitud.credito.cred_monto}',
                  ),
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

  Future<List<Solicitud>> listarSolicitudesEstado(String estado) async {
    try {
      String url = "${APIConfig.baseURL}solicitud/listarSoliEstado";
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

  Future<void> listarSolicitudesUsername(int id) async {
    print("ingresa");
    String url = "${APIConfig.baseURL}solicitud/listarSolicitudesSucursal/$id";
    final response = await http.get(Uri.parse(url));
    print(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print("Solicitudes obtenidad: ${jsonData}");
      setState(() {
        asslist =
            jsonData.map<Asesor>((item) => Asesor.fromJson(item)).toList();
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
