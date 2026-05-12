import 'package:flutter/material.dart';

// ÁTOMO: Selector simple (Dropdown)
// Componente genérico para seleccionar entre múltiples opciones
// Se usa para tipos de vehículo, lavado y servicios adicionales
class SelectorSimple<T> extends StatelessWidget {
  const SelectorSimple({
    super.key,
    required this.valor,
    required this.items,
    required this.onChanged,
    required this.label,
  });

  final T valor;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: valor,
          items: items,
          isExpanded: true,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
