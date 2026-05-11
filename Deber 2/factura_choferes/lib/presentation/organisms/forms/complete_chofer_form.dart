import 'package:flutter/material.dart';
import 'package:factura_choferes/presentation/molecules/forms/chofer_basic_info.dart';
import 'package:factura_choferes/presentation/molecules/forms/chofer_hours_section.dart';
import 'package:factura_choferes/presentation/molecules/forms/chofer_options.dart';

class CompleteChoferForm extends StatelessWidget {
  final int choferIndex;
  final TextEditingController nombreController;
  final TextEditingController sueldoController;
  final List<TextEditingController> horasControllers;
  final bool esActivo;
  final bool recibeBono;
  final String tipoJornada;
  final Function(bool) onActivoChanged;
  final Function(bool) onBonoChanged;
  final Function(String) onJornadaChanged;

  const CompleteChoferForm({
    Key? key,
    required this.choferIndex,
    required this.nombreController,
    required this.sueldoController,
    required this.horasControllers,
    required this.esActivo,
    required this.recibeBono,
    required this.tipoJornada,
    required this.onActivoChanged,
    required this.onBonoChanged,
    required this.onJornadaChanged,
  }) : super(key: key);

  static const List<String> dias = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'];

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chofer ${choferIndex + 1}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 16),
            ChoferBasicInfo(
              nombreController: nombreController,
              sueldoController: sueldoController,
            ),
            ChoferHoursSection(
              horasControllers: horasControllers,
              dias: dias,
            ),
            const SizedBox(height: 8),
            ChoferOptions(
              esActivo: esActivo,
              recibeBono: recibeBono,
              tipoJornada: tipoJornada,
              onActivoChanged: onActivoChanged,
              onBonoChanged: onBonoChanged,
              onJornadaChanged: onJornadaChanged,
            ),
          ],
        ),
      ),
    );
  }
}
