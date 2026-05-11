import 'package:flutter/material.dart';

class CustomRadio extends StatefulWidget {
  final String label;
  final List<String> options;
  final String initialValue;
  final Function(String) onChanged;

  const CustomRadio({
    Key? key,
    required this.label,
    required this.options,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomRadio> createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        ...widget.options.map((option) {
          return Row(
            children: [
              Radio<String>(
                value: option,
                groupValue: _selectedValue,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value ?? widget.initialValue;
                  });
                  widget.onChanged(_selectedValue);
                },
                activeColor: Colors.deepPurple,
              ),
              Text(option),
            ],
          );
        }).toList(),
        const SizedBox(height: 16),
      ],
    );
  }
}
