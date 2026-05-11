import 'package:flutter/material.dart';
import 'package:factura_choferes/controller/choferes_controller.dart';
import 'package:factura_choferes/widgets/boton.dart';
import 'package:factura_choferes/widgets/labels.dart';

class ResultadoView extends StatefulWidget {
  final ChoferesController controller;

  const ResultadoView({Key? key, required this.controller}) : super(key: key);

  @override
  State<ResultadoView> createState() => _ResultadoViewState();
}

class _ResultadoViewState extends State<ResultadoView> {
  late String reporte;

  @override
  void initState() {
    super.initState();
    reporte = widget.controller.generarReporte();
  }

  void _copiarAlPortapapeles() {
    // En una app real, usaríamos: Clipboard.setData(ClipboardData(text: reporte));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reporte copiado al portapapeles')),
    );
  }

  void _volver() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reporte de Nómina'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Resumen rápido
            Card(
              color: Colors.deepPurple.shade50,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'RESUMEN GENERAL',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Label(
                      title: 'Total a Pagar',
                      value: '\$${widget.controller.getTotalGeneralNomina().toStringAsFixed(2)}',
                      fontSize: 20,
                      isBold: true,
                    ),
                    const SizedBox(height: 12),
                    Label(
                      title: 'Chofer con más horas el lunes',
                      value: widget.controller.getChoferMasHorasLunes(),
                      fontSize: 16,
                    ),
                    const SizedBox(height: 12),
                    Label(
                      title: 'Total de horas el lunes',
                      value: '${widget.controller.getTotalHorasLunes().toStringAsFixed(1)} horas',
                      fontSize: 16,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Detalles por chofer
            const Text(
              'DETALLES POR CHOFER',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(widget.controller.choferes.length, (index) {
              var chofer = widget.controller.choferes[index];
              const dias = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'];

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chofer ${index + 1}: ${chofer.nombre}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const Divider(),
                      ResultLabel(
                        text: 'Tipo de Jornada: ${chofer.tipoChofer}',
                      ),
                      ResultLabel(
                        text: 'Estado: ${chofer.esActivo ? 'Activo' : 'Inactivo'}',
                      ),
                      ResultLabel(
                        text: 'Recibe Bono: ${chofer.recibeBono ? 'Sí (10%)' : 'No'}',
                      ),
                      ResultLabel(
                        text: 'Sueldo por Hora: \$${chofer.sueldoPorHora.toStringAsFixed(2)}',
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Horas por Día:',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ...List.generate(6, (diaIndex) {
                        return ResultLabel(
                          text: '  ${dias[diaIndex]}: ${chofer.horasPorDia[diaIndex].toStringAsFixed(1)} horas',
                          fontSize: 12,
                        );
                      }),
                      const SizedBox(height: 10),
                      ResultLabel(
                        text: 'Total Horas Semanales: ${chofer.totalHorasSemanal.toStringAsFixed(1)} horas',
                        highlight: true,
                      ),
                      ResultLabel(
                        text: 'Sueldo Base: \$${chofer.sueldoSemanal.toStringAsFixed(2)}',
                      ),
                      if (chofer.recibeBono)
                        ResultLabel(
                          text: 'Bono (10%): \$${chofer.montoBonoAdicional.toStringAsFixed(2)}',
                        ),
                      ResultLabel(
                        text: 'Sueldo Final: \$${chofer.sueldoFinal.toStringAsFixed(2)}',
                        highlight: true,
                        fontSize: 15,
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 24),

            // Reporte completo
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SelectableText(
                reporte,
                style: const TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 11,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Botones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Boton(
                    texto: 'Copiar Reporte',
                    onPressed: _copiarAlPortapapeles,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Boton(
                    texto: 'Volver',
                    onPressed: _volver,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
