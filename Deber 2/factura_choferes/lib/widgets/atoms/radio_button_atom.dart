import 'package:flutter/material.dart';

class RadioButtonAtom<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final String label;

  const RadioButtonAtom({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<T>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        Expanded(
          child: Text(label),
        ),
      ],
    );
  }
}