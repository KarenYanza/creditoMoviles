import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

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

  String? pdfPath;

  @override
  Widget build(BuildContext context) {
    if (pdfPath != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Detalles'),
        ),
        body: PDFView(
          filePath: pdfPath!,
        ),
      );
    } else {
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
                              onPressed: () {
                                downloadAndShowPdf();
                              },
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
                        // Buscamos los campos incorrectos y los imprimimos
                        List<String> incorrectos = [];
                        checkStatus.forEach((campo, correcto) {
                          if (!correcto) {
                            incorrectos.add(campo);
                          }
                        });
                        print(
                            'Hay campos incorrectos: ${incorrectos.join(", ")}');
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

  void downloadAndShowPdf() async {
    // Simulando la descarga del archivo PDF en base64
    String base64PDF = "<aquí va tu base64 del archivo PDF>";

    // Decodificar el archivo PDF base64 a bytes
    List<int> pdfBytes = base64Decode(base64PDF);

    // Obtener el directorio temporal del dispositivo
    Directory tempDir = await getTemporaryDirectory();

    // Crear un archivo temporal para el PDF
    File tempFile = File('${tempDir.path}/documento.pdf');

    // Escribir los bytes del PDF en el archivo temporal
    await tempFile.writeAsBytes(pdfBytes, flush: true);

    // Obtener la ruta del archivo PDF descargado
    String path = tempFile.path;

    setState(() {
      // Almacenar la ruta del archivo PDF en la variable pdfPath
      pdfPath = path;
    });
  }
}
