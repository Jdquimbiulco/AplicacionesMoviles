import 'package:flutter/material.dart';
import '../widgets/atoms/button_atom.dart';
import '../widgets/atoms/label_atom.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagos Servicios Básicos'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.receipt_long,
                size: 80.0,
                color: Colors.blue.shade300,
              ),
              const SizedBox(height: 24.0),
              const LabelAtom(
                text: 'Bienvenido',
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12.0),
              const LabelAtom(
                text: 'Gestione sus pagos de servicios básicos de forma rápida y sencilla',
                fontSize: 14.0,
                color: Colors.grey,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40.0),
              SizedBox(
                width: double.infinity,
                child: ButtonAtom(
                  label: 'Nuevo Pago',
                  onPressed: () {
                    Navigator.pushNamed(context, '/formulario');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                ),
              ),
              const SizedBox(height: 40.0),
              _buildInfo(
                icon: Icons.info_outline,
                titulo: 'Servicios Disponibles',
                descripcion: 'Agua, Energía, Internet, TV Cable y más',
              ),
              const SizedBox(height: 16.0),
              _buildInfo(
                icon: Icons.discount,
                titulo: 'Descuentos y Recargos',
                descripcion: 'Pronto pago, mora y servicios adicionales',
              ),
              const SizedBox(height: 16.0),
              _buildInfo(
                icon: Icons.summarize,
                titulo: 'Resumen Detallado',
                descripcion: 'Visualiza todos los detalles de tu pago',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfo({
    required IconData icon,
    required String titulo,
    required String descripcion,
  }) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue, size: 32.0),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelAtom(
                    text: titulo,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 4.0),
                  LabelAtom(
                    text: descripcion,
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}