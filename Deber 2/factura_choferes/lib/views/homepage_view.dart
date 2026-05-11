import 'package:flutter/material.dart';
import 'package:factura_choferes/controller/choferes_controller.dart';
import 'package:factura_choferes/widgets/textbox.dart';
import 'package:factura_choferes/widgets/boton.dart';
import 'package:factura_choferes/widgets/checkbox.dart';
import 'package:factura_choferes/widgets/radiobutton.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late ChoferesController controller;
  final List<List<TextEditingController>> horasControllers = [];
  final List<TextEditingController> nombreControllers = [];
  final List<TextEditingController> sueldoControllers = [];
  final List<bool> activoState = List.filled(5, true);
  final List<bool> bonoState = List.filled(5, false);
  final List<String> tipoJornadaState =
      List.filled(5, 'Turno Regular');

  @override
  void initState() {
    super.initState();
    controller = ChoferesController();

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
    Navigator.of(context).pushNamed('/resultado', arguments: controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Choferes'),
        backgroundColor: Colors.deepPurple,
      ),
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
              return _buildChoferForm(index);
            }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Boton(
                    texto: 'Limpiar',
                    onPressed: _limpiar,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Boton(
                    texto: 'Ver Resultado',
                    onPressed: _irAResultados,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChoferForm(int index) {
    const dias = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'];

    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chofer ${index + 1}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 16),
            TextBox(
              label: 'Nombre',
              hint: 'Ingrese el nombre del chofer',
              controller: nombreControllers[index],
              onChanged: (_) {},
            ),
            TextBox(
              label: 'Sueldo por Hora (\$)',
              hint: 'Ingrese el sueldo por hora',
              inputType: TextInputType.number,
              controller: sueldoControllers[index],
              onChanged: (_) {},
            ),
            const Text(
              'Horas trabajadas por día:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            ...List.generate(6, (diaIndex) {
              return TextBox(
                label: dias[diaIndex],
                hint: 'Horas',
                inputType: TextInputType.number,
                controller: horasControllers[index][diaIndex],
                onChanged: (_) {},
              );
            }),
            const SizedBox(height: 8),
            CustomCheckBox(
              label: 'Está activo',
              initialValue: activoState[index],
              onChanged: (value) {
                setState(() {
                  activoState[index] = value;
                });
              },
            ),
            CustomCheckBox(
              label: 'Recibe bono (10%)',
              initialValue: bonoState[index],
              onChanged: (value) {
                setState(() {
                  bonoState[index] = value;
                });
              },
            ),
            const SizedBox(height: 12),
            CustomRadioButton(
              label: 'Tipo de Jornada',
              options: const ['Turno Regular', 'Turno Nocturno'],
              initialValue: tipoJornadaState[index],
              onChanged: (value) {
                setState(() {
                  tipoJornadaState[index] = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
