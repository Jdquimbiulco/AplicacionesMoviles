import 'package:flutter/material.dart';
import '../atoms/text_field_atom.dart';
import '../atoms/label_atom.dart';

class ConsumoInputMolecule extends StatefulWidget {
  final TextEditingController consumoController;

  const ConsumoInputMolecule({
    Key? key,
    required this.consumoController,
  }) : super(key: key);

  @override
  State<ConsumoInputMolecule> createState() => _ConsumoInputMoleculeState();
}

class _ConsumoInputMoleculeState extends State<ConsumoInputMolecule> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LabelAtom(
          text: 'Consumo o Valor del Servicio',
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 12.0),
        TextFieldAtom(
          label: 'Ingrese el consumo (cantidad o valor)',
          controller: widget.consumoController,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}