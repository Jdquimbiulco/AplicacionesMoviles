import 'package:flutter/material.dart';
import 'package:factura_choferes/controllers/chofer_controller.dart';
import 'package:factura_choferes/presentation/organisms/forms/complete_chofer_form.dart';
import 'package:factura_choferes/presentation/atoms/buttons/primary_button.dart';
import 'package:factura_choferes/presentation/templates/base_template.dart';
import 'package:factura_choferes/config/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ChoferController controller;
  final List<List<TextEditingController>> horasControllers = [];
  final List<TextEditingController> nombreControllers = [];
  final List<TextEditingController> sueldoControllers = [];
  final List<bool> activoState = List.filled(5, true);
  final List<bool> bonoState = List.filled(5, false);
  final List<String> tipoJornadaState = List.filled(5, 'Turno Regular');

  @override
  void initState() {
    super.initState();
    controller = ChoferController();

    // Inicializar controladores de texto
    for (int i = 0; i < 5; i++) {
      nombreControllers.add(TextEditingController());
      sueldoControllers.add(TextEditingController());

      List<TextEditingController> horasChof = [];
      for (int j = 0; j < 6; j++) {
        horasChof.add(TextEditingController());
      }
      horasControllers.add(horasChof);
    }
  }

  @override
  void dispose() {
    for (var nombre in nombreControllers) {
      nombre.dispose();
    }
    for (var sueldo in sueldoControllers) {
      sueldo.dispose();
    }
    for (var horas in horasControllers) {
      for (var hora in horas) {
        hora.dispose();
      }
    }
    super.dispose();
  }

  void _registrarDatos() {
    try {
      for (int i = 0; i < 5; i++) {
        String nombre = nombreControllers[i].text.trim();
        if (nombre.isEmpty) {
          nombre = 'Chofer ${i + 1}';
        }

        double sueldo = 0;
        try {
          sueldo = double.parse(sueldoControllers[i].text.trim());
        } catch (e) {
          sueldo = 0;
        }

        List<double> horas = [];
        for (int j = 0; j < 6; j++) {
          try {
            horas.add(double.parse(horasControllers[i][j].text.trim()));
          } catch (e) {
            horas.add(0);
          }
        }

        controller.actualizarChofer(
          i,
          nombre: nombre,
          sueldoPorHora: sueldo,
          horasPorDia: horas,
          esActivo: activoState[i],
          recibeBono: bonoState[i],
          tipoChofer: tipoJornadaState[i],
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Datos registrados exitosamente')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar: $e')),
      );
    }
  }

  void _limpiar() {
    setState(() {
      for (var nombre in nombreControllers) {
        nombre.clear();
      }
      for (var sueldo in sueldoControllers) {
        sueldo.clear();
      }
      for (var horas in horasControllers) {
        for (var hora in horas) {
          hora.clear();
        }
      }
      activoState.fillRange(0, 5, true);
      bonoState.fillRange(0, 5, false);
      tipoJornadaState.fillRange(0, 5, 'Turno Regular');
      controller.limpiar();
    });
  }

  void _irAResultados() {
    _registrarDatos();
    Navigator.pushNamed(
      context,
      Routes.resultadoPage,
      arguments: controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseTemplate(
      title: 'Registro de Choferes',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ingrese los datos de los 5 choferes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            ...List.generate(5, (index) {
              return CompleteChoferForm(
                choferIndex: index,
                nombreController: nombreControllers[index],
                sueldoController: sueldoControllers[index],
                horasControllers: horasControllers[index],
                esActivo: activoState[index],
                recibeBono: bonoState[index],
                tipoJornada: tipoJornadaState[index],
                onActivoChanged: (value) {
                  setState(() {
                    activoState[index] = value;
                  });
                },
                onBonoChanged: (value) {
                  setState(() {
                    bonoState[index] = value;
                  });
                },
                onJornadaChanged: (value) {
                  setState(() {
                    tipoJornadaState[index] = value;
                  });
                },
              );
            }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: PrimaryButton(
                    label: 'Limpiar',
                    onPressed: _limpiar,
                    backgroundColor: Colors.orange,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: PrimaryButton(
                    label: 'Ver Resultado',
                    onPressed: _irAResultados,
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
