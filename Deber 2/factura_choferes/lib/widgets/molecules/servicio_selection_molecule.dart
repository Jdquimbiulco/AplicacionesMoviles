import 'package:flutter/material.dart';
import '../../models/servicio_model.dart';
import '../atoms/radio_button_atom.dart';
import '../atoms/label_atom.dart';

class ServicioSelectionMolecule extends StatefulWidget {
  final TipoServicio servicioSeleccionado;
  final ValueChanged<TipoServicio> onChanged;

  const ServicioSelectionMolecule({
    Key? key,
    required this.servicioSeleccionado,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<ServicioSelectionMolecule> createState() =>
      _ServicioSelectionMoleculeState();
}

class _ServicioSelectionMoleculeState extends State<ServicioSelectionMolecule> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LabelAtom(
          text: 'Seleccione el Servicio',
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 12.0),
        ...Servicio.servicios.map((servicio) {
          return RadioButtonAtom<TipoServicio>(
            value: servicio.tipo,
            groupValue: widget.servicioSeleccionado,
            onChanged: (value) {
              if (value != null) {
                widget.onChanged(value);
              }
            },
            label: '${servicio.nombre} - \$${servicio.tarifa.toStringAsFixed(2)}/unidad',
          );
        }).toList(),
      ],
    );
  }
}