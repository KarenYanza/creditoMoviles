import 'package:flutter/material.dart';

class DetallePage extends StatelessWidget {
  final int id;
  final String nombre;
  final String fecha;
  final double monto;

  const DetallePage({
    Key? key,
    required this.id,
    required this.nombre,
    required this.fecha,
    required this.monto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('ID: $id'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Nombre: $nombre'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Fecha: $fecha'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Monto: $monto'),
          ),
        ],
      ),
    );
  }
}
