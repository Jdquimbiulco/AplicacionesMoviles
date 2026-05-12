import 'package:flutter/material.dart';
import '../../models/pago_model.dart';
import '../atoms/label_atom.dart';
import '../atoms/button_atom.dart';

class ResumenPagoOrganism extends StatelessWidget {
  final Pago pago;
  final VoidCallback onNuevoPago;

  const ResumenPagoOrganism({
    Key? key,
    required this.pago,
    required this.onNuevoPago,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LabelAtom(
            text: 'Resumen del Pago',
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24.0),
          // Datos del cliente
          _buildSeccion('DATOS DEL CLIENTE', [
            _buildFila('Nombre:', '${pago.nombre} ${pago.apellido}'),
            _buildFila('Email:', pago.email),
          ]),
          const SizedBox(height: 16.0),
          // Detalles del servicio
          _buildSeccion('DETALLES DEL SERVICIO', [
            _buildFila('Servicio:', pago.servicio.nombre),
            _buildFila('Tarifa:', '\$${pago.servicio.tarifa.toStringAsFixed(2)}/unidad'),
            _buildFila('Consumo:', '${pago.consumo.toStringAsFixed(2)} unidades'),
          ]),
          const SizedBox(height: 16.0),
          // Cálculos
          _buildSeccion('CÁLCULOS', [
            _buildFila('Subtotal:', '\$${pago.subtotal.toStringAsFixed(2)}'),
            if (pago.tieneProntoPago)
              _buildFila('Descuento (Pronto Pago):', '-\$${pago.descuentoProntoPago.toStringAsFixed(2)}', Colors.green),
            if (pago.tieneMora)
              _buildFila('Recargo (Mora):', '+\$${pago.recargoMora.toStringAsFixed(2)}', Colors.red),
            if (pago.tieneServicioAdicional)
              _buildFila('Servicio Adicional:', '+\$${pago.montoServicioAdicional.toStringAsFixed(2)}', Colors.orange),
          ]),
          const SizedBox(height: 24.0),
          // Total
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              border: Border.all(color: Colors.blue, width: 2.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const LabelAtom(
                  text: 'TOTAL A PAGAR:',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                LabelAtom(
                  text: '\$${pago.total.toStringAsFixed(2)}',
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32.0),
          // Botón Nuevo Pago
          SizedBox(
            width: double.infinity,
            child: ButtonAtom(
              label: 'Nuevo Pago',
              onPressed: onNuevoPago,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeccion(String titulo, List<Widget> contenido) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelAtom(
          text: titulo,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
        const SizedBox(height: 8.0),
        ...contenido,
      ],
    );
  }

  Widget _buildFila(String etiqueta, String valor, [Color color = Colors.black87]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LabelAtom(text: etiqueta),
          LabelAtom(
            text: valor,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ],
      ),
    );
  }
}