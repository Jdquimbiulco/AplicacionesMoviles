import 'package:flutter/material.dart';
import 'package:pry_themes/modelos/servicio_lavado_modelo.dart';
import '../atomos/etiqueta.dart';

// MOLÉCULA: Resumen de Nota de Venta
// Componente que muestra un resumen del servicio con datos y totales
// Se usa en la pantalla de nota de venta
class ResumenNota extends StatelessWidget {
  const ResumenNota({super.key, required this.servicio});

  final ServicioLavadoModelo servicio;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Etiqueta('Cliente: ${servicio.nombreCliente}'),
        const SizedBox(height: 8),
        Etiqueta('Vehículo: ${servicio.tipoVehiculo.label()}'),
        Etiqueta('Lavado: ${servicio.tipoLavado.label()}'),
        Etiqueta('Adicional: ${servicio.servicioAdicional.label()}'),
        const Divider(height: 20),
        Etiqueta('Subtotal: ${servicio.subtotal.toStringAsFixed(2)}'),
        Etiqueta('IVA 15%: ${servicio.iva.toStringAsFixed(2)}'),
        const SizedBox(height: 8),
        Etiqueta(
          'Total: ${servicio.total.toStringAsFixed(2)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
