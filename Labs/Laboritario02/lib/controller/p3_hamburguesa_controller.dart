import '../model/p3_hamburguesa_model.dart';

class P3HamburguesaController {
  static const double precioSencilla = 20.0;
  static const double precioDoble = 25.0;
  static const double precioTriple = 28.0;
  static const double cargoTarjetaPorcentaje = 0.05;

  P3HamburguesaModel calcularCuenta({
    required int cantSencillas,
    required int cantDobles,
    required int cantTriples,
    required bool pagaConTarjeta,
  }) {
    double subtotal = (cantSencillas * precioSencilla) +
        (cantDobles * precioDoble) +
        (cantTriples * precioTriple);
    double cargoTarjeta = pagaConTarjeta ? (subtotal * cargoTarjetaPorcentaje) : 0.0;
    double total = subtotal + cargoTarjeta;

    return P3HamburguesaModel(
      subtotal: subtotal,
      cargoTarjeta: cargoTarjeta,
      total: total,
    );
  }
}
