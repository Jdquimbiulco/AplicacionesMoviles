class P1ProductoModel {
  final String nombre;
  final double precio;
  final int cantidad;

  P1ProductoModel({
    required this.nombre,
    required this.precio,
    required this.cantidad,
  });

  double get total => precio * cantidad;
}

class P1FacturaModel {
  final List<P1ProductoModel> productos;
  final double subtotal;
  final double descuento;
  final double iva;
  final double totalPagar;
  final double comision;
  final double sueldoFinalVendedor;

  P1FacturaModel({
    required this.productos,
    required this.subtotal,
    required this.descuento,
    required this.iva,
    required this.totalPagar,
    required this.comision,
    required this.sueldoFinalVendedor,
  });
}
