import 'package:flutter/material.dart';
import 'package:pry_themes/modelos/servicio_lavado_modelo.dart';
import 'moleculas/resumen_nota.dart';

// PÁGINA / VISTA: Nota de Venta (resultado)
// Pantalla que muestra el resumen del servicio y totales
// Ruta: /notaVenta
// Recibe el ServicioLavadoModelo como argumento
class VistaNotaVenta extends StatelessWidget {
  const VistaNotaVenta({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final ServicioLavadoModelo servicio = args is ServicioLavadoModelo
        ? args
        : ServicioLavadoModelo();

    return Scaffold(
      appBar: AppBar(title: const Text('Nota de venta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'NOTA DE VENTA',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ResumenNota(servicio: servicio),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.popUntil(context, ModalRoute.withName('/lavado')),
                child: const Text('Volver'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
