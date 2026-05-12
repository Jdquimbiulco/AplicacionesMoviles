import 'package:flutter/material.dart';

// ÁTOMO: Etiqueta (Texto)
// Componente simple para mostrar texto (labels, valores en la nota de venta)
class Etiqueta extends StatelessWidget {
  const Etiqueta(this.texto, {super.key, this.style});

  final String texto;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(texto, style: style ?? const TextStyle(fontSize: 14));
  }
}
