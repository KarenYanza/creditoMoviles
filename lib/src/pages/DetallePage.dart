import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:moviles/models/anexocredito.dart';
import 'package:moviles/src/pages/PdfViewerPage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;
import 'package:signature/signature.dart';
import 'package:printing/printing.dart';
import '../../Services/globals.dart';
import '../../models/usuario.dart';

class DetallePage extends StatefulWidget {
  final Usuario usuario;
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
      required this.nombres,
      required this.usuario});
  @override
  _DetallePageState createState() => _DetallePageState();
}

class _DetallePageState extends State<DetallePage> {
  late Usuario usuario;
  List<AnexoCredito> anexosss = [];
  List<String> camposCorrectos = [];
  List<String> camposIncorrectos = [];
  List<String> camposNoaplica = [];
  bool isButtonDisabled = false;
  Map<String, String> respuestas = {};
  int id = 0;
  String? base64String;
  String estado = '';
  @override
  void initState() {
    super.initState();
    id = widget.soliid;
    listarAnexos(id);
    usuario = widget.usuario;
    print('este es el id');
    print(id);
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
      return WillPopScope(
        onWillPop: () async {
          return false; // Bloquea el botón de retroceso
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Detalles'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(
                    context); // Navegar hacia atrás al presionar el botón de retroceso
              },
            ),
          ),
          body: PDFView(
            filePath: pdfPath!,
          ),
        ),
      );
    } else {
      return WillPopScope(
        onWillPop: () async {
          return false; // Bloquea el botón de retroceso
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Detalles'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(
                    context); // Navegar hacia atrás al presionar el botón de retroceso
              },
            ),
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
                                      onPressed: disabledDownloadButtons
                                              .contains(index)
                                          ? null
                                          : () {
                                              downloadAndShowPdf(index);
                                            },
                                      child: Text('Descargar'),
                                    ),
                                  ),
                                  DataCell(
                                    Checkbox(
                                      value: checkStatus[e],
                                      onChanged: disabledDownloadButtons
                                              .contains(index)
                                          ? null
                                          : (value) {
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
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Firma'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Por favor, firme a continuación:'),
                                  SizedBox(height: 16),
                                  Signature(
                                    controller: _signatureController,
                                    height: 200,
                                    backgroundColor: Colors.white,
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _clearSignature();
                                  },
                                  child: Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _generateReport();
                                    Navigator.pop(context);
                                  },
                                  child: Text('Imprimir'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Firmar'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        bool allChecked =
                            checkStatus.values.every((element) => element);
                        bool anyNoAplica = camposNoaplica.isNotEmpty;
                        bool anyNo = checkStatus.values
                            .any((element) => element == false);

                        if (allChecked && !anyNoAplica) {
                          // Todos los campos están marcados como "Sí"
                          estado = 'Validada';
                        } else if (anyNo) {
                          // Al menos un campo está marcado como "No"
                          estado = 'Rechazada';
                        } else {
                          // Hay campos marcados como "No aplica"
                          // Aquí puedes definir qué hacer en este caso
                          estado = ''; // Estado indeterminado
                        }
                        print(estado);
                        await actualizarEstado(
                            id, estado); // Agregué el prefijo 'await'
                        print(estado);
                        String filePath = await getFilePath();
                        if (filePath.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PdfViewerPage(
                                filePath: filePath,
                                soliid: id,
                                usuario: usuario,
                              ),
                            ),
                          );
                        }
                      },
                      child: Text('Subir documentos'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Set<int> disabledDownloadButtons = Set<int>();

  Future<void> actualizarEstado(int id, String estadoRegistro) async {
    String url =
        '${APIConfig.baseURL}solicitud/actualizarEstado/$id?estadoRegistro=$estadoRegistro';
    print(url);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${APIConfig.authtoken}',
    };

    try {
      var response = await http.put(Uri.parse(url), headers: headers);
      print(response.statusCode);
      if (response.statusCode == 201) {
        // La solicitud se realizó con éxito
        print('Estado actualizado exitosamente');
      } else {
        // Ocurrió un error en la solicitud
        print('Error al actualizar el estado ');
      }
    } catch (e) {
      // Ocurrió un error de conexión
      print('Error de conexión: $e');
    }
  }

  Future<String> getFilePath() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      return result.files.single.path!;
    }

    return '';
  }

  Future<void> actualizarListaVerificacion(int id, String base64String) async {
    var url = Uri.parse(
        '${APIConfig.baseURL}controlcredito/actualizarListaVerificacion/$id?ListaVerificacion=$base64String');
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${APIConfig.authtoken}',
    };
    var body = {'ListaVerificacion': base64String};

    var response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Documento actualizado correctamente');
    } else {
      print('Error al actualizar el documento');
    }
  }

  Future<void> listarAnexos(int id) async {
    print("ingresa");
    String url = "${APIConfig.baseURL}anexoCredito/buscarAnexos/$id";
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer ${APIConfig.authtoken}',
    });
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
    } else {
      print("Error al obtener la lista");
    }
  }

  void downloadAndShowPdf(int index) async {
    if (anexosss.isNotEmpty) {
      String? base64PDF;
      switch (index) {
        case 0:
          base64PDF = anexosss[0].ane_cred_cedula_conyugue;
          break;
        case 1:
          base64PDF = anexosss[0].ane_cred_cedula_solicitante;
          break;
        case 2:
          base64PDF = anexosss[0].ane_cred_estado_tarjetas_credito;
          break;
        case 3:
          base64PDF = anexosss[0].ane_cred_facturas_alimentacion;
          break;
        case 4:
          base64PDF = anexosss[0].ane_cred_facturas_educacion;
          break;
        case 5:
          base64PDF = anexosss[0].ane_cred_facturas_otros;
          break;
        case 6:
          base64PDF = anexosss[0].ane_cred_facturas_salud;
          break;
        case 7:
          base64PDF = anexosss[0].ane_cred_facturas_servicios;
          break;
        case 8:
          base64PDF = anexosss[0].ane_cred_matriculas;
          break;
        case 9:
          base64PDF = anexosss[0].ane_cred_predios;
          break;
        case 10:
          base64PDF = anexosss[0].ane_cred_recibos_vivienda;
          break;
        case 11:
          base64PDF = anexosss[0].ane_cred_remesas;
          break;
        case 12:
          base64PDF = anexosss[0].ane_cred_roles_pago;
          break;
        default:
          base64PDF = null;
          break;
      }

      if (base64PDF != null && base64PDF.isNotEmpty) {
        List<int> pdfBytes = base64Decode(base64PDF);
        Directory tempDir = await getTemporaryDirectory();
        File tempFile = File('${tempDir.path}/documento.pdf');
        await tempFile.writeAsBytes(pdfBytes, flush: true);
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
                    setState(() {
                      disabledDownloadButtons.add(index);
                      camposNoaplica.add(checkStatus.keys.elementAt(index));
                    });
                  },
                  child: Text('Cerrar'),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error al cargar'),
            content: Text('El archivo no se pudo descargar.'),
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

  Future<String> pdfToBase64(String filePath) async {
    File file = File(filePath);
    if (await file.exists()) {
      List<int> pdfBytes = await file.readAsBytes();
      String base64String = base64Encode(pdfBytes);
      return base64String;
    } else {
      throw Exception('El archivo PDF no existe en la ubicación especificada.');
    }
  }

  Future<void> _generateReport() async {
    if (_signatureController.isNotEmpty) {
      final pdf = pw.Document();
      final signatureBytes = await _signatureController.toPngBytes();
      final signatureImage = pw.MemoryImage(signatureBytes!);
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Estado: $estado'),
                pw.Text('Id: ${widget.soliid}'),
                pw.Text('Nombre: ${widget.nombres}'),
                pw.Text('Fecha: ${widget.cred_fecha}'),
                pw.Text('Monto: ${widget.cred_monto}'),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Información adicional',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 20),
                pw.Table.fromTextArray(
                  context: context,
                  data: [
                    ['Campo', 'Si', 'No', 'No aplica'],
                    for (var entry in checkStatus.entries)
                      [
                        entry.key,
                        camposNoaplica.contains(entry.key)
                            ? ''
                            : (entry.value ? 'Si' : ''),
                        camposNoaplica.contains(entry.key)
                            ? ''
                            : (entry.value ? '' : 'No'),
                        camposNoaplica.contains(entry.key) ? 'No aplica' : '',
                      ],
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Text('Firma:'),
                pw.Image(signatureImage),
                pw.Text('Nombre:' +
                    usuario.persona.pers_nombres +
                    ' ' +
                    usuario.persona.pers_apellidos),
                pw.Text('Cedula:' + usuario.persona.pers_cedula),
                pw.Text('Sucursal:' + usuario.sucursal.sucu_nombre),
              ],
            );
          },
        ),
      );

      final tempPath = await getTemporaryDirectory();
      final tempFilePath = '${tempPath.path}/informe.pdf';
      final File tempFile = File(tempFilePath);
      await tempFile.writeAsBytes(await pdf.save());

      final base64String = await pdfToBase64(tempFilePath);
      print('base 64');
      print(base64String);
      String base = base64String;

      await Printing.sharePdf(bytes: await pdf.save(), filename: 'informe.pdf');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Firma'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Por favor, firme a continuación:'),
                SizedBox(height: 16),
                Signature(
                  controller: _signatureController,
                  height: 200,
                  backgroundColor: Colors.white,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _clearSignature();
                },
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  _generateReport();
                  Navigator.pop(context);
                },
                child: Text('Imprimir'),
              ),
            ],
          );
        },
      );
    }
  }
}

void _clearSignature() {
  _signatureController.clear();
}

final SignatureController _signatureController = SignatureController(
  penStrokeWidth: 2,
  penColor: Color.fromARGB(255, 37, 8, 223),
);
