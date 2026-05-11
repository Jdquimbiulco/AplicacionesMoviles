import 'package:flutter/material.dart';
import 'package:factura_choferes/presentation/atoms/inputs/text_input.dart';

class ChoferHoursSection extends StatelessWidget {
  final List<TextEditingController> horasControllers;
  final List<String> dias;

  const ChoferHoursSection({
    Key? key,
    required this.horasControllers,
    required this.dias,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Horas trabajadas por día:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        ...List.generate(dias.length, (index) {
          return TextInput(
            label: dias[index],
            hint: 'Horas',
            inputType: TextInputType.number,
            controller: horasControllers[index],
            onChanged: (_) {},
          );
        }),
      ],
    );
  }
}
