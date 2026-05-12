import 'package:pry_themes/modelos/servicio_lavado_modelo.dart';

// Controlador que gestiona la lógica de negocio del lavado de autos
// Se encarga de: validación, cálculo de precios e IVA
class LavadoControlador {
  // Tasa de IVA: 15%
  static const double ivaRate = 0.15;

  // Simple prices using switch statements (easier to read for learning)
  // Obtiene el precio base según el tipo de lavado
  // Básico: $10, Completo: $15, Premium: $25
  double _precioBasePorTipo(TipoLavado tipo) {
    switch (tipo) {
      case TipoLavado.basico:
        return 10.0;
      case TipoLavado.completo:
        return 15.0;
      case TipoLavado.premium:
        return 25.0;
    }
  }

  // Obtiene el multiplicador de precio según el tipo de vehículo
  // Auto: 1.0x, Camioneta: 1.3x, Moto: 0.8x
  double _multiplicadorPorVehiculo(TipoVehiculo v) {
    switch (v) {
      case TipoVehiculo.auto:
        return 1.0;
      case TipoVehiculo.camioneta:
        return 1.3;
      case TipoVehiculo.moto:
        return 0.8;
    }
  }

  // Obtiene el precio del servicio adicional
  // Ninguno: $0, Encerado: $5, Aspirado: $3
  double _precioAdicional(ServicioAdicional s) {
    switch (s) {
      case ServicioAdicional.ninguno:
        return 0.0;
      case ServicioAdicional.encerado:
        return 5.0;
      case ServicioAdicional.aspirado:
        return 3.0;
    }
  }

  // Valida que el nombre del cliente no esté vacío
  // Retorna un mensaje de error si hay problemas, null si es válido
  String? validar(ServicioLavadoModelo s) {
    if (s.nombreCliente.trim().isEmpty) {
      return 'El nombre del cliente es requerido.';
    }
    return null;
  }

  // Calcula el subtotal, IVA y total del servicio
  // Fórmula:
  // 1. Precio base = precio del tipo de lavado * multiplicador del vehículo
  // 2. Subtotal = precio base + servicio adicional
  // 3. IVA = subtotal * 15%
  // 4. Total = subtotal + IVA
  void calcular(ServicioLavadoModelo s) {
    final base = _precioBasePorTipo(s.tipoLavado);
    final mult = _multiplicadorPorVehiculo(s.tipoVehiculo);
    final adicional = _precioAdicional(s.servicioAdicional);

    final precioBase = base * mult;
    final subtotal = precioBase + adicional;
    final iva = subtotal * ivaRate;
    final total = subtotal + iva;

    s.subtotal = double.parse(subtotal.toStringAsFixed(2));
    s.iva = double.parse(iva.toStringAsFixed(2));
    s.total = double.parse(total.toStringAsFixed(2));
  }
}
