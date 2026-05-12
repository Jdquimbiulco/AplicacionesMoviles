import 'package:flutter/material.dart';
import '../models/servicio_model.dart';
import '../controllers/pago_controller.dart';
import '../models/pago_model.dart';
import '../widgets/organisms/formulario_pago_organism.dart';

class FormularioPagoView extends StatefulWidget {
  const FormularioPagoView({Key? key}) : super(key: key);

  @override
  State<FormularioPagoView> createState() => _FormularioPagoViewState();
}

class _FormularioPagoViewState extends State<FormularioPagoView> {
  final PagoController controller = PagoController();

  late String nombre;
  late String apellido;
  late String email;
  late TipoServicio tipoServicio;
  late String consumo;
  late bool tieneProntoPago;
  late bool tieneMora;
  late bool tieneServicioAdicional;

  @override
  void initState() {
    super.initState();
    nombre = '';
    apellido = '';
    email = '';
    tipoServicio = TipoServicio.agua;
    consumo = '';
    tieneProntoPago = false;
    tieneMora = false;
    tieneServicioAdicional = false;
  }

  void _calcular() {
    String? error = controller.validarFormulario(
      nombre: nombre,
      apellido: apellido,
      email: email,
      consumo: consumo,
    );

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error), backgroundColor: Colors.red),
      );
      return;
    }

    final pago = controller.crearPago(
      nombre: nombre,
      apellido: apellido,
      email: email,
      tipoServicio: tipoServicio,
      consumoStr: consumo,
      tieneProntoPago: tieneProntoPago,
      tieneMora: tieneMora,
      tieneServicioAdicional: tieneServicioAdicional,
    );

    Navigator.pushNamed(
      context,
      '/resumen',
      arguments: pago,
    );
  }

  void _limpiar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Formulario limpiado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Pago'),
        centerTitle: true,
      ),
      body: FormularioPagoOrganism(
        onCalcular: _calcular,
        onLimpiar: _limpiar,
        onCancelar: () {
          Navigator.pop(context);
        },
        onDatosChanged: (n, a, e, tipo, c, pp, m, sa) {
          nombre = n;
          apellido = a;
          email = e;
          tipoServicio = tipo;
          consumo = c;
          tieneProntoPago = pp;
          tieneMora = m;
          tieneServicioAdicional = sa;
        },
      ),
    );
  }
}