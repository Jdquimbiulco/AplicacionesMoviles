class P5ArticuloModel {
  final double precioOriginal;
  final double porcentajeDescuento;
  final double montoDescuento;
  final double precioFinal;

  P5ArticuloModel({
    required this.precioOriginal,
    required this.porcentajeDescuento,
    required this.montoDescuento,
    required this.precioFinal,
  });
}

class P5PromocionModel {
  final List<P5ArticuloModel> articulos;
  final double totalOriginal;
  final double totalDescuento;
  final double totalPagar;

  P5PromocionModel({
    required this.articulos,
    required this.totalOriginal,
    required this.totalDescuento,
    required this.totalPagar,
  });
}
