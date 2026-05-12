import 'servicio_model.dart';

class Pago {
  final String nombre;
  final String apellido;
  final String email;
  final Servicio servicio;
  final double consumo;
  final bool tieneProntoPago;
  final bool tieneMora;
  final bool tieneServicioAdicional;

  double get subtotal => consumo * servicio.tarifa;

  double get descuentoProntoPago {
    return tieneProntoPago ? subtotal * 0.10 : 0.0;
  }

  double get recargoMora {
    return tieneMora ? subtotal * 0.05 : 0.0;
  }

  double get montoServicioAdicional {
    return tieneServicioAdicional ? 5.0 : 0.0;
  }

  double get total {
    return subtotal - descuentoProntoPago + recargoMora + montoServicioAdicional;
  }

  Pago({
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.servicio,
    required this.consumo,
    this.tieneProntoPago = false,
    this.tieneMora = false,
    this.tieneServicioAdicional = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'apellido': apellido,
      'email': email,
      'servicio': servicio.nombre,
      'consumo': consumo,
      'subtotal': subtotal,
      'descuentoProntoPago': descuentoProntoPago,
      'recargoMora': recargoMora,
      'montoServicioAdicional': montoServicioAdicional,
      'total': total,
      'tieneProntoPago': tieneProntoPago,
      'tieneMora': tieneMora,
      'tieneServicioAdicional': tieneServicioAdicional,
    };
  }
}