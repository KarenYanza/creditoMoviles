import 'package:flutter/material.dart';
import 'package:moviles/src/pages/DetallePage.dart';
import 'package:moviles/src/pages/login_page.dart';

class NextPage1 extends StatefulWidget {
  static String id = 'next_page1';

  @override
  _NextPageState1 createState() => _NextPageState1();
}

class _NextPageState1 extends State<NextPage1>
    with SingleTickerProviderStateMixin {
  final List<Solicitud> solicitudes = [
    Solicitud(fecha: '02/05/2023', monto: 200.0, estado: 'Aprobado'),
    Solicitud(fecha: '01/05/2023', monto: 150.0, estado: 'Rechazado'),
    Solicitud(fecha: '29/04/2023', monto: 100.0, estado: 'Pendiente'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabla de Solicitudes'),
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
                backgroundImage: AssetImage('images/logo.png'),
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
      ),
    );
  }
}

class Solicitud {
  final String fecha;
  final double monto;
  final String estado;

  Solicitud({required this.fecha, required this.monto, required this.estado});
}
