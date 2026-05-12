import 'package:flutter/material.dart';

class MainAppView extends StatelessWidget {
  const MainAppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deber 2 - Aplicaciones Móviles'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Seleccione una Aplicación',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.receipt_long, size: 30),
                  label: const Text(
                    'Pagos de Servicios Básicos',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    backgroundColor: Colors.blue.shade100,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/pagos/home');
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.directions_car, size: 30),
                  label: const Text(
                    'Factura de Pago a Choferes',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    backgroundColor: Colors.purple.shade100,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/choferes/home');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
