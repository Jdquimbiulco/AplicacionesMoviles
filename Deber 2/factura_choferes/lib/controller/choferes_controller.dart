import 'package:factura_choferes/model/choferes_model.dart';

class ChoferesController {
  static const int cantidadChoferes = 5;
  static const List<String> dias = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'];

  late List<Chofer> choferes;

  ChoferesController() {
    inicializarChoferes();
  }

  void inicializarChoferes() {
    choferes = List.generate(
      cantidadChoferes,
      (index) => Chofer(
        nombre: 'Chofer ${index + 1}',
        sueldoPorHora: 0,
        horasPorDia: [0, 0, 0, 0, 0, 0],
      ),
    );
  }

  // Actualiza los datos de un chofer
  void actualizarChofer(
    int index, {
    String? nombre,
    double? sueldoPorHora,
    List<double>? horasPorDia,
    bool? esActivo,
    bool? recibeBono,
    String? tipoChofer,
  }) {
    if (index >= 0 && index < choferes.length) {
      if (nombre != null) choferes[index].nombre = nombre;
      if (sueldoPorHora != null) choferes[index].sueldoPorHora = sueldoPorHora;
      if (horasPorDia != null) choferes[index].horasPorDia = horasPorDia;
      if (esActivo != null) choferes[index].esActivo = esActivo;
      if (recibeBono != null) choferes[index].recibeBono = recibeBono;
      if (tipoChofer != null) choferes[index].tipoChofer = tipoChofer;
    }
  }

  // Actualiza las horas de un día específico
  void actualizarHorasDia(int indexChofer, int indexDia, double horas) {
    if (indexChofer >= 0 && indexChofer < choferes.length &&
        indexDia >= 0 && indexDia < 6) {
      choferes[indexChofer].horasPorDia[indexDia] = horas;
    }
  }

  // Calcula el total general que pagará la empresa
  double getTotalGeneralNomina() {
    return choferes.fold(0.0, (sum, chofer) => sum + chofer.sueldoFinal);
  }

  // Obtiene el chofer que trabajó más horas el lunes (índice 0)
  String getChoferMasHorasLunes() {
    if (choferes.isEmpty) return 'N/A';

    Chofer choferMax = choferes[0];
    for (var chofer in choferes) {
      if (chofer.horasPorDia[0] > choferMax.horasPorDia[0]) {
        choferMax = chofer;
      }
    }
    return choferMax.nombre;
  }

  // Obtiene todas las horas trabajadas el lunes por todos los choferes
  double getTotalHorasLunes() {
    return choferes.fold(0.0, (sum, chofer) => sum + chofer.horasPorDia[0]);
  }

  // Genera un reporte con todos los datos
  String generarReporte() {
    StringBuffer reporte = StringBuffer();

    reporte.writeln('═══════════════════════════════════════════════════');
    reporte.writeln('           REPORTE DE NÓMINA SEMANAL');
    reporte.writeln('═══════════════════════════════════════════════════\n');

    for (int i = 0; i < choferes.length; i++) {
      Chofer chofer = choferes[i];
      reporte.writeln('Chofer ${i + 1}: ${chofer.nombre}');
      reporte.writeln('─────────────────────────────────────────────────');
      reporte.writeln('Tipo de Jornada: ${chofer.tipoChofer}');
      reporte.writeln('Estado: ${chofer.esActivo ? 'Activo' : 'Inactivo'}');
      reporte.writeln('Recibe Bono: ${chofer.recibeBono ? 'Sí' : 'No'}');
      reporte.writeln('Sueldo por Hora: \$${chofer.sueldoPorHora.toStringAsFixed(2)}');
      reporte.writeln('\nHoras por Día:');
      for (int j = 0; j < dias.length; j++) {
        reporte.writeln('  ${dias[j]}: ${chofer.horasPorDia[j].toStringAsFixed(1)} horas');
      }
      reporte.writeln('Total Horas Semanales: ${chofer.totalHorasSemanal.toStringAsFixed(1)} horas');
      reporte.writeln('Sueldo Base: \$${chofer.sueldoSemanal.toStringAsFixed(2)}');
      if (chofer.recibeBono) {
        reporte.writeln('Bono (10%): \$${chofer.montoBonoAdicional.toStringAsFixed(2)}');
      }
      reporte.writeln('Sueldo Final: \$${chofer.sueldoFinal.toStringAsFixed(2)}');
      reporte.writeln('\n');
    }

    reporte.writeln('═══════════════════════════════════════════════════');
    reporte.writeln('RESUMEN GENERAL');
    reporte.writeln('═══════════════════════════════════════════════════');
    reporte.writeln('Total a Pagar: \$${getTotalGeneralNomina().toStringAsFixed(2)}');
    reporte.writeln('Chofer con más horas el lunes: ${getChoferMasHorasLunes()}');
    reporte.writeln('Total de horas el lunes: ${getTotalHorasLunes().toStringAsFixed(1)} horas');

    return reporte.toString();
  }

  // Limpia todos los datos
  void limpiar() {
    inicializarChoferes();
  }

  // Obtiene un chofer específico
  Chofer? getChofer(int index) {
    if (index >= 0 && index < choferes.length) {
      return choferes[index];
    }
    return null;
  }

  // Obtiene la lista de todos los choferes
  List<Chofer> getChoferes() {
    return choferes;
  }
}
