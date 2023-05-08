import 'package:flutter/material.dart';

class DetallePage extends StatefulWidget {
  final int id;
  final String nombre;
  final String fecha;
  final double monto;

  DetallePage({
    Key? key,
    required this.id,
    required this.nombre,
    required this.fecha,
    required this.monto,
  }) : super(key: key);

  @override
  _DetallePageState createState() => _DetallePageState();
}

class _DetallePageState extends State<DetallePage> {
  Map<String, bool> checkStatus = {
    'Cédula de Identidad Solicitante': false,
    'Cedula Ciudadania Conyugue': false,
    'Predio Urbano': false,
    'Matrícula del Vehículo': false,
    'Roles de pago': false,
    'Gastos de Vivienda': false,
    'Estado de cuenta de tarjeta de crédito': false,
    'Factura de consumo de alimentos': false,
    'Gastos Servicios Básicos': false,
    'Factura de Salud': false,
    'Factura de Educacion': false,
    'Letras de Cambio': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('ID: ${widget.id}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Nombre: ${widget.nombre}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Fecha: ${widget.fecha}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Monto: ${widget.monto}'),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Información adicional',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            DataTable(
              columns: [
                DataColumn(label: Text('Campo')),
                DataColumn(label: Text('PDF')),
                DataColumn(label: Text('Correcto')),
              ],
              rows: checkStatus.keys
                  .map(
                    (e) => DataRow(
                      cells: [
                        DataCell(Text(e)),
                        DataCell(
                          ElevatedButton(
                            onPressed: () {},
                            child: Text('Descargar'),
                          ),
                        ),
                        DataCell(
                          Checkbox(
                            value: checkStatus[e],
                            onChanged: (value) {
                              setState(() {
                                checkStatus[e] = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    bool allChecked =
                        checkStatus.values.every((element) => element);
                    if (allChecked) {
                      // Lógica para imprimir si todo está correcto
                      print('Todo está correcto');
                    } else {
                      // Lógica para imprimir si hay campos incorrectos
                      print('Hay campos incorrectos');
                    }
                  },
                  child: Text('Imprimir'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Todo Lógica para imprimir solo los campos correctos
                  },
                  child: Text('Subir documentos'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
