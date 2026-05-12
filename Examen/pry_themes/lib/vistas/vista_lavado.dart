import 'package:flutter/material.dart';
import 'package:pry_themes/controladores/lavado_controlador.dart';
import 'moleculas/formulario_servicio.dart';

// PÁGINA / VISTA: Lavado (formulario)
// Pantalla inicial donde el usuario ingresa datos del lavado
// Ruta: /lavado
class VistaLavado extends StatelessWidget {
  const VistaLavado({super.key});

  @override
  Widget build(BuildContext context) {
    final controlador = LavadoControlador();

    return Scaffold(
      appBar: AppBar(title: const Text('Lavado de autos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: FormularioServicio(
            onSubmit: (servicio) {
              final err = controlador.validar(servicio);
              if (err != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(err)));
                return;
              }
              controlador.calcular(servicio);
              Navigator.pushNamed(context, '/notaVenta', arguments: servicio);
            },
          ),
        ),
      ),
    );
  }
}
