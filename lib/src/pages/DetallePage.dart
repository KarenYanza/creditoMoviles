import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:moviles/models/anexocredito.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../../Services/globals.dart';
import '../../models/asesor.dart';
import '../../models/usuario.dart';

class DetallePage extends StatefulWidget {
  final int soliid;
  final String cred_fecha;
  final double cred_monto;
  final String soli_estado_registro;
  final String usuario_username;
  final int sucuid;
  final String nombres;
  DetallePage(
      {required this.soliid,
      required this.cred_fecha,
      required this.cred_monto,
      required this.soli_estado_registro,
      required this.usuario_username,
      required this.sucuid,
      required this.nombres});

  @override
  _DetallePageState createState() => _DetallePageState();
}

class _DetallePageState extends State<DetallePage> {
  List<AnexoCredito> anexosss = [];
  @override
  void initState() {
    super.initState();
    int id = widget.soliid;
    listarAnexos(id);
  }

  List<AnexoCredito> anexlist = [];
  Map<String, bool> checkStatus = {
    'Cedula Ciudadania Conyugue': false,
    'Cédula de Identidad Solicitante': false,
    'Estado de cuenta de tarjeta de crédito': false,
    'Factura de consumo de alimentos': false,
    'Factura de Educacion': false,
    'Otros gastos': false,
    'Factura de Salud': false,
    'Gastos Servicios Básicos': false,
    'Matrícula del Vehículo': false,
    'Predio Urbano': false,
    'Gastos de Vivienda': false,
    'Remesas': false,
    'Roles de pago': false,
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
                child: Text('Id: ${widget.soliid}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Nombre: ${widget.nombres}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Fecha: ${widget.cred_fecha}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Monto: ${widget.cred_monto}'),
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
                rows: checkStatus.keys.isNotEmpty
                    ? List.from(checkStatus.keys)
                        .asMap()
                        .map(
                          (index, e) => MapEntry(
                            index,
                            DataRow(
                              cells: [
                                DataCell(Text(e)),
                                DataCell(
                                  ElevatedButton(
                                    onPressed: () {
                                      downloadAndShowPdf(index);
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
                          ),
                        )
                        .values
                        .toList()
                    : [],
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

  // Lista para almacenar los resultados de la consulta

  Future<void> listarAnexos(int id) async {
    print("ingresa");
    String url = "${APIConfig.baseURL}anexoCredito/buscarAnexos/$id";
    final response = await http.get(Uri.parse(url));
    print(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print("Solicitudes obtenidas: ${jsonData}");
      setState(() {
        anexosss = jsonData
            .map<AnexoCredito>((item) => AnexoCredito.fromJson(item))
            .toList();
        print(anexosss);
      });

      // Realizar cualquier otra acción necesaria con la lista anexlist
      // ...
    } else {
      print("Error al obtener la lista");
    }
  }

  void downloadAndShowPdf(int index) async {
    String? base64PDF;

    switch (index) {
      case 0:
        base64PDF = anexosss[0]?.ane_cred_cedula_conyugue;
        break;
      case 1:
        base64PDF = anexosss[0]?.ane_cred_cedula_solicitante;
        break;
      case 2:
        base64PDF = anexosss[0]?.ane_cred_estado_tarjetas_credito;
        break;
      case 3:
        base64PDF = anexosss[0]?.ane_cred_facturas_alimentacion;
        break;
      case 4:
        base64PDF = anexosss[0]?.ane_cred_facturas_educacion;
        break;
      case 5:
        base64PDF = anexosss[0]?.ane_cred_facturas_otros;
        break;
      case 6:
        base64PDF = anexosss[0]?.ane_cred_facturas_salud;
        break;
      case 7:
        base64PDF = anexosss[0]?.ane_cred_facturas_servicios;
        break;
      case 8:
        base64PDF = anexosss[0]?.ane_cred_matriculas;
        break;
      case 9:
        base64PDF = anexosss[0]?.ane_cred_predios;
        break;
      case 10:
        base64PDF = anexosss[0]?.ane_cred_recibos_vivienda;
        break;
      case 11:
        base64PDF = anexosss[0]?.ane_cred_remesas;
        break;
      case 12:
        base64PDF = anexosss[0]?.ane_cred_roles_pago;
        break;
      default:
        base64PDF = null;
        break;
    }

    if (base64PDF != null && base64PDF.isNotEmpty) {
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

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('PDF'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            content: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.8,
              child: PDFView(
                filePath: path,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cerrar'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('No aplica'),
            content: Text('El archivo no está disponible.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cerrar'),
              ),
            ],
          );
        },
      );
    }
  }
}
