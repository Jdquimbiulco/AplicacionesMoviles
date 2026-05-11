import '../model/p1_problema_model.dart';

class P1ProblemaController {
  static const double ivaPorcentaje = 0.15;
  static const double descuentoPorcentaje = 0.20;
  static const double limiteDescuento = 2000.0;

  P1FacturaModel calcularVenta({
    required List<P1ProductoModel> productos,
    required double sueldoBaseVendedor,
    required double comisionVendedorPorcentaje,
  }) {
    double subtotal = 0;
    for (var p in productos) {
      subtotal += p.total;
    }

    double descuento = 0;
    // Si las compras superan $2000, se agrega un descuento del 20%
    if (subtotal > limiteDescuento) {
      descuento = subtotal * descuentoPorcentaje;
    }

    double subtotalConDescuento = subtotal - descuento;
    
    // Se debe calcular el IVA del 15% sobre lo que se va a cobrar
    double iva = subtotalConDescuento * ivaPorcentaje;
    double totalPagar = subtotalConDescuento + iva;

    // Calculamos el sueldo a ganar del vendedor (Sueldo base + comision por venta)
    // Asumiremos que la comisión es sobre el subtotal vendido (antes de descuentos o impuestos, que es lo estándar)
    double comision = subtotal * (comisionVendedorPorcentaje / 100);
    double sueldoFinal = sueldoBaseVendedor + comision;

    return P1FacturaModel(
      productos: productos,
      subtotal: subtotal,
      descuento: descuento,
      iva: iva,
      totalPagar: totalPagar,
      comision: comision,
      sueldoFinalVendedor: sueldoFinal,
    );
  }
}
