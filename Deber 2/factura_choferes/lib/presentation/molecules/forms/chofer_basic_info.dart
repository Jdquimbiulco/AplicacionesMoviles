import 'package:flutter/material.dart';
import 'package:factura_choferes/presentation/atoms/inputs/text_input.dart';

class ChoferBasicInfo extends StatelessWidget {
  final TextEditingController nombreController;
  final TextEditingController sueldoController;

  const ChoferBasicInfo({
    Key? key,
    required this.nombreController,
    required this.sueldoController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInput(
          label: 'Nombre',
          hint: 'Ingrese el nombre del chofer',
          controller: nombreController,
          onChanged: (_) {},
        ),
        TextInput(
          label: 'Sueldo por Hora (\$)',
          hint: 'Ingrese el sueldo por hora',
          inputType: TextInputType.number,
          controller: sueldoController,
          onChanged: (_) {},
        ),
      ],
    );
  }
}
