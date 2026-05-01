import '../model/p2_salario_model.dart';

class P2SalarioController {
  List<P2SalarioModel> calcularSalarios(double salarioInicial, int anios) {
    List<P2SalarioModel> historial = [];
    double salarioActual = salarioInicial;
    
    for (int i = 1; i <= anios; i++) {
      historial.add(P2SalarioModel(anio: i, monto: salarioActual));
      salarioActual = salarioActual + (salarioActual * 0.10);
    }
    
    return historial;
  }
}
