import 'package:flutter/material.dart';
import 'package:moviles/models/usuario.dart';
import 'package:moviles/src/pages/DetallePage.dart';
import 'package:moviles/src/pages/login_page.dart';

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

  static List<Factura> _data = [
    Factura(
        id: 1, nombre: 'Karen Yanzaguano', fecha: '01/01/2022', monto: 100.0),
    Factura(
        id: 2, nombre: 'Anthony Morocho', fecha: '02/01/2022', monto: 200.0),
    Factura(id: 3, nombre: 'Laura Zambrano', fecha: '03/01/2022', monto: 300.0),
  ];
  @override
  void initState() {
    usuario = widget.usuario;
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    print(usuario.usua_PreguntaDos);
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
              child: CircleAvatar(
                // backgroundImage: AssetImage('images/logo.png'),

                backgroundImage: Image.network(
                  'https://estaticos-cdn.sport.es/clip/ca7f0dcb-54dc-4929-9cf4-b085528d8219_media-libre-aspect-ratio_default_0.jpg',
                  //usuario.persona.pers_foto,
                ).image,
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
    );
  }

  Widget _buildTodosScreen() {
    return ListView.builder(
      itemCount: _data.length,
      itemBuilder: (context, index) {
        final item = _data[index];
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => DetallePage(
                  id: item.id,
                  nombre: item.nombre,
                  fecha: item.fecha,
                  monto: item.monto,
                ),
              ),
            );
          },
          child: ListTile(
            title: Text(item.nombre),
            subtitle: Text('Fecha: ${item.fecha} - Monto: ${item.monto}'),
          ),
        );
      },
    );
  }

  Widget _buildPendientesScreen() {
    // código para construir la pantalla de datos pendientes
    return Center(
      child: Text('Pantalla de datos pendientes'),
    );
  }

  Widget _buildAprobadosScreen() {
    // código para construir la pantalla de datos aprobados
    return Center(
      child: Text('Pantalla de datos aprobados'),
    );
  }

  Widget _buildRechazadosScreen() {
    // código para construir la pantalla de datos rechazados
    return Center(
      child: Text('Pantalla de datos rechazados'),
    );
  }
}

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
}
