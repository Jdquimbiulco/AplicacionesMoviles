import '../model/p5_promocion_model.dart';

class P5PromocionController {
  P5PromocionModel calcularPromociones(List<double> precios) {
    List<P5ArticuloModel> articulos = [];
    double totalOriginal = 0;
    double totalDescuento = 0;
    double totalPagar = 0;

    for (var precio in precios) {
      double porcentaje = 0.10; // Descuento por defecto (<= 100)
      if (precio >= 200) {
        porcentaje = 0.15;
      } else if (precio > 100) {
        porcentaje = 0.12;
      }

      double descuento = precio * porcentaje;
      double finalPrecio = precio - descuento;

      articulos.add(P5ArticuloModel(
        precioOriginal: precio,
        porcentajeDescuento: porcentaje,
        montoDescuento: descuento,
        precioFinal: finalPrecio,
      ));

      totalOriginal += precio;
      totalDescuento += descuento;
      totalPagar += finalPrecio;
    }

    return P5PromocionModel(
      articulos: articulos,
      totalOriginal: totalOriginal,
      totalDescuento: totalDescuento,
      totalPagar: totalPagar,
    );
  }
}
