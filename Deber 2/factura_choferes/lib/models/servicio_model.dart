enum TipoServicio {
  agua,
  energia,
  internet,
  tvCable,
  otros,
}

class Servicio {
  final TipoServicio tipo;
  final String nombre;
  final double tarifa;

  Servicio({
    required this.tipo,
    required this.nombre,
    required this.tarifa,
  });

  static final List<Servicio> servicios = [
    Servicio(
      tipo: TipoServicio.agua,
      nombre: 'Agua Potable',
      tarifa: 15.0,
    ),
    Servicio(
      tipo: TipoServicio.energia,
      nombre: 'Energía Eléctrica',
      tarifa: 20.0,
    ),
    Servicio(
      tipo: TipoServicio.internet,
      nombre: 'Internet y Telefonía',
      tarifa: 35.0,
    ),
    Servicio(
      tipo: TipoServicio.tvCable,
      nombre: 'TV por Cable y Streaming',
      tarifa: 25.0,
    ),
    Servicio(
      tipo: TipoServicio.otros,
      nombre: 'Otros Pagos Frecuentes',
      tarifa: 0.0,
    ),
  ];

  static Servicio obtenerPorTipo(TipoServicio tipo) {
    return servicios.firstWhere((s) => s.tipo == tipo);
  }
}