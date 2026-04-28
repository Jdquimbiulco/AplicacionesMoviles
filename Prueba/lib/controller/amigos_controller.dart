import 'package:flutter_application_4/model/amigos_model.dart';

class AmigosController {
  String procesarNumerosAmigos(String valorA, String valorB) {
    if (valorA.isEmpty || valorB.isEmpty) {
      return 'Por favor ingrese ambos números';
    }
    final int? a = int.tryParse(valorA);
    final int? b = int.tryParse(valorB);

    if (a == null || b == null) {
      return 'Por favor ingrese numeros validos';
    }

    if (a <= 0 || b <= 0) {
      return 'Ingrese números enteros positivos mayores que cero';
    }

    if (a == b) {
      return 'Los números amigos deben ser distintos';
    }

    final resultado = AmigosModel.verificarNumerosAmigos(a, b);
    final divisoresA = (resultado['divisoresA'] as List<int>).join(', ');
    final divisoresB = (resultado['divisoresB'] as List<int>).join(', ');

    if (resultado['sonAmigos'] == true) {
      return '$a y $b son números amigos.\n'
          'Divisores propios de $a: $divisoresA\n'
          'Suma de divisores propios de $a: ${resultado['sumaA']}\n'
          'Divisores propios de $b: $divisoresB\n'
          'Suma de divisores propios de $b: ${resultado['sumaB']}';
    }

    return '$a y $b no son números amigos.\n'
        'Divisores propios de $a: $divisoresA\n'
        'Suma de divisores propios de $a: ${resultado['sumaA']}\n'
        'Divisores propios de $b: $divisoresB\n'
        'Suma de divisores propios de $b: ${resultado['sumaB']}';
  }
}
