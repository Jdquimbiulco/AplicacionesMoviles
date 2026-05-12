// Enum que define los tipos de vehículos que se pueden lavar
enum TipoVehiculo { auto, camioneta, moto }

// Enum que define los tipos de lavados disponibles
enum TipoLavado { basico, completo, premium }

// Enum que define los servicios adicionales opcionales
enum ServicioAdicional { ninguno, encerado, aspirado }

// Extensión para obtener etiqueta legible del tipo de vehículo
// Ejemplo: TipoVehiculo.auto.label() retorna "Auto"
extension TipoVehiculoExt on TipoVehiculo {
  String label() {
    switch (this) {
      case TipoVehiculo.auto:
        return 'Auto';
      case TipoVehiculo.camioneta:
        return 'Camioneta';
      case TipoVehiculo.moto:
        return 'Moto';
    }
  }
}

// Extensión para obtener etiqueta legible del tipo de lavado
extension TipoLavadoExt on TipoLavado {
  String label() {
    switch (this) {
      case TipoLavado.basico:
        return 'Básico';
      case TipoLavado.completo:
        return 'Completo';
      case TipoLavado.premium:
        return 'Premium';
    }
  }
}

// Extensión para obtener etiqueta legible del servicio adicional
extension ServicioAdicionalExt on ServicioAdicional {
  String label() {
    switch (this) {
      case ServicioAdicional.ninguno:
        return 'Ninguno';
      case ServicioAdicional.encerado:
        return 'Encerado';
      case ServicioAdicional.aspirado:
        return 'Aspirado';
    }
  }
}

// Modelo que guarda los datos de un servicio de lavado
// Incluye información del cliente, tipo de servicio y cálculos
class ServicioLavadoModelo {
  // Datos del cliente y tipo de servicio
  String nombreCliente;
  TipoVehiculo tipoVehiculo;
  TipoLavado tipoLavado;
  ServicioAdicional servicioAdicional;

  // Valores calculados (se asignan en el controlador)
  double subtotal;
  double iva;
  double total;

  ServicioLavadoModelo({
    this.nombreCliente = '',
    this.tipoVehiculo = TipoVehiculo.auto,
    this.tipoLavado = TipoLavado.basico,
    this.servicioAdicional = ServicioAdicional.ninguno,
    this.subtotal = 0.0,
    this.iva = 0.0,
    this.total = 0.0,
  });

  Map<String, dynamic> toMap() => {
    'nombreCliente': nombreCliente,
    'tipoVehiculo': tipoVehiculo.index,
    'tipoLavado': tipoLavado.index,
    'servicioAdicional': servicioAdicional.index,
    'subtotal': subtotal,
    'iva': iva,
    'total': total,
  };

  factory ServicioLavadoModelo.fromMap(Map<String, dynamic> m) =>
      ServicioLavadoModelo(
        nombreCliente: m['nombreCliente'] ?? '',
        tipoVehiculo: TipoVehiculo.values[m['tipoVehiculo'] ?? 0],
        tipoLavado: TipoLavado.values[m['tipoLavado'] ?? 0],
        servicioAdicional:
            ServicioAdicional.values[m['servicioAdicional'] ?? 0],
        subtotal: (m['subtotal'] ?? 0.0) + 0.0,
        iva: (m['iva'] ?? 0.0) + 0.0,
        total: (m['total'] ?? 0.0) + 0.0,
      );
}
