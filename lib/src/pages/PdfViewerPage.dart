import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:moviles/models/usuario.dart';

import '../../Services/globals.dart';
import 'NavigationBar1.dart';

class PdfViewerPage extends StatefulWidget {
  final int soliid;
  final String filePath;
  late Usuario usuario;

  PdfViewerPage({required this.soliid, required this.filePath});

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  String base64PDF = '';
  List<int>? bytesPDF;

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
                /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NextPage1(),
                  ),
                );*/
                // Subir el PDF utilizando base64PDF o bytesPDF
                // print('PDF convertido en base64: $base64PDF');
                print('PDF convertido en bytes: $bytesPDF');
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
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse(
            'http://192.168.0.106:8080/api/controlcredito/actualizarListaVerificacion/7'),
      );

      var file = await http.MultipartFile.fromPath('file', filePath);
      request.files.add(file);

      var response = await request.send();

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
