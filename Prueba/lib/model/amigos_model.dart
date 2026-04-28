class AmigosModel {
  static List<int> divisoresPropios(int numero) {
    if (numero <= 1) {
      return [];
    }

    final divisores = <int>[1];

    for (int divisor = 2; divisor * divisor <= numero; divisor++) {
      if (numero % divisor == 0) {
        divisores.add(divisor);

        final complemento = numero ~/ divisor;
        if (complemento != divisor && complemento != numero) {
          divisores.add(complemento);
        }
      }
    }

    divisores.sort();
    return divisores;
  }

  static int sumarDivisoresPropios(int numero) {
    return divisoresPropios(numero).fold(0, (suma, divisor) => suma + divisor);
  }

  static Map<String, dynamic> verificarNumerosAmigos(int a, int b) {
    final sumaA = sumarDivisoresPropios(a);
    final sumaB = sumarDivisoresPropios(b);
    final divisoresA = divisoresPropios(a);
    final divisoresB = divisoresPropios(b);

    return {
      'sumaA': sumaA,
      'sumaB': sumaB,
      'divisoresA': divisoresA,
      'divisoresB': divisoresB,
      'sonAmigos': sumaA == b && sumaB == a,
    };
  }
}
