import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  final String label;
  final bool initialValue;
  final Function(bool) onChanged;

  const CustomCheckBox({
    Key? key,
    required this.label,
    this.initialValue = false,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = value ?? false;
            });
            widget.onChanged(_isChecked);
          },
          activeColor: Colors.deepPurple,
        ),
        Text(
          widget.label,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
