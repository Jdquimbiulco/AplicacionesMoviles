import 'package:flutter/material.dart';
import '../models/pago_model.dart';
import '../widgets/organisms/resumen_pago_organism.dart';

class ResumenPagoView extends StatelessWidget {
  const ResumenPagoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pago = ModalRoute.of(context)!.settings.arguments as Pago;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen del Pago'),
        centerTitle: true,
      ),
      body: ResumenPagoOrganism(
        pago: pago,
        onNuevoPago: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/',
                (route) => false,
          );
        },
      ),
    );
  }
}