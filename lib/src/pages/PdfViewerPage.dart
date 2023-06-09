import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:moviles/Services/globals.dart';
import 'package:moviles/src/pages/NavigationBar.dart';
import '../../models/usuario.dart';
import 'NavigationBar1.dart';

class PdfViewerPage extends StatefulWidget {
  final Usuario usuario;
  final int soliid;
  final String filePath;
  PdfViewerPage(
      {required this.soliid, required this.filePath, required this.usuario});

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  String base64PDF = '';
  List<int>? bytesPDF;
  late Usuario usuario;

  Future<void> convertToBase64AndBytes() async {
    File file = File(widget.filePath);
    List<int> bytes = await file.readAsBytes();
    String base64 = base64Encode(bytes);

    setState(() {
      base64PDF = base64;
      bytesPDF = bytes;
    });
  }

  int id = 0;
  @override
  void initState() {
    super.initState();
    id = widget.soliid;
    usuario = widget.usuario;
    convertToBase64AndBytes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PDFView(
              filePath: widget.filePath,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Aquí puedes realizar la lógica para subir el PDF a la base de datos
              if (base64PDF.isNotEmpty && bytesPDF != null) {
                subirPDF(widget.filePath, widget.soliid);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NextPage(usuario: usuario)),
                );
                // Subir el PDF utilizando base64PDF o bytesPDF
                // print('PDF convertido en base64: $base64PDF');
              }
            },
            child: Text('Subir'),
          ),
        ],
      ),
    );
  }

  Future<void> subirPDF(String filePath, int id) async {
    try {
      var url = Uri.parse(
          '${APIConfig.baseURL}controlcredito/actualizarListaVerificacion/$id');

      var request = http.MultipartRequest('PUT', url);
      print(url);
      var file = await http.MultipartFile.fromPath('file', filePath);
      request.files.add(file);

      request.headers['Authorization'] = 'Bearer ${APIConfig.authtoken}';

      var response = await request.send();
      print(response);
      print(id);
      if (response.statusCode == 201) {
        // La solicitud se realizó con éxito
        print('Actualización exitosa');
      } else {
        // Ocurrió un error en la solicitud
        print('Error en la actualización ${response.statusCode}');
      }
    } catch (e) {
      // Ocurrió un error en la conexión
      print('Error de conexión: $e');
    }
  }
}
