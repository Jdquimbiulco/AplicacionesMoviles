class Chofer {
  String nombre;
  double sueldoPorHora;
  List<double> horasPorDia; // Lunes a Sábado (6 días)
  bool esActivo;
  bool recibeBono;
  String tipoChofer; // "Turno Regular" o "Turno Nocturno"

  Chofer({
    required this.nombre,
    required this.sueldoPorHora,
    List<double>? horasPorDia,
    this.esActivo = true,
    this.recibeBono = false,
    this.tipoChofer = "Turno Regular",
  }) : horasPorDia = horasPorDia ?? [0, 0, 0, 0, 0, 0];

  // Calcula el total de horas trabajadas en la semana
  double get totalHorasSemanal {
    return horasPorDia.fold(0.0, (sum, horas) => sum + horas);
  }

  // Calcula el sueldo semanal base
  double get sueldoSemanal {
    return totalHorasSemanal * sueldoPorHora;
  }

  // Calcula el bono (10% si aplica)
  double get montoBonoAdicional {
    if (recibeBono) {
      return sueldoSemanal * 0.10;
    }
    return 0.0;
  }

  // Sueldo final con bono
  double get sueldoFinal {
    return sueldoSemanal + montoBonoAdicional;
  }

  // Obtiene el día con más horas (0-5 para Lunes-Sábado)
  int get diaMasHoras {
    int indice = 0;
    double maxHoras = horasPorDia[0];
    for (int i = 1; i < horasPorDia.length; i++) {
      if (horasPorDia[i] > maxHoras) {
        maxHoras = horasPorDia[i];
        indice = i;
      }
    }
    return indice;
  }

  @override
  String toString() {
    return 'Chofer(nombre: $nombre, sueldoPorHora: $sueldoPorHora, totalHoras: $totalHorasSemanal, sueldo: $sueldoFinal)';
  }
}
