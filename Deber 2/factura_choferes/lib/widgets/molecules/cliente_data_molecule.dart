import 'package:flutter/material.dart';
import '../atoms/text_field_atom.dart';
import '../atoms/label_atom.dart';

class ClienteDataMolecule extends StatefulWidget {
  final TextEditingController nombreController;
  final TextEditingController apellidoController;
  final TextEditingController emailController;

  const ClienteDataMolecule({
    Key? key,
    required this.nombreController,
    required this.apellidoController,
    required this.emailController,
  }) : super(key: key);

  @override
  State<ClienteDataMolecule> createState() => _ClienteDataMoleculeState();
}

class _ClienteDataMoleculeState extends State<ClienteDataMolecule> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LabelAtom(
          text: 'Datos del Cliente',
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 16.0),
        TextFieldAtom(
          label: 'Nombre',
          controller: widget.nombreController,
        ),
        const SizedBox(height: 12.0),
        TextFieldAtom(
          label: 'Apellido',
          controller: widget.apellidoController,
        ),
        const SizedBox(height: 12.0),
        TextFieldAtom(
          label: 'Email',
          controller: widget.emailController,
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}