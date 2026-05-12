import '../models/servicio_model.dart';
import '../models/pago_model.dart';

class PagoController {
  // Validar email
  bool validarEmail(String email) {
    final RegExp regex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return regex.hasMatch(email);
  }

  // Validar nombre
  bool validarNombre(String nombre) {
    return nombre.isNotEmpty && nombre.length >= 2;
  }

  // Validar apellido
  bool validarApellido(String apellido) {
    return apellido.isNotEmpty && apellido.length >= 2;
  }

  // Validar consumo
  bool validarConsumo(String consumo) {
    final double? valor = double.tryParse(consumo);
    return valor != null && valor > 0;
  }

  // Crear pago
  Pago crearPago({
    required String nombre,
    required String apellido,
    required String email,
    required TipoServicio tipoServicio,
    required String consumoStr,
    required bool tieneProntoPago,
    required bool tieneMora,
    required bool tieneServicioAdicional,
  }) {
    final double consumo = double.parse(consumoStr);
    final Servicio servicio = Servicio.obtenerPorTipo(tipoServicio);

    return Pago(
      nombre: nombre.trim(),
      apellido: apellido.trim(),
      email: email.trim(),
      servicio: servicio,
      consumo: consumo,
      tieneProntoPago: tieneProntoPago,
      tieneMora: tieneMora,
      tieneServicioAdicional: tieneServicioAdicional,
    );
  }

  // Validar formulario completo
  String? validarFormulario({
    required String nombre,
    required String apellido,
    required String email,
    required String consumo,
  }) {
    if (!validarNombre(nombre)) {
      return 'Ingrese un nombre válido (mínimo 2 caracteres)';
    }
    if (!validarApellido(apellido)) {
      return 'Ingrese un apellido válido (mínimo 2 caracteres)';
    }
    if (!validarEmail(email)) {
      return 'Ingrese un email válido';
    }
    if (!validarConsumo(consumo)) {
      return 'Ingrese un consumo válido (mayor a 0)';
    }
    return null;
  }
}