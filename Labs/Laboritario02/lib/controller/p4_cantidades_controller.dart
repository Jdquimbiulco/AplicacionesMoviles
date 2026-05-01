import '../model/p4_cantidades_model.dart';

class P4CantidadesController {
  P4CantidadesModel analizarCantidades(List<double> cantidades) {
    int mayores = 0;
    int menores = 0;
    int ceros = 0;

    for (var cantidad in cantidades) {
      if (cantidad > 0) {
        mayores++;
      } else if (cantidad < 0) {
        menores++;
      } else {
        ceros++;
      }
    }

    return P4CantidadesModel(
      mayoresACero: mayores,
      menoresACero: menores,
      ceros: ceros,
      total: cantidades.length,
    );
  }
}
