import 'package:flutter/material.dart';
import 'package:factura_choferes/presentation/atoms/checkboxes/custom_checkbox.dart';
import 'package:factura_choferes/presentation/atoms/radio/custom_radio.dart';

class ChoferOptions extends StatelessWidget {
  final bool esActivo;
  final bool recibeBono;
  final String tipoJornada;
  final Function(bool) onActivoChanged;
  final Function(bool) onBonoChanged;
  final Function(String) onJornadaChanged;

  const ChoferOptions({
    Key? key,
    required this.esActivo,
    required this.recibeBono,
    required this.tipoJornada,
    required this.onActivoChanged,
    required this.onBonoChanged,
    required this.onJornadaChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomCheckbox(
          label: 'Está activo',
          initialValue: esActivo,
          onChanged: onActivoChanged,
        ),
        CustomCheckbox(
          label: 'Recibe bono (10%)',
          initialValue: recibeBono,
          onChanged: onBonoChanged,
        ),
        const SizedBox(height: 12),
        CustomRadio(
          label: 'Tipo de Jornada',
          options: const ['Turno Regular', 'Turno Nocturno'],
          initialValue: tipoJornada,
          onChanged: onJornadaChanged,
        ),
      ],
    );
  }
}
