import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviles/models/asesor.dart';
import 'package:moviles/models/usuario.dart';
import 'package:moviles/src/pages/DetallePage.dart';
import 'package:moviles/src/pages/login_page.dart';
import 'package:http/http.dart' as http;
import '../../Services/globals.dart';

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
    Tab(text: 'Validados'),
    Tab(text: 'Rechazados'),
  ];

  String _selectedEstado = 'Todos';

  @override
  void initState() {
    usuario = widget.usuario;
    super.initState();
    listarSolicitudesUsername(usuario.sucursal.sucu_id);
    _tabController = TabController(length: _tabs.length, vsync: this);
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
              'Bienvenido',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 4), // Espacio entre los textos
            Text(
              '${usuario.persona.pers_nombres} ${usuario.persona.pers_apellidos}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
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
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTodosScreen(),
          _buildPendientesScreen(),
          _buildAprobadosScreen(),
          _buildRechazadosScreen(),
        ],
      ),
      ),
    );
  }

  Widget _buildTodosScreen() {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: asslist.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final asesor = asslist[index];
              return Card(
                elevation: 2,
                child: ListTile(
                  title: Text(
                    asesor.nombres.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Text(
                        "Solicitud: " + asesor.soliid.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Cedula: " + asesor.usuario_username,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Monto: " + asesor.cred_monto.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Estado: " + asesor.soli_estado_registro.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          color: Colors.grey[300],
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              " Sucursal " + usuario.sucursal.sucu_nombre.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPendientesScreen() {
    List<Asesor> filteredList = asslist
        .where((asesor) => asesor.soli_estado_registro == 'Registrado')
        .toList();

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: filteredList.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final asesor = filteredList[index];
              return Card(
                elevation: 2,
                child: ListTile(
                  title: Text(
                    asesor.nombres.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Text(
                        "Solicitud: " + asesor.soliid.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Cedula: " + asesor.usuario_username,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Monto: " + asesor.cred_monto.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Estado: " + asesor.soli_estado_registro.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetallePage(
                          soliid: asesor.soliid,
                          cred_fecha: asesor.cred_fecha,
                          cred_monto: asesor.cred_monto,
                          soli_estado_registro: asesor.soli_estado_registro,
                          usuario_username: asesor.usuario_username,
                          sucuid: asesor.sucuid,
                          nombres: asesor.nombres,
                          usuario: usuario,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          color: Colors.grey[300],
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              " Sucursal " + usuario.sucursal.sucu_nombre.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAprobadosScreen() {
    List<Asesor> filteredList = asslist
        .where((asesor) => asesor.soli_estado_registro == 'Validado')
        .toList();

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: filteredList.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final asesor = filteredList[index];
              return Card(
                elevation: 2,
                child: ListTile(
                  title: Text(
                    asesor.nombres.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Text(
                        "Solicitud: " + asesor.soliid.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Cedula: " + asesor.usuario_username,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Monto: " + asesor.cred_monto.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Estado: " + asesor.soli_estado_registro.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          color: Colors.grey[300],
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              " Sucursal " + usuario.sucursal.sucu_nombre.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRechazadosScreen() {
    List<Asesor> filteredList = asslist
        .where((asesor) => asesor.soli_estado_registro == 'Rechazado')
        .toList();

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: filteredList.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final asesor = filteredList[index];
              return Card(
                elevation: 2,
                child: ListTile(
                  title: Text(
                    asesor.nombres.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Text(
                        "Solicitud: " + asesor.soliid.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Cedula: " + asesor.usuario_username,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Monto: " + asesor.cred_monto.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Estado: " + asesor.soli_estado_registro.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          color: Colors.grey[300],
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              " Sucursal " + usuario.sucursal.sucu_nombre.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
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
